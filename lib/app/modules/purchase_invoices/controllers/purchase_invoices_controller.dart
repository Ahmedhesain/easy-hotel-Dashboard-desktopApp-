import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toby_bills/app/core/extensions/num_extension.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/app_storage.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/create_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/general_journal/dto/request/find_general_journal_request.dart';
import 'package:toby_bills/app/data/model/general_journal/genraljournal.dart';
import 'package:toby_bills/app/data/model/inventory/dto/request/get_inventories_request.dart';
import 'package:toby_bills/app/data/model/inventory/dto/response/inventory_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/create_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delegator_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_due_date_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gl_account_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delegator_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_due_date_response.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_item_price_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_items_request.dart';
import 'package:toby_bills/app/data/model/item/dto/request/item_data_request.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_data_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/provider/local_provider.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/general_journal/general_journal_repository.dart';
import 'package:toby_bills/app/data/repository/inventory/inventory_repository.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/item/item_repository.dart';

import '../../../core/enums/toast_msg_type.dart';
import '../../../core/values/app_constants.dart';
import '../../../data/model/invoice/dto/response/get_delivery_place_response.dart';

class PurchaseInvoicesController extends GetxController {

  final isLoading = false.obs;
  final isProof = false.obs;
  final checkSendSms = false.obs;
  final isItemProof = false.obs;
  final isItemRemains = false.obs;
  final isAddedTax = true.obs;
  final totalNet = RxNum(0.0);
  final totalAfterDiscount = RxNum(0.0);
  final tax = RxNum(0.0);
  final finalNet = RxNum(0.0);
  final remain = RxNum(0.0);
  final itemAvailableQuantity = RxnNum();
  final itemNet = RxnNum();
  final itemTotalQuantity = RxnNum();
  num itemNetWithoutDiscount = 0;
  String? offerCoupon;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Rxn<DelegatorResponse> selectedDelegator = Rxn();
  Rxn<int> selectedDiscountType = Rxn(1);
  Rxn<GalleryResponse> selectedGallery = Rxn();
  Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  Rxn<GlAccountResponse> selectedGlAccount = Rxn();
  Rxn<InventoryResponse> selectedInventory = Rxn();
  Rxn<ItemResponse> selectedItem = Rxn();
  Rx<DateTime> dueDate = Rx(DateTime.now());
  Rx<DateTime> supplierDate = Rx(DateTime.now());
  FindCustomerBalanceResponse? findCustomerBalanceResponse;

  final findSideCustomerController = TextEditingController();
  final searchedInvoiceController = TextEditingController();
  final invoiceCustomerController = TextEditingController();
  final itemGlAccountController = TextEditingController();
  final invoiceDiscountController = TextEditingController();
  final invoiceRemarkController = TextEditingController();
  final invoiceSupplierNumberController = TextEditingController();
  final itemNameController = TextEditingController();
  // final itemNotesController = TextEditingController();
  final itemPriceController = TextEditingController();
  // final itemQuantityController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final itemYardNumberController = TextEditingController();
  final itemDiscountController = TextEditingController();
  // final itemDiscountValueController = TextEditingController();

  final findSideCustomerFieldFocusNode = FocusNode();
  final invoiceCustomerFieldFocusNode = FocusNode();
  final invoiceDiscountFieldFocusNode = FocusNode();
  final itemNameFocusNode = FocusNode();
  final itemNotesFocusNode = FocusNode();
  final itemPriceFocusNode = FocusNode();
  final itemGlAccountFocusNode = FocusNode();
  // final itemNumberFocusNode = FocusNode();
  final itemQuantityFocusNode = FocusNode();
  final itemYardNumberFocusNode = FocusNode();
  final itemDiscountFocusNode = FocusNode();
  // final itemDiscountValueFocusNode = FocusNode();

  final suppliers = <FindCustomerResponse>[];
  final deliveryPlaces = <DeliveryPlaceResposne>[];
  final delegators = <DelegatorResponse>[];
  final inventories = <InventoryResponse>[];
  final items = <ItemResponse>[];
  final galleries = <GalleryResponse>[];
  final glAccounts = <GlAccountResponse>[];
  final invoiceDetails = <Rx<InvoiceDetailsModel>>[].obs;
  Rxn<InvoiceResponse> invoice = Rxn();

  Map<int, String> priceTypes = {
    1: "رجالي",
    0: "اولادي",
  };

  Map<int, String> discountType = {
    0: "قيمة",
    1: "نسبة",
  };

