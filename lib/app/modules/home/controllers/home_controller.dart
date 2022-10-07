import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toby_bills/app/core/extensions/num_extension.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/app_storage.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/create_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/inventory/dto/request/get_inventories_request.dart';
import 'package:toby_bills/app/data/model/inventory/dto/response/inventory_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delegator_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_due_date_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delegator_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_due_date_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_invoice_reponse.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_item_price_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_items_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/item_data_request.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_data_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/inventory/inventory_repository.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/item/item_repository.dart';

import '../../../data/model/invoice/dto/response/get_delivery_place_response.dart';

class HomeController extends GetxController {

  final isLoading = false.obs;
  final isProof = false.obs;
  final checkSendSms = false.obs;
  final isItemProof = false.obs;
  final isItemRemains = false.obs;
  final totalNet = RxNum(0.0);
  final discountHalala = RxNum(0.0);
  final totalAfterDiscount = RxNum(0.0);
  final tax = RxNum(0.0);
  final finalNet = RxNum(0.0);
  final remain = RxNum(0.0);
  final itemAvailableQuantity = RxnNum();
  final itemNet = RxnNum();
  final itemTotalQuantity = RxnNum();
  num itemNetWithoutDiscount = 0;

  Rxn<DeliveryPlaceResposne> selectedDeliveryPlace = Rxn();
  Rxn<DelegatorResponse> selectedDelegator = Rxn();
  Rxn<String> selectedInvoiceType = Rxn("مبيعات");
  Rxn<int> selectedPriceType = Rxn(0);
  Rxn<int> selectedDiscountType = Rxn(0);
  Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  Rxn<InventoryResponse> selectedInventory = Rxn();
  Rxn<ItemResponse> selectedItem = Rxn();
  FindCustomerBalanceResponse? findCustomerBalanceResponse;

  final findSideCustomerController = TextEditingController();
  final searchedInvoiceController = TextEditingController();
  final invoiceCustomerController = TextEditingController();
  final invoiceDiscountController = TextEditingController();
  final invoiceRemarkController = TextEditingController();
  final itemNameController = TextEditingController();
  final itemNotesController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final itemNumberController = TextEditingController();
  final itemDiscountController = TextEditingController();
  final itemDiscountValueController = TextEditingController();

  final findSideCustomerFieldFocusNode = FocusNode();
  final invoiceCustomerFieldFocusNode = FocusNode();
  final invoiceDiscountFieldFocusNode = FocusNode();
  final itemNameFocusNode = FocusNode();
  final itemNotesFocusNode = FocusNode();
  final itemPriceFocusNode = FocusNode();
  final itemQuantityFocusNode = FocusNode();
  final itemNumberFocusNode = FocusNode();
  final itemDiscountFocusNode = FocusNode();
  final itemDiscountValueFocusNode = FocusNode();

  final customers = <FindCustomerResponse>[];
  final deliveryPlaces = <DeliveryPlaceResposne>[];
  final delegators = <DelegatorResponse>[];
  final inventories = <InventoryResponse>[];
  final items = <ItemResponse>[];
  final invoiceDetails = <Rx<InvoiceDetailsModel>>[].obs;
  List<String> invoiceTypeList = ["مبيعات", "مانيكنات الفروع", "مانيكنات القماشين", "علاقات عامه", "تفصيل القماشين", "موظفي الفروع", "تعديلات", "اخري"];
  Rxn<GetDueDateResponse> dueDate = Rxn();
  InvoiceResponse? invoice;

  Map<int, String> priceTypes = {
    0: "اولادي",
    1: "رجالي",
  };

  Map<int, String> discountType = {
    0: "قيمة",
    1: "نسبة",
  };


  @override
  void onInit() async {
    super.onInit();
    isLoading(true);
    _addItemFieldsListener();
    items.addAll(_getItemsFromStorage());
    if(items.isEmpty){
      getItems();
    }
    Future.wait([getDueDate(), getDeliveryPlaces(), getDelegators(), getInventories()])
        .whenComplete(() => isLoading(false));
  }

  getCustomersByCode() {
    isLoading(true);
    findSideCustomerFieldFocusNode.unfocus();
    final request = FindCustomerRequest(code: findSideCustomerController.text, branchId: UserManager().branchId, gallaryIdAPI: UserManager().galleryId);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          findSideCustomerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }



