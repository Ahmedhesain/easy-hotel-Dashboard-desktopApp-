import 'package:get/get.dart';
import 'package:toby_bills/app/modules/reports/item_balances_statement/controllers/item_balances_statement_controller.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/controllers/items_quantity_controller.dart';
import 'package:toby_bills/app/modules/reports/profit_sold/controllers/profit_sold_controller.dart';
import 'package:toby_bills/app/modules/reports/sales_items_by_company/controllers/sales_items_by_company_controller.dart';

class ItemsBalancesStatementBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<ItemsBalancesStatementController>(() => ItemsBalancesStatementController());
  }

}