  static const getBuilderSerial = "getBuilderSerial";

  @override
  void onInit() async {
    super.onInit();
    isLoading(true);
    items.addAll(_getItemsFromStorage());
    if (items.isEmpty) {
      getItems();
    }
    Future.wait([getDelegators(), getInventories(), getGlAccounts()]).whenComplete(() => isLoading(false));
  }

  getSuppliersByCode()  => _getSuppliers(findSideCustomerFieldFocusNode);

  getCustomersByCodeForInvoice() => _getSuppliers(invoiceCustomerFieldFocusNode);

  _getSuppliers(FocusNode node){
    isLoading(true);
    node.unfocus();
    final request = FindCustomerRequest(code: invoiceCustomerController.text, branchId: UserManager().branchId);
    CustomerRepository().findSupplierByCode(request,
        onSuccess: (data) {
          suppliers.assignAll(data);
          node.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));

  }

  Future<void> getDelegators() {
    return InvoiceRepository().findDelegatorPurchaseByInventory(
      DelegatorRequest(branchId: UserManager().branchId),
      onSuccess: (data) => {delegators.assignAll(data), if (delegators.isNotEmpty) selectedDelegator(delegators.first)},
      onError: (error) => showPopupText(text: error.toString()),
    );
  }

  Future<void> getInventories() {
    return InventoryRepository().getAllInventories(GetInventoriesRequest(branchId: UserManager().branchId, id: UserManager().id),
        onSuccess: (data) {
          inventories.assignAll(data);
          if (inventories.isNotEmpty) {
            selectedInventory(inventories.first);
          }
        },
        onError: (error) => showPopupText(text: error.toString()));
  }

  Future<void> getGlAccounts() async {
    glAccounts.assignAll(LocalProvider().getGlAccounts());
    if(glAccounts.isEmpty) {
      return InvoiceRepository().getGlAccountList(GlAccountRequest(UserManager().branchId),
        onSuccess: (data) {
          glAccounts.assignAll(data);
          LocalProvider().saveGlAccounts(data);
        },
        onError: (error) => showPopupText(text: error.toString()));
    }
  }

  void createCustomer(CreateCustomerRequest newCustomer) {
    isLoading(true);
    CustomerRepository().createCustomer(newCustomer,
        onSuccess: (data) => selectedCustomer(data), onError: (error) => showPopupText(text: error.toString()), onComplete: () => isLoading(false));
  }

  void getInvoiceListForCustomer(FindCustomerResponse value) {
    findSideCustomerController.text = "${value.name} ${value.code}";
    isLoading(true);
    CustomerRepository().findCustomerInvoicesData(FindCustomerBalanceRequest(id: value.id),
        onSuccess: (data) => findCustomerBalanceResponse = data, onError: (error) => showPopupText(text: error.toString()), onComplete: () => isLoading(false));
  }



  printInvoice(BuildContext context){
    isLoading(true);
    InvoiceRepository().findInvPurchaseInvoiceBySerialNew(GetInvoiceRequest(serial: invoice.value!.serial.toString(), branchId: UserManager().branchId, gallaryId: null, typeInv: 0),
        onSuccess: (data) {
          PrintingHelper().printPurchaseInvoice(
            context,
            data,
            dariba: data.taxvalue,
            total: data.finalNet,
            discount: data.discount,
            value: data.totalNet,
          );
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));

  }

  printGeneralJournal(BuildContext context){
    isLoading(true);
    GeneralJournalRepository().findGeneralJournalById(FindGeneralJournalRequest(invoice.value!.generalJournalId),
        onSuccess: (data) {
          PrintingHelper().printGeneralJournal(data, context);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));

  }

