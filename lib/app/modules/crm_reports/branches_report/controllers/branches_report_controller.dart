import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';

import '../../../../data/model/crm_reports/dto/request/branches_report_request.dart';
import '../../../../data/model/crm_reports/dto/response/branch_report_response.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../../data/model/reports/dto/request/categories_totals_request.dart';
import '../../../../data/model/reports/dto/request/group_list_request.dart';
import '../../../../data/model/reports/dto/response/group_list_response.dart';
import '../../../../data/repository/crm_reports/crm_reports_repository.dart';
import '../../../../data/repository/reports/reports_repository.dart';
import '../../../home/controllers/home_controller.dart';

class BranchesReportController extends GetxController {
  final isLoading = false.obs;
  Rxn<GalleryResponse> selectedGallery = Rxn();
  Rxn<GalleryResponse> selectedGallery2 = Rxn();
  final reportResponse = <BranchReportResponse>[].obs;
  final galleries = <GalleryResponse>[].obs;
  final user = UserManager();
  Rxn<DateTime> dateFrom = Rxn(DateTime.now());
  Rxn<DateTime> dateTo = Rxn(DateTime.now());
  final groups = <GroupListResponse>[].obs;
  final selectedGroups = <GroupListResponse>[].obs;

  @override
  onInit() {
    super.onInit();
    getGroupList();
    galleries.assignAll(Get.find<HomeController>().galleries);
    if (galleries.any((element) => element.id == user.galleryId)) {
      selectedGallery(
          galleries.singleWhere((element) => element.id == user.galleryId));
    }
  }

  search() {
    if(selectedGallery == null){
      showPopupText(text: "يجب اختيار معرض اول");
      return ;
    }
    if(selectedGallery2 == null){
      showPopupText(text: "يجب اختيار معرض اول");
      return ;
    }
    if(selectedGroups.isEmpty){
      showPopupText(text: "يجب اختيار فئه");
      return ;
    }
    if(dateTo.value == null || dateFrom.value == null){
      showPopupText(text: "يجب اختيار فترة");
      return ;
    }
    for (var element in [selectedGallery,selectedGallery2]) {
      isLoading(true);
      final request = BranchesReportRequest(
          branchId: user.branchId,
          gallaryFrom: element.value?.id,
          fromDate: dateFrom.value,
          toDate: dateTo.value,
          selectedGroups: List<SymbolDtoapiList>.from(selectedGroups.map((element) => SymbolDtoapiList(element.id ?? -2)))
      );
      CrmReportsRepository().getBranchesReport(request,
          onSuccess: (data){
            data.summitionItemsViewList?.forEach((e) {
              data.allCostAverage = (data.allCostAverage ?? 0 ) + (e.allAvarageCost ?? 0.0);
            });
            reportResponse.add(data);
            reportResponse.refresh();
          } ,
          onError: (e) => showPopupText(text: e),
          onComplete: () => isLoading(false)
      );
    }

  }

  getGroupList() {
    isLoading(true);
    final request = GroupListRequest(branchId: user.branchId, id: user.id);
    ReportsRepository().getGroupList(
      request,
      onSuccess: (data) {
        groups.assignAll(data);
        if(groups.isNotEmpty){
          groups.insert(0, const GroupListResponse(name: "تحديد الكل", id: -1));
        }
      },
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false),
    );
  }


  selectNewGroups(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedGroups.any((element) => element.name == "تحديد الكل")) {
      selectedGroups.clear();
    } else if (!selectedGroups.any((element) => element.name == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedGroups.assignAll(groups);
    } else {
      if (values.length < selectedGroups.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedGroups.assignAll(groups.where((element) => values.contains(element.name)));
    }
  }


}
