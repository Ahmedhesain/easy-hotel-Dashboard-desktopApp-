import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';

import 'package:toby_bills/app/modules/home/bindings/home_binding.dart';
import 'package:toby_bills/app/modules/home/views/home_view.dart';
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
  ];
}
