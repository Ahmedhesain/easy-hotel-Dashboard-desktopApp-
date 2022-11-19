import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/faseh_invoice_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/item/item_repository.dart';

class FasehDetailsController extends GetxController {
  final searchController = TextEditingController();
  final remarksController = TextEditingController();
  final itemCodeController = TextEditingController();
  final itemNumberController = TextEditingController();
  final numberFocus = FocusNode();
  final itemNameFocus = FocusNode();

  final isLoading = false.obs;
  final isSaved = false.obs;

  final items = RxList<ItemResponse>();
  final invoiceDetailsList = RxList<InvoiceDetailsModel>();
  FasehInvoiceResponse? findInvoiceModel;
  ItemResponse? _selectedItem;
  InvoiceModel? invoiceModel;

  @override
  onInit() {
    super.onInit();
    getItems();
  }

  getItems() {
    isLoading(true);
    ItemRepository().getAllItemsLocal(onSuccess: items.assignAll, onError: (e) => showPopupText(text: e.toString()), onComplete: () => isLoading(false));
  }

  search() async {
    isLoading(true);
    InvoiceRepository().findFasehInvoice(GetInvoiceRequest(serial: searchController.text),
        onSuccess: (data) {
          findInvoiceModel = data;
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
    invoiceModel = InvoiceModel(
      invoiceDetailApiList: invoiceDetailsList,
      remarks: remarksController.text,
      createdDate: DateTime.now(),
      date: DateTime.now(),
      branchId: UserManager().branchId,
      gallaryId: UserManager().galleryId,
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
    InvoiceRepository().saveFasehInvoice(invoiceModel!,
        onSuccess: (data) {
          invoiceModel!.serial = data;
          showPopupText(text: "تم الحفظ بنجاح", type: MsgType.success);
        },
        onError: (error) {
          showPopupText(text: error);
          invoiceModel = null;
        },
        onComplete: () => isLoading(false));
  }

  selectNewItem(ItemResponse item) {
    itemCodeController.text = "${item.name!} ${item.code!}";
    itemNumberController.text = "1";
    numberFocus.requestFocus();
    _selectedItem = item;
  }

  addItem() {
    if (_selectedItem != null) {
      final model = InvoiceDetailsModel(
          code: _selectedItem!.code, itemId: _selectedItem!.id, unitId: _selectedItem!.unitId, name: _selectedItem!.name.toString(), quantity: num.parse(itemNumberController.text));
      invoiceDetailsList.add(model);
      itemCodeController.clear();
      itemNumberController.clear();
      if (numberFocus.hasFocus) numberFocus.unfocus();
      itemNameFocus.requestFocus();
    }
  }

  removeDetail(int index) {
    invoiceDetailsList.removeAt(index);
  }

  newInvoice() {
    _selectedItem = null;
    invoiceModel = null;
    findInvoiceModel = null;
    remarksController.clear();
    itemNumberController.clear();
    searchController.clear();
    itemNumberController.clear();
    invoiceDetailsList.clear();
    isSaved(false);
  }
}
