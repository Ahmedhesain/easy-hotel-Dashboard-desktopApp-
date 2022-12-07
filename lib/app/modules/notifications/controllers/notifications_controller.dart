import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/general_journal/dto/request/find_general_journal_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/create_notifications_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_invoice_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/notifications/dto/request/delete_notification_request.dart';
import 'package:toby_bills/app/data/model/notifications/dto/request/find_notification_request.dart';
import 'package:toby_bills/app/data/model/notifications/dto/request/save_notification_request.dart';
import 'package:toby_bills/app/data/model/notifications/dto/response/find_notification_response.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/data/repository/general_journal/general_journal_repository.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/notifications/notifications_repository.dart';
import 'package:toby_bills/app/data/repository/notifications/notifications_repository.dart';

class NotificationsController extends GetxController {

  final isLoading = false.obs;
  final notificationType = 99.obs;
  final Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  final Rxn<FindCustomerResponse> searchSelectedCustomer = Rxn();
  final Rx<DateTime> date = Rx(DateTime.now());
  final customers = <FindCustomerResponse>[];
  final searchedCustomers = <FindCustomerResponse>[];
  final galleries = <GalleryResponse>[];
  final customerInvoices = <FindNotificationResponse>[];
  Rxn<GalleryResponse> selectedGallery = Rxn();
  Rxn<GalleryResponse> searchedSelectedGallery = Rxn();
  Rxn<InvoiceModel> invoice = Rxn();
  Rxn<FindNotificationResponse> notification = Rxn();
  final notifications = RxList<SaveNotificationRequest>();
  FindCustomerBalanceResponse? findCustomerBalanceResponse;
  final user = UserManager();
  final searchedInvoiceController = TextEditingController();
  final notificationNumberController = TextEditingController();
  final findSideCustomerController = TextEditingController();
  final searchHeaderCustomerController = TextEditingController();
  final customerInvoiceController = TextEditingController();
  final priceController = TextEditingController();
  final remarksController = TextEditingController();
  final findSideCustomerFieldFocusNode = FocusNode();
  final searchHeaderCustomerFieldFocusNode = FocusNode();
  final customerInvoiceFieldFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    getGalleries();
  }

  void getInvoiceListForCustomer(FindCustomerResponse value) {
    findSideCustomerController.text = "${value.name} ${value.code}";
    selectedCustomer(value);
    isLoading(true);
    CustomerRepository().findCustomerInvoicesData(
      FindCustomerBalanceRequest(id: value.id),
      onSuccess: (data) => findCustomerBalanceResponse = data,
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false),
    );
  }


  getCustomersByCode() {
    isLoading(true);
    findSideCustomerFieldFocusNode.unfocus();
    final request = FindCustomerRequest(code: findSideCustomerController.text, branchId: user.branchId, gallaryIdAPI: selectedGallery.value?.id);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          findSideCustomerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  getCustomersByCodeForSearch() {
    isLoading(true);
    searchHeaderCustomerFieldFocusNode.unfocus();
    final request = FindCustomerRequest(code: searchHeaderCustomerController.text, branchId: user.branchId, gallaryIdAPI: searchedSelectedGallery.value?.id);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          searchedCustomers.assignAll(data);
          searchHeaderCustomerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  getCustomerInvoices(){
    isLoading(true);
    final request = GetAllInvoiceRequest(branchId: user.branchId, organizationSiteId: searchSelectedCustomer.value?.id);
    NotificationsRepository().findAllInvoiceNotice(request,
      onSuccess: (data){
        customerInvoices.assignAll(data);
        customerInvoiceFieldFocusNode.requestFocus();
      },
      onComplete: () => isLoading(false));
  }

  searchForInvoiceById(String id) async {
    isLoading(true);
    await InvoiceRepository().findInvPurchaseInvoiceBySerialNew(GetInvoiceRequest(serial: id, branchId: user.branchId, gallaryId: null,typeInv: 4),
        onSuccess: (data) {
          invoice(data);
          searchedInvoiceController.text = data.serial?.toString() ?? "";
          priceController.text = data.remain?.toString()??"";
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }


  newInvoice({bool clearList = true}) {
    date(DateTime.now());
    selectedCustomer.value = null;
    invoice.value = null;
    notification.value = null;
    if(galleries.isNotEmpty && clearList) selectedGallery(galleries.first);
    searchedInvoiceController.clear();
    findSideCustomerController.clear();
    priceController.clear();
    remarksController.clear();
    if(clearList){
      notifications.clear();
    }
  }

  Future<void> getGalleries() {
    isLoading(true);
    return InvoiceRepository().getGalleries(
      GalleryRequest(branchId: user.branchId, id: user.id),
      onSuccess: (data) {
        galleries.assignAll(data);
        if(galleries.any((element) => element.id == user.galleryId)){
          selectedGallery(galleries.singleWhere((element) => element.id == user.galleryId));
        } else if (galleries.isNotEmpty) {
          selectedGallery(galleries.first);
        }
      },
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false)
    );
  }

  searchByNotification() {
    isLoading(true);
    final request = FindNotificationRequest(branchId: user.branchId, typeNotice: notificationType.value, serial: customerInvoiceController.text.tryToParseToNum?.toInt()??0);
    NotificationsRepository().findInvoiceNotice(request,
      onSuccess: (data){
        notification(data);
        searchedInvoiceController.text = data.invInvoiceSerial?.toString()??"";
        findSideCustomerController.text = "${data.organizationSiteName} ${data.organizationSiteCode}";
        priceController.text = data.value?.toString()??"";
        remarksController.text = data.remark?.toString()??"";
        notificationType(data.typeNotice);
        if(galleries.any((element) => element.id == data.gallaryId)){
          selectedGallery(galleries.singleWhere((element) => element.id == data.gallaryId));
        }
      },
        onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false)
    );
  }

  saveNotification(){
    isLoading(true);
    NotificationsRepository().saveInvoiceNoticeList(CreateNotificationRequest(notifications),
      onSuccess: (data) {
      newInvoice();
        showPopupText(text: "تم الحفظ بنجاح",type: MsgType.success);
      },
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false)
    );
  }

  addNotification(){
    if(notificationType.value == 99){
      showPopupText(text:"يجب اختيار نوع الاشعار");
      return ;
    }
    final item = SaveNotificationRequest(
        serial: notification.value?.serial,
        typeNotice: notificationType.value,
        generalJournalId: notification.value?.generalJournalId,
        branchId: user.branchId,
        id: notification.value?.id,
        organizationSiteName: notification.value?.organizationSiteName ?? selectedCustomer.value?.name,
        value: priceController.text.tryToParseToNum?.toDouble(),
        companyId: user.companyId,
        createdBy: user.id,
        createdDate: notification.value?.createdDate,
        date: date.value,
        invInvoice: notification.value?.invInvoice ?? invoice.value?.id,
        invInvoiceSerial: notification.value?.invInvoiceSerial ?? invoice.value?.serial,
        gallaryId: selectedGallery.value?.id,
        organizationSiteId: notification.value?.organizationSiteId ?? selectedCustomer.value?.id,
        remark: remarksController.text
    );

    notifications.add(item);
    notificationType(99);
    newInvoice(clearList: false);
  }

  printGeneralJournal(BuildContext context){
    isLoading(true);
    GeneralJournalRepository().findGeneralJournalById(FindGeneralJournalRequest(notification.value!.generalJournalId),
        onSuccess: (data) {
          PrintingHelper().printGeneralJournal(data, context);
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));

  }

  deleteNotification() {
    final request = DeleteNotificationRequest(notification.value!.id!);
    isLoading(true);
    NotificationsRepository().deleteInvoiceNotice(request,
        onSuccess: (_) {
          showPopupText(text: "تم الحذف بنجاح",type: MsgType.success);
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }
}
