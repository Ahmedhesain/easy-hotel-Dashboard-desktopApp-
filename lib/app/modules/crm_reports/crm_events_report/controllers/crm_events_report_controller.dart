


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';

import '../../../../core/utils/crm_printing_helper.dart';
import '../../../../core/utils/user_manager.dart';
import '../../../../data/model/crm_reports/dto/request/crm_events_report_request.dart';
import '../../../../data/model/crm_reports/dto/response/crm_event_dto.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../../data/repository/crm_reports/crm_reports_repository.dart';
import '../../../home/controllers/home_controller.dart';

class CrmEventsReportController extends GetxController {
  final isLoading = false.obs ;
  final galleries = <GalleryResponse>[].obs;
  final user = UserManager();
  Rxn<GalleryResponse> selectedGallery = Rxn();
  final Rxn<DateTime> dateFrom = Rxn(DateTime.now());
  final Rxn<DateTime> dateTo = Rxn(DateTime.now());
  final eventList = <EventDTO>[].obs ;
  @override
  void onInit() {
    galleries.assignAll(Get.find<HomeController>().galleries);
    if (galleries.any((element) => element.id == user.galleryId)) {
      selectedGallery(galleries.singleWhere((element) => element.id == user.galleryId));
    }
    super.onInit();
  }


  search(){
   isLoading(true);
   final request = CrmEventsReportRequest(
       gallaryId: selectedGallery.value!.id!,
       dateFrom: dateFrom.value,
       dateTo: dateTo.value,
       branchId: user.branchId);

   CrmReportsRepository().getEventsList(
       request,
       onSuccess: (data) => eventList(data),
       onError: (e) => showPopupText(text: e),
       onComplete: () => isLoading(false)
   );
  }


  print(BuildContext context) => CrmPrintingHelper().crmEvents(context, eventList , selectedGallery.value?.name ?? "" , dateFrom.value , dateTo.value );


}