


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/data/model/crm_reports/dto/request/customers_report_request.dart';

import '../../../../core/enums/toast_msg_type.dart';
import '../../../../core/utils/show_popup_text.dart';
import '../../../../core/utils/user_manager.dart';
import '../../../../data/model/crm_reports/dto/company_dto.dart';
import '../../../../data/model/crm_reports/dto/customers_statue_dto.dart';
import '../../../../data/model/crm_reports/dto/request/send_msg_request.dart';
import '../../../../data/model/crm_reports/dto/response/customers_report_response.dart';
import '../../../../data/model/invoice/dto/request/gallery_request.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../../data/repository/crm_reports/crm_reports_repository.dart';
import '../../../../data/repository/invoice/invoice_repository.dart';

class CustomersController extends GetxController {
  final isLoading = false.obs ;

  final deliveryPlaces = <GalleryResponse>[].obs;
  RxList <GalleryResponse> selectedDeliveryPlace = RxList();
  RxList <CustomersReportResponse> reportList = RxList();
  RxList <CustomersReportResponse> selectedReportList = RxList();
  RxList <CustomersReportResponse> filteredReportList = RxList();
  final companiesList = <CompanyDTO>[].obs;

  RxList <CompanyDTO> selectedCompanies = RxList();
  final customerStatues = [
    CustomerStatueDTO(name: 'كل العملاء' , value: null),
    CustomerStatueDTO(name: 'العملاء غير المحظورين' , value: 0),
    CustomerStatueDTO(name: 'العملاء المحظورين' , value: 1),
  ];
   Rxn<int> selectedStatue = Rxn();
  final msgController = TextEditingController();
  @override
  onInit(){
    isLoading(true);
    super.onInit();
    Future.wait([ getDeliveryPlaces() ,getCompanies() ]).whenComplete(() => isLoading(false));
  }


  onSelect(bool? selected , CustomersReportResponse customer){
    if(selected  == true){
      selectedReportList.add(customer);
    }else{
      selectedReportList.remove(customer);
    }
    selectedReportList.refresh();
    reportList.refresh();
  }

  filter(String value) => reportList(List.from(filteredReportList.where((customer) => customer.clientCode.startsWith(value) || customer.clientMobile.startsWith(value) || customer.clientName.startsWith(value)))) ;
  Future<void> getDeliveryPlaces() {

    return InvoiceRepository().getGalleries(
      GalleryRequest(branchId: UserManager().branchId, id: UserManager().id),
      onSuccess: (data) {
        data.insert(0, GalleryResponse(name: "تحديد الكل"));
        deliveryPlaces.assignAll(data);
        selectNewDeliveryplace(["تحديد الكل"]);
        // if (deliveryPlaces.isNotEmpty) {
        //   // deliveryPlaces.insert(0, );
        //
        //   // selectedDeliveryPlace(deliveryPlaces.first);
        // }
      },
      onError: (error) => showPopupText(text: error.toString()),
    );
  }

  Future<void> getCompanies() {
    return CrmReportsRepository().getCompanyList(
      CompanyDTO(branchId: UserManager().branchId, companyId: UserManager().companyId),
      onSuccess: (data) {
        data.insert(0, CompanyDTO(name: "تحديد الكل"));
        companiesList.assignAll(data);
        selectNewCompanies(["تحديد الكل"]);
      },
      onError: (error) => showPopupText(text: error.toString()),
    );
  }


  selectNewDeliveryplace(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedDeliveryPlace.any((element) => element.name == "تحديد الكل")) {
      selectedDeliveryPlace.clear();
    } else if (!selectedDeliveryPlace.any((element) => element.name == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedDeliveryPlace.assignAll(deliveryPlaces);
    } else {
      if (values.length < selectedDeliveryPlace.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedDeliveryPlace.assignAll(deliveryPlaces.where((element) => values.contains(element.name)));
    }
  }

  selectNewCompanies(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedCompanies.any((element) => element.name == "تحديد الكل")) {
      selectedCompanies.clear();
    } else if (!selectedCompanies.any((element) => element.name == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedCompanies.assignAll(companiesList);
    } else {
      if (values.length < selectedCompanies.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedCompanies.assignAll(companiesList.where((element) => values.contains(element.name)));
    }
  }
  
  
  search(){
    isLoading(true);
    final request = CustomersReportRequest(
        gallaryListSelected:selectedDeliveryPlace.isNotEmpty ? selectedDeliveryPlace.map((element) => element.id ?? null).toList() : [],
        offerCompanyListSelected:   selectedCompanies.isNotEmpty ? selectedCompanies.map((element) => element.id ?? null).toList() : [],
        black: selectedStatue.value,
        branchId: UserManager().branchId);
    CrmReportsRepository().getCustomerReport(
        request,
       onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false),
      onSuccess: (data){
        reportList.assignAll(data);
        filteredReportList.assignAll(data);
      }
    );
  }

  sendSms(){
    if(selectedReportList.isEmpty){
      showPopupText(text: "يجب اختيار عملاء");
      return;
    }
    if(msgController.text.isEmpty){
      showPopupText(text: "ادخل محتوي الرسالة");
      return;
    }
    isLoading(true);
    for(int i = 0 ; i < reportList.length ; i ++) {
      final request = SendMsgRequest(
      customerPhone: reportList[i].clientMobile,
      gallaryId: UserManager().galleryId,
      msg: msgController.text,
      );
      CrmReportsRepository().sendMsg(request ,
          onComplete: () => i == reportList.length -1 ? isLoading(false) : null,
          onError: (e) => showPopupText(text: e),
          onSuccess: (data){
            if(data.msg == "success"){
              showPopupText(text: 'تم ارسال الرسالة', type: MsgType.success );
              msgController.clear();
            }else{
              showPopupText(text: 'حدث خطا', type: MsgType.error );
            }
          }
      );

    }

  }
}