  searchForInvoiceById(String id) async {
    newInvoice();
    isLoading(true);
    await InvoiceRepository().findInvPurchaseInvoiceBySerialNew(GetInvoiceRequest(serial: id, branchId: UserManager().branchId, gallaryId: null, typeInv: 0),
        onSuccess: (data) {
          invoice(data);
          if(galleries.any((element) => element.id == data.gallaryId)) {
            selectedGallery(galleries.singleWhere((element) => element.id == data.gallaryId));
            UserManager().changeGallery(selectedGallery.value);
          } else {
            selectedGallery.value = null;
          }
          if (delegators.any((element) => element.id == data.invDelegatorId)) {
            selectedDelegator(delegators.singleWhere((element) => element.id == data.invDelegatorId));
          } else {
            selectedDelegator(null);
          }
          isProof(data.proof == 1);
          invoiceDiscountController.text = data.discount.toString();
          selectedDiscountType(data.discountType);
          invoiceSupplierNumberController.text = data.supplierInvoiceNumber?.toString()??"";
          checkSendSms(data.checkSendSms == 1);
          invoiceRemarkController.text = data.remarks??"";
          for (final detail in data.invoiceDetailApiList!) {
            if(!items.any((element) => element.id == detail.itemId)){
              showPopupText(text: "يرجى عمل تحديث ثم البحث عن الفاتورة مرة اخرى");
              return;
            }
            final item = items.singleWhere((element) => element.id == detail.itemId);
            detail.maxPriceMen = item.maxPriceMen;
            detail.maxPriceYoung = item.maxPriceYoung;
            detail.minPriceMen = item.minPriceMen;
            detail.minPriceYoung = item.minPriceYoung;
          }
          invoiceDetails.assignAll((data.invoiceDetailApiList ?? []).map((e) => Rx(e..typeInv = 0)).toList().obs);
          selectedCustomer(FindCustomerResponse(
            id: data.customerId,
            mobile: data.customerMobile,
            name: data.customerName,
            code: data.customerCode,
            balanceLimit: data.customerBalance,
            email: data.customerEmail,
            shoulder: data.shoulder,
            step: data.step,
            length: data.length,
          ));
          invoiceCustomerController.text = "${data.customerName} ${data.customerCode}";
          calcInvoiceValues();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  getCustomerBalance(int id) {
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

  getItems() {
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
    return items.where((element) => element.code.toString().contains(filter) || element.name.toString().contains(filter)).toList();
  }

  _clearItemFields() {
    selectedItem.value = null;
    itemNameController.clear();
    itemQuantityController.clear();
    itemGlAccountController.clear();
    itemYardNumberController.clear();
    // itemQuantityController.clear();
    itemPriceController.clear();
    // itemNotesController.clear();
    itemDiscountController.clear();
    // itemDiscountValueController.clear();
    isItemProof(false);
    isItemRemains(false);
    itemAvailableQuantity.value = null;
    itemNet.value = null;
    itemTotalQuantity.value = null;
    selectedInventory(inventories.first);
  }

  selectItem(ItemResponse item, {void Function()? noQuantity}) {
    itemNameFocusNode.unfocus();
    selectedItem(item);
    itemNameController.text = "${item.name} ${item.code}";
    itemQuantityController.text = "0";
    itemPriceController.text = "0";
    itemDiscountController.text = "0";
    Future.delayed(const Duration(milliseconds: 100)).whenComplete(() => itemYardNumberFocusNode.requestFocus());
    calcItemData();
  }

  calcItemData() {
    final quantity = itemQuantityController.text.parseToNum;
    final price = itemPriceController.text.parseToNum;
    itemNetWithoutDiscount = (price * quantity).fixed(2);
    final discount = itemDiscountController.text.tryToParseToNum ?? 0;
    itemNet((itemNetWithoutDiscount - (itemNetWithoutDiscount * (discount / 100))).fixed(2));
  }

  selectInventory(InventoryResponse? value) {
    final oldInv = selectedInventory.value;
    selectedInventory(value);
    if (selectedItem.value != null && selectedItem.value!.isInventoryItem == 1) {
      // _getItemPrice();
      selectItem(
        selectedItem.value!,
        noQuantity: () {
          showPopupText(text: "لايوجد كمية متاخة في المستودع المحدد");
          selectedInventory(oldInv);
        },
      );
    }
  }

  addNewInvoiceDetail() {
    if (selectedItem.value == null) return;
    final item = selectedItem.value!;
    final detail = InvoiceDetailsModel(
        progroupId: item.proGroupId,
        typeShow: item.typeShow,
        lastCost: item.lastCost,
        account: selectedGlAccount.value?.id,
        // remark: itemNotesController.text,
        name: item.name!,
        quantity: itemQuantityController.text.parseToNum,
        number: 1,
        quantityOfOneUnit: 1,
        code: item.code,
        minPriceMen: item.minPriceMen,
        minPriceYoung: item.minPriceYoung,
        maxPriceMen: item.maxPriceMen,
        maxPriceYoung: item.maxPriceYoung,
        // quantity: itemQuantityController.text.parseToNum,
        net: itemNet.value,
        availableQuantityRow: itemAvailableQuantity.value,
        price: itemPriceController.text.parseToNum,
        unitName: item.unitName,
        discount: itemDiscountController.text.parseToNum,
        typeInv: 0,
        // discountValue: itemDiscountValueController.text.parseToNum,
        inventoryName: selectedInventory.value!.name,
        inventoryCode: selectedInventory.value!.code,
        inventoryId: selectedInventory.value!.id,
        itemId: item.id,
        proof: isItemProof.value ? 1 : 0,
        netWithoutDiscount: itemNetWithoutDiscount
    ).obs;

    invoiceDetails.add(detail);
    calcInvoiceValues();
    _clearItemFields();
    itemNameFocusNode.requestFocus();
  }

  onItemNumberFieldSubmitted(String value) {
    // if (selectedItem.value != null && selectedItem.value!.proGroupId == 1) {
      itemPriceFocusNode.requestFocus();
    // } else {
    //   itemQuantityFocusNode.requestFocus();
    // }
  }

  saveInvoice() {
    if (invoiceDetails.isEmpty) {
      showPopupText(text: "يجب إضافة اصناف");
      return;
    }
    if (selectedCustomer.value == null) {
      showPopupText(text: "يجب إضافة مورد");
      return;
    }
    final isEdit = invoice.value != null;
    final request = CreateInvoiceRequest(
      id: invoice.value?.id,
      supplierDate: supplierDate.value,
      dueDate: dueDate.value,
      supplierInvoiceNumber: invoiceSupplierNumberController.text.tryToParseToNum?.toInt(),
      customerId: selectedCustomer.value?.id,
      customerCode: selectedCustomer.value?.code,
      customerMobile: selectedCustomer.value?.mobile,
      customerName: selectedCustomer.value?.name,
      finalNet: finalNet.value,
      gallaryName: UserManager().galleryName,
      branchId: UserManager().branchId,
      gallaryId: UserManager().galleryId,
      date: DateTime.now(),
      checkSendSms: checkSendSms.value ? 1 : 0,
      companyId: UserManager().companyId,
      createdBy: UserManager().id,
      createdDate: DateTime.now(),
      glPayDTOList: [],
      invDelegatorId: selectedDelegator.value?.id,
      invoiceDetailApiList: invoiceDetails.map((element) => element.value).toList(),
      invoiceDetailApiListDeleted: invoice.value?.invoiceDetailApiListDeleted.map((element) => element).toList(),
      typeInv: 0,
      proof: isProof.value ? 1 : 0,
      remarks: invoiceRemarkController.text,
      taxvalue: tax.value,
      totalNetAfterDiscount: totalAfterDiscount.value,
      offerCopoun: offerCoupon,
      serial: invoice.value?.serial,
      invInventoryId: 45,
      discount: invoiceDiscountController.text.tryToParseToNum,
      discountType: selectedDiscountType.value,
    );
    isLoading(true);
    InvoiceRepository().saveInvoice(request, onSuccess: (data) async {
      invoice(data);
    }, onError: (e) {
      showPopupText(text: e.toString());
      isLoading(false);
    },onComplete: () => isLoading(false));
  }

  newInvoice() {
    _clearItemFields();
    selectedDiscountType(discountType.keys.first);
    invoiceDiscountController.clear();
    selectedDelegator(delegators.first);
    isProof(false);
    checkSendSms(false);
    invoiceRemarkController.clear();
    invoiceSupplierNumberController.clear();
    selectedCustomer.value = null;
    invoiceDetails.clear();
    invoiceCustomerController.clear();
    calcInvoiceValues();
    invoice.value = null;
  }

  calcInvoiceValues() {
    num net = 0;
    for(final invoiceDetailsModel in invoiceDetails) {
      invoiceDetailsModel.value.calcData();
      net += invoiceDetailsModel.value.net!;
    }
    totalNet(net);
    num discount = 0;
    if (selectedDiscountType.value == 0) {
      discount = invoiceDiscountController.text.tryToParseToNum ?? 0;
    } else {
      discount = net * ((invoiceDiscountController.text.tryToParseToNum ?? 0) / 100);
    }
    totalAfterDiscount(net - discount);
    if(isAddedTax.value) {
      tax(totalAfterDiscount.value * 0.15);
    } else {
      tax(0);
    }
    finalNet((totalAfterDiscount.value + tax.value).fixed(2));
    // num payed = glPayDTOList.fold<num>(0, (p, e) => p+(e.value??0));
    num payed = 0;
    remain(finalNet.value - payed);
  }






}
