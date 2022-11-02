import 'package:get/get.dart';

import 'package:toby_bills/app/modules/account_statement/bindings/account_statement_binding.dart';
import 'package:toby_bills/app/modules/account_statement/views/account_statement_view.dart';
import 'package:toby_bills/app/modules/edit_bills/bindings/edit_bills_binding.dart';
import 'package:toby_bills/app/modules/edit_bills/views/edit_bills_view.dart';
import 'package:toby_bills/app/modules/home/bindings/home_binding.dart';
import 'package:toby_bills/app/modules/home/views/home_view.dart';
import 'package:toby_bills/app/modules/invoice_statement_by_case/bindings/invoice_statement_by_case_binding.dart';
import 'package:toby_bills/app/modules/invoice_statement_by_case/views/invoice_statement_by_case_view.dart';
import 'package:toby_bills/app/modules/items/bindings/items_binding.dart';
import 'package:toby_bills/app/modules/items/views/items_view.dart';
import 'package:toby_bills/app/modules/login/bindings/login_binding.dart';
import 'package:toby_bills/app/modules/login/views/login_view.dart';
import 'package:toby_bills/app/modules/production_stages/bindings/production_stages_binding.dart';
import 'package:toby_bills/app/modules/production_stages/views/production_stages_view.dart';
import 'package:toby_bills/app/modules/reports/categories_totals/bindings/categories_totals_binding.dart';
import 'package:toby_bills/app/modules/reports/categories_totals/views/categories_totals_view.dart';
import 'package:toby_bills/app/modules/reports/invoice_status/bindings/invoice_status_binding.dart';
import 'package:toby_bills/app/modules/reports/invoice_status/views/invoice_status_view.dart';
import 'package:toby_bills/app/modules/reports/item_sales_by_customers/bindings/item_sales_by_customers_binding.dart';
import 'package:toby_bills/app/modules/reports/item_sales_by_customers/views/item_sales_by_customers_view.dart';
import 'package:toby_bills/app/modules/reports/safe_account_statement/bindings/safe_account_statement.dart';
import 'package:toby_bills/app/modules/reports/safe_account_statement/views/safe_account_statement_view.dart';

import '../modules/reports/items_quantity/bindings/production_stages_binding.dart';
import '../modules/reports/items_quantity/views/quantity_items_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String get initialRoute => Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORIES_TOTALS,
      page: () => const CategoriesTotalsView(),
      binding: CategoriesTotalsBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE_STATUS,
      page: () => const InvoiceStatusView(),
      binding: InvoiceStatusBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_STATEMENT,
      page: () => const AccountStatementView(),
      binding: AccountStatementBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTION_STAGES,
      page: () => const ProductionStagesView(),
      binding: ProductionStagesBinding(),
    ),
    GetPage(
      name: _Paths.ITEMS_QUANTITY,
      page: () => const QuantityItemsView(),
      binding: QuantityItemsBinding(),
    ),
    GetPage(
      name: _Paths.ITEMS_SALES_BY_CUSTOMERS,
      page: () => const ItemSalesByCustomersView(),
      binding: ItemsSalesByCustomersBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE_STATEMENT_BY_CASE,
      page: () => const InvoiceStatementByCaseView(),
      binding: InvoiceStatementByCaseBinding(),
    ),
    GetPage(
      name: _Paths.SAFE_ACCOUNT_SATATMENT,
      page: () => const SafeAccountStatementView(),
      binding: SafeAccountStatementBinding(),
    ),
    GetPage(
      name: _Paths.ITEMS,
      page: () => ItemsView(),
      binding: ItemsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_BILLS,
      page: () => EditBillsView(),
      binding: EditBillsBinding(),
    ),
  ];
}
