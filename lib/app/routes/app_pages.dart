import 'package:get/get.dart';
import 'package:toby_bills/app/modules/reports/categories_totals/bindings/categories_totals_binding.dart';
import 'package:toby_bills/app/modules/reports/categories_totals/views/categories_totals_view.dart';
import 'package:toby_bills/app/modules/home/bindings/home_binding.dart';
import 'package:toby_bills/app/modules/home/views/home_view.dart';
import 'package:toby_bills/app/modules/reports/invoice_status/bindings/invoice_status_binding.dart';
import 'package:toby_bills/app/modules/reports/invoice_status/views/invoice_status_view.dart';
import 'package:toby_bills/app/modules/login/bindings/login_binding.dart';
import 'package:toby_bills/app/modules/login/views/login_view.dart';

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
  ];
}
