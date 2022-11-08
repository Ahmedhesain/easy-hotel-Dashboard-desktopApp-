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
import 'package:toby_bills/app/modules/purchase_invoices/bindings/purchase_invoices_binding.dart';
import 'package:toby_bills/app/modules/purchase_invoices/views/purchase_invoices_view.dart';
import 'package:toby_bills/app/modules/reports/balance_galary/bindings/balance_galary_binding.dart';
import 'package:toby_bills/app/modules/reports/balance_galary/views/balance_galary_view.dart';
import 'package:toby_bills/app/modules/reports/balance_galary_paid/bindings/balance_galary_paid_binding.dart';
import 'package:toby_bills/app/modules/reports/balance_galary_paid/views/balance_galary_unpaid_view.dart';
import 'package:toby_bills/app/modules/reports/balance_galary_unpaid/bindings/balance_galary_unpaid_binding.dart';
import 'package:toby_bills/app/modules/reports/balance_galary_unpaid/views/balance_galary_unpaid_view.dart';
import 'package:toby_bills/app/modules/reports/categories_totals/bindings/categories_totals_binding.dart';
import 'package:toby_bills/app/modules/reports/categories_totals/views/categories_totals_view.dart';
import 'package:toby_bills/app/modules/reports/clients_no_movement/bindings/clients_no_movement_binding.dart';
import 'package:toby_bills/app/modules/reports/clients_no_movement/views/clients_no_movement_view.dart';
import 'package:toby_bills/app/modules/reports/find_customer_balance/bindings/find_custome_balance_binding.dart';
import 'package:toby_bills/app/modules/reports/find_customer_balance/views/find_custome_balance_view.dart';
import 'package:toby_bills/app/modules/reports/find_sales_value_added/bindings/find_sales_value_added_binding.dart';
import 'package:toby_bills/app/modules/reports/find_sales_value_added/views/find_sales_value_added_view.dart';
import 'package:toby_bills/app/modules/reports/find_sales_value_added_details/bindings/find_sales_value_added_details_binding.dart';
import 'package:toby_bills/app/modules/reports/find_sales_value_added_details/views/find_sales_value_added_details_view.dart';
import 'package:toby_bills/app/modules/reports/find_statement_of_bonds_by_branch_report/bindings/find_statement_of_bonds_by_branch_report_binding.dart';
import 'package:toby_bills/app/modules/reports/find_statement_of_bonds_by_branch_report/views/find_statement_of_bonds_by_branch_report_view.dart';
import 'package:toby_bills/app/modules/reports/inv_item/bindings/inv_item_binding.dart';
import 'package:toby_bills/app/modules/reports/inv_item/views/inv_item_view.dart';
import 'package:toby_bills/app/modules/reports/invoice_status/bindings/invoice_status_binding.dart';
import 'package:toby_bills/app/modules/reports/invoice_status/views/invoice_status_view.dart';
import 'package:toby_bills/app/modules/reports/invoices_without_swing_statement/bindings/invoices_without_swing_binding.dart';
import 'package:toby_bills/app/modules/reports/invoices_without_swing_statement/views/invoice_without_swing_view.dart';
import 'package:toby_bills/app/modules/reports/item_balances_statement/bindings/items_balances_statement_binding.dart';
import 'package:toby_bills/app/modules/reports/item_balances_statement/controllers/item_balances_statement_controller.dart';
import 'package:toby_bills/app/modules/reports/item_balances_statement/views/item_balances_statement_view.dart';
import 'package:toby_bills/app/modules/reports/item_sales_by_customers/bindings/item_sales_by_customers_binding.dart';
import 'package:toby_bills/app/modules/reports/item_sales_by_customers/views/item_sales_by_customers_view.dart';
import 'package:toby_bills/app/modules/reports/profit_sold/bindings/profit_sold_binding.dart';
import 'package:toby_bills/app/modules/reports/profit_sold/views/profit_sold_view.dart';
import 'package:toby_bills/app/modules/reports/safe_account_statement/bindings/safe_account_statement.dart';
import 'package:toby_bills/app/modules/reports/safe_account_statement/views/safe_account_statement_view.dart';
import 'package:toby_bills/app/modules/reports/sales_items_by_company/bindings/sales_items_by_company_binding.dart';
import 'package:toby_bills/app/modules/reports/sales_items_by_company/views/sales_items_by_company_view.dart';

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
    GetPage(
      name: _Paths.PROFIT_SOLD,
      page: () => ProfitSoldView(),
      binding: ProfitSoldBinding(),
    ),
    GetPage(
      name: _Paths.SALES_ITEMS_BY_COMPANY,
      page: () => SalesItemsByCompanyView(),
      binding: SalesItemsByCompanyBinding(),
    ),
    GetPage(
      name: _Paths.ITEMS_BALANCES_STATEMENT,
      page: () => ItemsBalancesStatementView(),
      binding: ItemsBalancesStatementBinding(),
    ),
    GetPage(
      name: _Paths.INVOICES_WITHOUT_SWING,
      page: () => InvoicesWithoutSwingView(),
      binding: InvoicesWithoutSwingBinding(),
    ),
    GetPage(
      name: _Paths.CLIENTS_NO_MOVEMENT,
      page: () => ClientNoMovementView(),
      binding: ClientsNoMovementBinding(),
    ),
    GetPage(
      name: _Paths.FIND_CUSTOMER_BALANCE,
      page: () => FindCustomerBalanceView(),
      binding: FindCustomerBalanceBinding(),
    ),
    GetPage(
      name: _Paths.FIND_STATEMENT_OF_BONDS_BY_BRANCH,
      page: () => FindStatementOfBondsByBranchReportView(),
      binding: FindStatementOfBondsByBranchReportBinding(),
    ),
    GetPage(
      name: _Paths.FIND_VALES_VALUES_ADDED_DETAILS,
      page: () => FindValesValueAddedDetailsView(),
      binding: FindValesValueAddedDetailsBinding(),
    ),
    GetPage(
      name: _Paths.FIND_VALES_VALUES_ADDED,
      page: () => FindSalesValueAddedView(),
      binding: FindSalesValueAddedBinding(),
    ),

    GetPage(
      name: _Paths.PURCHASE_INVOICES,
      page: () => PurchaseInvoicesView(),
      binding: PurchaseInvoicesBinding(),
    ),
    GetPage(
      name: _Paths.BALANCE_GALLARY,
      page: () => BalanceGallaryView(),
      binding: BalanceGallaryBinding(),
    ),
    GetPage(
      name: _Paths.BALANCE_GALLARY_UNPAID,
      page: () => BalanceGallaryUnpaidView(),
      binding: BalanceGallaryUnpaidBinding(),
    ),
    GetPage(
      name: _Paths.BALANCE_GALLARY_PAID,
      page: () => BalanceGallarypaidView(),
      binding: BalanceGallarypaidBinding(),
    ),
    GetPage(
      name: _Paths.INV_ITEM_DTO,
      page: () => InvItemView(),
      binding: InvItemBinding(),
    ),
  ];
}
