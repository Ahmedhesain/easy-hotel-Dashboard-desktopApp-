
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hotel_manger/app/modules/home/bindings/home_binding.dart';
import 'package:hotel_manger/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      // children: [
      //   GetPage(
      //     name: _Paths.HOME,
      //     page: () => const HomeView(),
      //     binding: HomeBinding(),
      //   ),
      // ],
    ),

  ];
}
