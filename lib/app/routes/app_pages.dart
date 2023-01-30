

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hotel_manger/app/modules/home/views/home_view.dart';

import '../modules/home/bindings/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),

    ),

  ];
}
