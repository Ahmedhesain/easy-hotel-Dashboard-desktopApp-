import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
import 'package:toby_bills/app/data/model/item/dto/request/get_items_request.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/inventory/inventory_repository.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/item/item_repository.dart';

import '../../../data/model/invoice/dto/response/get_delivery_place_response.dart';

class HomeController extends GetxController {

  final isLoading = false.obs;
  final isProof = false.obs;
  final isItemProof = false.obs;
  final totalNet = RxNum(0.0);
  final discountHalala = RxNum(0.0);
  final discount = RxNum(0.0);
  final totalAfterDiscount = RxNum(0.0);
  final tax = RxNum(0.0);
  final finalNet = RxNum(0.0);
  final remain = RxNum(0.0);
  final itemAvailableQuantity = RxnNum();
  final itemNet = RxnNum();
  final itemDiscount = RxnNum();
  final itemQuantity = RxnNum();

  Rxn<DeliveryPlaceResposne> selectedDeliveryPlace = Rxn();
  Rxn<DelegatorResponse> selectedDelegator = Rxn();
  Rxn<String> selectedInvoiceType = Rxn("مبيعات");
  Rxn<int> selectedPriceType = Rxn(0);
  Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  Rxn<InventoryResponse> selectedInventory = Rxn();
  Rxn<ItemResponse> selectedItem = Rxn();
  FindCustomerBalanceResponse? findCustomerBalanceResponse;

  final findSideCustomerController = TextEditingController();
  final invoiceCustomerController = TextEditingController();
  final searchedInvoiceController = TextEditingController();
  final invoiceRemarkController = TextEditingController();
  final itemNameController = TextEditingController();
  final itemNotesController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final itemNumberController = TextEditingController();

  final findSideCustomerFieldFocusNode = FocusNode();
  final invoiceCustomerFieldFocusNode = FocusNode();
  final itemNameFocusNode = FocusNode();
  final itemNotesFocusNode = FocusNode();
  final itemPriceFocusNode = FocusNode();
  final itemQuantityFocusNode = FocusNode();
  final itemNumberFocusNode = FocusNode();

  final customers = <FindCustomerResponse>[];
  final deliveryPlaces = <DeliveryPlaceResposne>[];
  final delegators = <DelegatorResponse>[];
  final inventories = <InventoryResponse>[];
  final items = <ItemResponse>[];
  List<String> invoiceTypeList = ["مبيعات", "مانيكنات الفروع", "مانيكنات القماشين", "علاقات عامه", "تفصيل القماشين", "موظفي الفروع", "تعديلات", "اخري"];
  GetDueDateResponse? dueDate;
  InvoiceResponse? invoice;

  Map<int, String> priceTypes = {
    0: "اولادي",
    1: "رجالي",
  };


  @override
  void onInit() async {
    super.onInit();
    isLoading(true);
    await Future.wait([getDueDate(), getDeliveryPlaces(), getDelegators(), getInventories()])
        .whenComplete(() => isLoading(false));
    items.addAll(_getItemsFromStorage());
    if(items.isEmpty){
      getItems();
    }
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
        onSuccess: (data) => dueDate = data,
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
        onSuccess: (data) => delegators.assignAll(data),
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
          dueDate!.dueDate = data.dueDate;
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

  void selectItem(ItemResponse first) {

  }


  void selectInventory(InventoryResponse? value) {

  }

  addNewInvoiceDetail() {

  }

  void onChangeItemQuantity(String value) {
  }

  void onItemNumberFieldSubmitted(String value) {
  }
}
