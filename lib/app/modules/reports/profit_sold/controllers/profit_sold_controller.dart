import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/quantity_items_response.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../../data/model/reports/dto/request/quantity_items_request.dart';

class ProfitSoldController extends GetxController{

  final List<ProfitOfItemsSoldResponse> _allReports = [];
  // final reports = <QuantityItemsResponse>[].obs;
  final isLoading = true.obs;
  String query = '';



  @override
  void onInit() {
    super.onInit();
    // getStages();
  }

  // getProfitSold() async {
  //   isLoading(true);
  //   final request = ProfitOfItemsSoldRequest(
  //     dateTo: DateTime.now(),
  //     branchId: UserManager().branchId,
  //   );
  //   ReportsRepository().getQuantityItems(request,
  //       onSuccess: (data) {
  //         reports.assignAll(data);
  //         _allReports.assignAll(data);
  //       },
  //       onError: (e) => showPopupText(text: e.toString()),
  //       onComplete: () => isLoading(false)
  //   );
  // }
  //
  // Future<void> searchItem() async {
  //   reports.clear();
  //   reports.assignAll(_allReports.where((item) {
  //     final itemName = item.itemName?.toLowerCase();
  //     final searchLower = query.toLowerCase();
  //     return itemName!.contains(searchLower);
  //   }).toList());
  // }

}