import 'package:get/get.dart';
import 'package:toby_bills/app/modules/reports/clients_no_movement/controllers/clients_no_movement_controller.dart';
import 'package:toby_bills/app/modules/reports/find_customer_balance/controllers/find_custome_balance_controller.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/controllers/items_quantity_controller.dart';
import 'package:toby_bills/app/modules/reports/profit_sold/controllers/profit_sold_controller.dart';
import 'package:toby_bills/app/modules/reports/sales_items_by_company/controllers/sales_items_by_company_controller.dart';

class FindCustomerBalanceBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<FindCustomerBalanceController>(() => FindCustomerBalanceController());
  }

}
