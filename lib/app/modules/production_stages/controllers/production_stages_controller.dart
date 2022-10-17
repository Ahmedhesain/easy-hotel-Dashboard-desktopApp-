import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/production_stages_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/production_stages_response.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

class ProductionStagesController extends GetxController{

  final List<ProductionStagesResponse> reports = [];
  final isLoading = true.obs;


  @override
  void onInit() {
    super.onInit();
    getStages();
  }

  getStages() async {
    isLoading(true);
    final request = ProductionStagesRequest(
        serial: Get.find<HomeController>().invoice.value!.serial!,
        branchId: UserManager().branchId,
        gallaryId: UserManager().galleryId,
    );
    ReportsRepository().getProductionStages(request,
        onSuccess: (data) => reports.assignAll(data),
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

}