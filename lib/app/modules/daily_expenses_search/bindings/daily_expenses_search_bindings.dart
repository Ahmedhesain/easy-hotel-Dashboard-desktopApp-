


import 'package:get/get.dart';

import '../controllers/daily_expenses_search_controller.dart';

class DailyExpensesSearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DailyExpensesSearchController>(() => DailyExpensesSearchController());
  }

}