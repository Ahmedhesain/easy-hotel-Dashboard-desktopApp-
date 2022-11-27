import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/find_faseh_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/find_faseh_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/faseh_invoice_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/item/item_repository.dart';

class FasehDetailsController extends GetxController {
  final searchController = TextEditingController();
  final fasehSearchController = TextEditingController();
  final remarksController = TextEditingController();
  final itemCodeController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final galleryController = TextEditingController();
  final quantityFocus = FocusNode();
  final itemNameFocus = FocusNode();

  final isLoading = false.obs;
  final isSaved = false.obs;

  final galleries = <GalleryResponse>[];
  final items = RxList<ItemResponse>();
  final invoiceDetailsList = RxList<InvoiceDetailsModel>();
  FasehInvoiceResponse? findInvoiceModel;
  ItemResponse? _selectedItem;
  Rxn<InvoiceModel> invoiceModel = Rxn();
  final galleryName = "".obs;
  Rxn<DateTime> invoiceDate = Rxn();
  final customer = "".obs;

  @override
  onInit() {
    super.onInit();
    getItems();
  }


  getItems() {
    isLoading(true);
    ItemRepository()
        .getAllItemsLocal(onSuccess: items.assignAll, onError: (e) => showPopupText(text: e.toString()), onComplete: () => isLoading(false));
  }

  search() async {
    isLoading(true);
    InvoiceRepository().findFasehInvoice(FindFasehInvoiceRequest(invSerial: searchController.text),
        onSuccess: (data) {
          findInvoiceModel = data;
          galleryName(data.gallaryName);
          customer("${data.iosName} ${data.iosCode} ${data.iosMobile}");
          invoiceDate(data.invDate);
        },
        onComplete: () => isLoading(false),
        onError: (e) => showPopupText(text: e.toString()));
  }

  searchOnFaseh() async {
    isLoading(true);
    InvoiceRepository().findFasehBySerial(FindFasehRequest(serial: fasehSearchController.text),
        onSuccess: (data) {
          invoiceModel(data);
          invoiceDetailsList.assignAll(data.invoiceDetailApiList??[]);
          remarksController.text = data.remarks??"";
          galleryName(data.gallaryName);
          customer("${data.customerName} ${data.customerCode} ${data.customerMobile}");
          invoiceDate(data.date);
        },
        onComplete: () => isLoading(false),
        onError: (e) => showPopupText(text: e.toString()));
  }

  save() async {
    if (findInvoiceModel == null) {
      showPopupText(text: "يرجى اختيار فاتورة اولاً");
      return;
    }
    if (invoiceDetailsList.isEmpty) {
      showPopupText(text: "يرجى إدخال اصناف اولاً");
      return;
    }
    isLoading(true);
    final request = InvoiceModel(
      invoiceDetailApiList: invoiceDetailsList,
      remarks: remarksController.text,
      createdDate: DateTime.now(),
      date: DateTime.now(),
      branchId: UserManager().branchId,
      gallaryId: findInvoiceModel!.gallaryId,
      companyId: UserManager().companyId,
      createdBy: UserManager().id,
      customerCode: findInvoiceModel!.iosCode,
      invDelegatorId: findInvoiceModel!.delegatorId,
      customerId: findInvoiceModel!.iosId,
      customerName: findInvoiceModel!.iosName,
      customerMobile: findInvoiceModel!.iosMobile,
      supplierDate: findInvoiceModel!.invDate,
      invPurchaseInvoice: findInvoiceModel!.invId,
    );
    InvoiceRepository().saveFasehInvoice(request,
        onSuccess: (data) {
          request.serial = data;
          invoiceModel(request);
          isSaved(true);
          showPopupText(text: "تم الحفظ بنجاح", type: MsgType.success);
        },
        onError: (error) {
          showPopupText(text: error);
          invoiceModel.value = null;
        },
        onComplete: () => isLoading(false));
  }

  selectNewItem(ItemResponse item) async {
    itemCodeController.text = "${item.name!} ${item.code!}";
    itemQuantityController.text = "1";
    _selectedItem = item;
    await Future.delayed(const Duration(milliseconds: 100));
    quantityFocus.requestFocus();
  }

  addItem() {
    if (_selectedItem != null) {
      final model = InvoiceDetailsModel(
        code: _selectedItem!.code,
        itemId: _selectedItem!.id,
        unitId: _selectedItem!.unitId,
        name: _selectedItem!.name.toString(),
        quantityOfOneUnit: num.parse(itemQuantityController.text),
      );
      invoiceDetailsList.add(model);
      itemCodeController.clear();
      itemQuantityController.clear();
      if (quantityFocus.hasFocus) quantityFocus.unfocus();
      itemNameFocus.requestFocus();
    }
  }

  removeDetail(int index) {
    invoiceDetailsList.removeAt(index);
  }

  newInvoice() {
    _selectedItem = null;
    invoiceModel.value = null;
    findInvoiceModel = null;
    remarksController.clear();
    itemQuantityController.clear();
    searchController.clear();
    itemQuantityController.clear();
    invoiceDetailsList.clear();
    isSaved(false);
  }

  print(BuildContext context) {
    isLoading(true);
    InvoiceRepository().findFasehBySerial(FindFasehRequest(serial: fasehSearchController.text),
        onSuccess: (data) {
          PrintingHelper().fash(context, data.invoiceDetailApiList!, data);
        },
        onComplete: () => isLoading(false),
        onError: (e) => showPopupText(text: e.toString()));
  }
}
