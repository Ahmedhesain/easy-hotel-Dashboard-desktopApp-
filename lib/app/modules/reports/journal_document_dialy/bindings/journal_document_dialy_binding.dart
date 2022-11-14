import 'package:get/get.dart';
import 'package:toby_bills/app/modules/reports/categories_items/controllers/categories_items_controller.dart';
import 'package:toby_bills/app/modules/reports/invoice_movement/controllers/invoice_movement_controller.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/controllers/items_quantity_controller.dart';
import 'package:toby_bills/app/modules/reports/journal_document_dialy/controllers/journal_document_dialy_controller.dart';
import 'package:toby_bills/app/modules/reports/profit_sold/controllers/profit_sold_controller.dart';
import 'package:toby_bills/app/modules/reports/sales_for_period/controllers/sales_for_period_controller.dart';

class JournalDocumentDailyBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<JournalDocumentDailyController>(() => JournalDocumentDailyController());
  }

}
