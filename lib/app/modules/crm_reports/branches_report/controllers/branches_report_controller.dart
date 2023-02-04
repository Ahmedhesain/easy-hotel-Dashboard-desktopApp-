import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';

import '../../../../data/model/crm_reports/dto/request/branches_report_request.dart';
import '../../../../data/model/crm_reports/dto/response/branch_report_response.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../../data/repository/crm_reports/crm_reports_repository.dart';
import '../../../home/controllers/home_controller.dart';

class BranchesReportController extends GetxController {
  final isLoading = false.obs;
  Rxn<num> allCostAverage = Rxn();
  Rxn<GalleryResponse> selectedGallery = Rxn();
  Rxn<BranchReportResponse> reportResponse = Rxn();
  final galleries = <GalleryResponse>[].obs;
  final user = UserManager();
  Rxn<DateTime> dateFrom = Rxn(DateTime.now());
  Rxn<DateTime> dateTo = Rxn(DateTime.now());

  @override
  onInit() {
    super.onInit();
    galleries.assignAll(Get.find<HomeController>().galleries);
    if (galleries.any((element) => element.id == user.galleryId)) {
      selectedGallery(
          galleries.singleWhere((element) => element.id == user.galleryId));
    }
  }

  search() {
    isLoading(true);
    final request = BranchesReportRequest(
        branchId: user.branchId,
        gallaryFrom: selectedGallery.value?.id,
        fromDate: dateFrom.value,
        toDate: dateTo.value,
    );

    CrmReportsRepository().getBranchesReport(request,
      onSuccess: (data){
        reportResponse(data);
        allCostAverage(0.0);
        reportResponse.value?.summitionItemsViewList?.map((e) =>
            allCostAverage(allCostAverage.value ?? 0.0 + (e.allAvarageCost ?? 0.0))
        );

      } ,
      onError: (e) => showPopupText(text: e),
      onComplete: () => isLoading(false)
    );
  }
}