  getCustomersByCodeForInvoice() {
    isLoading(true);
    invoiceCustomerFieldFocusNode.unfocus();
    final request = FindCustomerRequest(code: invoiceCustomerController.text, branchId: UserManager().branchId, gallaryIdAPI: UserManager().galleryId);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          invoiceCustomerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  Future<void> getDueDate() => InvoiceRepository().findDueDateDTOAPI(
        GetDueDateRequest(branchId: UserManager().branchId, id: UserManager().id),
        onSuccess: (data) => dueDate(data),
        onError: (error) => showPopupText(text: error.toString()),
      );

  Future<void> getDeliveryPlaces() => InvoiceRepository().findInventoryByBranch(
        DeliveryPlaceRequest(branchId: UserManager().branchId, id: UserManager().id),
        onSuccess: (data) {
          deliveryPlaces.assignAll(data);
          if(deliveryPlaces.isNotEmpty) {
            selectedDeliveryPlace(deliveryPlaces.first);
          }
        },
        onError: (error) => showPopupText(text: error.toString()),
      );

  Future<void> getDelegators() => InvoiceRepository().findDelegatorByInventory(
        DelegatorRequest(gallaryId: UserManager().galleryId),
        onSuccess: (data) => {delegators.assignAll(data), if(delegators.isNotEmpty) selectedDelegator(delegators.first)},
        onError: (error) => showPopupText(text: error.toString()),
      );

  Future<void> getInventories() =>
      InventoryRepository().getAllInventories(GetInventoriesRequest(branchId: UserManager().branchId, id: UserManager().id),
          onSuccess: (data) {
            inventories.assignAll(data);
            if(inventories.isNotEmpty) {
              selectedInventory(inventories.first);
            }
          },
          onError: (error) => showPopupText(text: error.toString()));

  void createCustomer(CreateCustomerRequest newCustomer) {
    isLoading(true);
    CustomerRepository().createCustomer(newCustomer,
        onSuccess: (data) => selectedCustomer(data),
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  void getInvoiceListForCustomer(FindCustomerResponse value) {
    findSideCustomerController.text = "${value.name} ${value.code}";
    isLoading(true);
    CustomerRepository().findCustomerInvoicesData(FindCustomerBalanceRequest(id: value.id),
        onSuccess: (data) => findCustomerBalanceResponse = data,
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  void searchForInvoiceById(String id) {
    isLoading(true);
    InvoiceRepository().findInvPurchaseInvoiceBySerial(GetInvoiceRequest(serial: id, branchId: UserManager().branchId, gallaryId: UserManager().galleryId),
        onSuccess: (data) {
          invoice = data;
          selectedPriceType(data.pricetype);
          dueDate.value!.dueDate = data.dueDate;
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  void getCustomerBalance(int id) {
    isLoading(true);
    CustomerRepository().getCustomerBalance(FindCustomerBalanceRequest(id: id),
        onSuccess: (data) {
          selectedCustomer.value!.balanceLimit = data;
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }


  List<ItemResponse> _getItemsFromStorage() {
    List<dynamic> items = AppStorage.read("items") ?? [];
    final itemsList = List<ItemResponse>.from(items.map((e) => ItemResponse.fromJson(e)));
    return itemsList;
  }

  void getItems() {
    isLoading(true);
    ItemRepository().getAllItems(GetItemRequest(branchId: UserManager().branchId),
        onSuccess: (data) {
          items.assignAll(data);
          GetStorage().write("items", data.map((e) => e.toJson()).toList());
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  List<ItemResponse> filterItems(String filter) {
    return items.where((element) => element.code.toString().contains(filter) || element.name.toString().contains(filter) ).toList();
  }

  _clearItemFields(){
    selectedItem.value = null;
    itemNameController.clear();
    itemNumberController.clear();
    itemQuantityController.clear();
    itemPriceController.clear();
    itemNotesController.clear();
    itemDiscountController.clear();
    itemDiscountValueController.clear();
    isItemProof(false);
    isItemRemains(false);
    itemAvailableQuantity.value = null;
    itemNet.value = null;
    itemTotalQuantity.value = null;
    selectedInventory(inventories.first);
  }
  void selectItem(ItemResponse item) {
    if(selectedCustomer.value == null){
      showPopupText(text: "يرجى اختيار عميل أولاً");
      return;
    }
    if(selectedInventory.value == null){
      showPopupText(text: "يرجى اختيار مستودع أولاً");
      return;
    }
    getItemData(itemId: item.id,
        onSuccess: (data) {
          if(data.availableQuantity != null && data.availableQuantity == 0){
            showPopupText(text: "لا يوجد كمية متاحة");
            itemNameController.clear();
            itemNameFocusNode.requestFocus();
            return;
          }
          itemNameController.text = "${item.name} ${item.code}";
          if(data.availableQuantity != null){
            item.tempNumber = (data.availableQuantity! / data.quantityOfUnit).fixed(2);
          }
          itemNumberController.text = "1.0";
          itemQuantityController.text = data.quantityOfUnit.toString();
          // item.quantity = data.quantityOfUnit;
          itemPriceController.text = data.sellPrice.toString();
          itemDiscountController.text = data.discountRow.toString();
          itemDiscountValueController.text = "0";
          itemAvailableQuantity(data.availableQuantity);
          itemNumberFocusNode.requestFocus();
          selectedItem(item..itemData = data);
          calcItemData();
        });

  }

  getItemData({required int itemId,required void Function(ItemDataResponse itemDataResponse) onSuccess, int? inventoryId}) async {
    final customer = selectedCustomer.value!;
    if ((customer.step??-1) <= 0.0 && (customer.shoulder??-1) <= 0.0 && (customer.length??-1) <= 0.0) {
      showPopupText(text: "يجب تعديل بيانات العميل");
      return;
    }
    isLoading(true);
    final manager = UserManager();
    final request = ItemDataRequest(id: itemId, customerId: customer.id, priceType: selectedPriceType.value!, inventoryId: inventoryId ?? selectedInventory.value!.id, invNameGallary: manager.galleryType);
    await ItemRepository().getItemData(request,
        onSuccess: onSuccess,
        onError: (error) => {showPopupText(text: error.toString()),_clearItemFields()},
        onComplete: () => isLoading(false));
  }

  void calcItemData() {
    final number = itemNumberController.text.parseToNum;
    final quantity = itemQuantityController.text.parseToNum;
    itemTotalQuantity((quantity * number).fixed(2));
    itemNetWithoutDiscount = ((itemPriceController.text.parseToNum) * itemTotalQuantity.value!).fixed(2);
    final discount = itemDiscountController.text.tryToParseToNum ?? 0;
    final discountValue = itemDiscountValueController.text.tryToParseToNum ?? 0;
    itemNet((itemNetWithoutDiscount - (itemNetWithoutDiscount * (discount / 100)) - discountValue).fixed(2));
  }

  void selectInventory(InventoryResponse? value) {
    selectedInventory(value);
    if(selectedItem.value != null && selectedItem.value!.isInventoryItem == 1){
      // _getItemPrice();
      selectItem(selectedItem.value!);
    }
  }

  addNewInvoiceDetail() {
    if(selectedItem.value == null) return;
    final item = selectedItem.value!;
    final detail = InvoiceDetailsModel(
        progroupId: item.proGroupId,
        typeShow: item.typeShow,
        lastCost: item.lastCost,
        remark: itemNotesController.text,
        name: item.name,
        number: itemNumberController.text.parseToNum,
        quantityOfOneUnit: item.itemData?.quantityOfUnit,
        code: item.code,
        minPriceMen: item.minPriceMen,
        minPriceYoung: item.minPriceYoung,
        maxPriceMen: item.maxPriceMen,
        maxPriceYoung: item.maxPriceYoung,
        quantity: itemQuantityController.text.parseToNum,
        net: itemNet.value,
        availableQuantityRow: itemAvailableQuantity.value,
        price: itemPriceController.text.parseToNum,
        unitName: item.unitName,
        discount: itemDiscountController.text.parseToNum,
        discountValue: itemDiscountValueController.text.parseToNum,
        inventoryName: selectedInventory.value!.name,
        inventoryCode: selectedInventory.value!.code,
        inventoryId: selectedInventory.value!.id,
        itemId: item.id,
        proof: isItemProof.value ? 1 : 0,
        netWithoutDiscount: itemNetWithoutDiscount,
        isRemains: isItemRemains.value ? 1 : 0).obs;

      invoiceDetails.insert(0, detail);
      calcInvoiceValues();
      _clearItemFields();
      itemNameFocusNode.requestFocus();
  }

  _getItemPrice(){
    isLoading(true);
    final item = selectedItem.value!;
    final request = ItemPriceRequest(id: item.id,inventoryId: selectedInventory.value!.id,customerId: selectedCustomer.value!.id,priceType: selectedPriceType.value!,quantityOfUnit: itemQuantityController.text.parseToNum,invNameGallary: UserManager().galleryType);
    ItemRepository().getItemPrice(request,
      onSuccess: (data){
        selectedItem.value!.sellPrice = data.sellPrice;
        itemPriceController.text = data.sellPrice.toString();
        calcItemData();
      },
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false)
    );
  }

  void onItemNumberFieldSubmitted(String value) {
    if(selectedItem.value != null && selectedItem.value!.proGroupId == 1){
      itemPriceFocusNode.requestFocus();
    } else {
      itemQuantityFocusNode.requestFocus();

    }
  }

  saveInvoice() {

  }

  newInvoice() {
    _clearItemFields();
    selectedPriceType(priceTypes.keys.first);
    selectedDeliveryPlace(deliveryPlaces.first);
    selectedInvoiceType(invoiceTypeList.first);
    selectedDelegator(delegators.first);
    isProof(false);
    invoiceRemarkController.clear();
    selectedCustomer.value = null;
    invoiceDetails.clear();
    invoiceCustomerController.clear();
    calcInvoiceValues();
  }

  calcInvoiceValues(){
    num net = 0;
    for (final invoiceDetailsModel in invoiceDetails) {
      net += invoiceDetailsModel.value.net!;
    }
    totalNet(net);
    num discount = 0;
    if(selectedDiscountType.value == 0){
      discount = invoiceDiscountController.text.tryToParseToNum ?? 0;
    } else {
      discount = net * ((invoiceDiscountController.text.tryToParseToNum ?? 0) / 100);
    }
    totalAfterDiscount(net - discountHalala.value - discount);
    tax(totalAfterDiscount.value * 0.15);
    finalNet((totalAfterDiscount.value + tax.value ).fixed(2));
    // num payed = glPayDTOList.fold<num>(0, (p, e) => p+(e.value??0));
    num payed = 0;
    remain(finalNet.value - payed);
  }

  _addItemFieldsListener(){
    itemNumberFocusNode.addListener(_itemNumberListener);
    itemQuantityFocusNode.addListener(_itemQuantityListener);
    itemPriceFocusNode.addListener(_itemPriceListener);
  }

  _removeItemFieldsListener(){
    itemNumberFocusNode.removeListener(_itemNumberListener);
    itemQuantityFocusNode.removeListener(_itemQuantityListener);
    itemPriceFocusNode.removeListener(_itemPriceListener);
  }

  bool _isQuantityValid(){
    final number = itemNumberController.text.tryToParseToNum;
    final quantity = itemQuantityController.text.tryToParseToNum;
    if(number == null || quantity == null) return true;
    return !(itemAvailableQuantity.value != null && itemAvailableQuantity.value! < (number * quantity));
  }

  _itemNumberListener(){
    if(!itemNumberFocusNode.hasFocus){
      if(selectedItem.value == null || itemNumberController.text.tryToParseToNum == selectedItem.value!.tempNumber) return;
      if(!_isQuantityValid()){
        showPopupText(text: "لا يمكن ادخال هذا العدد");
        itemNumberController.text = selectedItem.value!.tempNumber.toString();
      } else {
        selectedItem.value!.tempNumber = itemNumberController.text.parseToNum;
      }
      // if(itemNumberController.text.tryToParseToNum != null) {
        itemTotalQuantity(itemNumberController.text.parseToNum * itemQuantityController.text.parseToNum);
      // }
      calcItemData();
    }
  }

  _itemQuantityListener(){
    if(!itemQuantityFocusNode.hasFocus){
      if(selectedItem.value == null || itemQuantityController.text.tryToParseToNum == selectedItem.value!.tempQuantity) return;
      if(!_isQuantityValid()){
        showPopupText(text: "لا يمكن ادخال هذه الكمية");
        itemQuantityController.text = selectedItem.value!.tempQuantity.toString();
      } else {
        if(selectedItem.value!.isInventoryItem == 1) {
          _getItemPrice();
        }
        selectedItem.value!.tempQuantity = itemQuantityController.text.parseToNum;
      }
      // if(itemQuantityController.text.tryToParseToNum != null) {
        itemTotalQuantity(itemNumberController.text.parseToNum * itemQuantityController.text.parseToNum);
      // }
      calcItemData();
    }
  }

  _itemPriceListener(){
    if(!itemPriceFocusNode.hasFocus){
      final price = itemPriceController.text.tryToParseToNum;
      if(price == null) return;
      final item = selectedItem.value!;
      if(selectedPriceType.value == 1 && price < item.minPriceMen!){
        showPopupText(text: "السعر غير ممكن");
        itemPriceController.text = item.minPriceMen.toString();
      } else if(selectedPriceType.value == 1 && price > item.maxPriceMen!){
        showPopupText(text: "السعر غير ممكن");
        itemPriceController.text = item.maxPriceMen.toString();
      } else if(selectedPriceType.value == 0 && price < item.minPriceYoung!){
        showPopupText(text: "السعر غير ممكن");
        itemPriceController.text = item.minPriceYoung.toString();
      } else if(selectedPriceType.value == 0 && price > item.maxPriceYoung!){
        showPopupText(text: "السعر غير ممكن");
        itemPriceController.text = item.maxPriceYoung.toString();
      }
    }

  }

  @override
  void onClose() {
    _removeItemFieldsListener();
    super.onClose();
  }

  void changePriceType(int? value) async {
    selectedPriceType(value);
    final details = <Rx<InvoiceDetailsModel>>[];
    for(final detail in invoiceDetails){
      final item = items.singleWhere((element) => element.id == detail.value.itemId);
      await getItemData(itemId: item.id, onSuccess: (itemData){
        item.itemData = itemData;
        final newDetail = detail.value.assignItem(item);
        details.add(Rx(newDetail));
      });
    }
    invoiceDetails.assignAll(details);
    calcInvoiceValues();
  }

}
