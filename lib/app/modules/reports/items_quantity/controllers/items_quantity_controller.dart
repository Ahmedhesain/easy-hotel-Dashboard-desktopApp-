import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/quantity_items_response.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../../data/model/reports/dto/request/quantity_items_request.dart';

class QuantityItemsController extends GetxController{

  final List<QuantityItemsResponse> _allReports = [];
  final reports = <QuantityItemsResponse>[].obs;
  final isLoading = true.obs;
  String query = '';



  @override
  void onInit() {
    super.onInit();
    getStages();
  }

  getStages() async {
    isLoading(true);
    final request = QuantityItemsRequest(
      inventoryId: Get.find<HomeController>().invoice.value!.serial!,
      branchId: UserManager().branchId,
    );
    ReportsRepository().getQuantityItems(request,
        onSuccess: (data) {
          reports.assignAll(data);
          _allReports.assignAll(data);
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }

  Future<void> searchItem() async {
    reports.clear();
    reports.assignAll(_allReports.where((item) {
      final itemName = item.itemName?.toLowerCase();
      final searchLower = query.toLowerCase();
      return itemName!.contains(searchLower);
    }).toList());
  }

}