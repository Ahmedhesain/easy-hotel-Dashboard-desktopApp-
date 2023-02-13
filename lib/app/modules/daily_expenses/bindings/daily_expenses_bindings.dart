


import 'package:get/get.dart';
import 'package:toby_bills/app/modules/daily_expenses/controllers/daily_expenses_controller.dart';

class DailyExpensesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DailyExpensesController>(() => DailyExpensesController());
  }

}