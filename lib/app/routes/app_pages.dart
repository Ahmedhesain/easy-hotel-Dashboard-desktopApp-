

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hotel_manger/app/modules/cars/views/cars_view.dart';
import 'package:hotel_manger/app/modules/halls/bindings/halls_binding.dart';
import 'package:hotel_manger/app/modules/halls/views/halls_view.dart';
import 'package:hotel_manger/app/modules/home/bindings/home_binding.dart';
import 'package:hotel_manger/app/modules/home/views/home_view.dart';
import 'package:hotel_manger/app/modules/housekeeping/bindings/housekeeping_binding.dart';
import 'package:hotel_manger/app/modules/housekeeping/views/housekeeping_view.dart';
import 'package:hotel_manger/app/modules/login/bindings/login_binding.dart';
import 'package:hotel_manger/app/modules/login/views/login_view.dart';
import 'package:hotel_manger/app/modules/polman/bindings/polman_binding.dart';
import 'package:hotel_manger/app/modules/polman/views/polman_view.dart';
import 'package:hotel_manger/app/modules/restraunt/bindings/restraunt_binding.dart';
import 'package:hotel_manger/app/modules/restraunt/views/restraunt_view.dart';
import 'package:hotel_manger/app/modules/rooms/bindings/rooms_binding.dart';
import 'package:hotel_manger/app/modules/rooms/views/rooms_view.dart';
import 'package:hotel_manger/app/modules/spa/bindings/spa_binding.dart';
import 'package:hotel_manger/app/modules/spa/views/spa_view.dart';

import '../modules/cars/bindings/cars_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),

    ),GetPage(
      name: _Paths.CARS,
      page: () => const CarsHomeView(),
      binding: CarsHomeBinding(),

    ),  GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),

    ),GetPage(
      name: _Paths.HOUSEKEEPING,
      page: () => const HousekeepingHomeView(),
      binding: HousekeepingHomeBinding(),

    ),GetPage(
      name: _Paths.POLMAN,
      page: () => const PolmanHomeView(),
      binding: PolmanHomeBinding(),

    ),GetPage(
      name: _Paths.SPA,
      page: () => const SpaHomeView(),
      binding: SpaHomeBinding(),

    ),GetPage(
      name: _Paths.ROOMS,
      page: () => const RoomsHomeView(),
      binding: RoomsHomeBinding(),

    ),GetPage(
      name: _Paths.HALLS,
      page: () => const HallsHomeView(),
      binding: HallsHomeBinding(),

    ),GetPage(
      name: _Paths.RESTRAUNT,
      page: () => const RestrauntHomeView(),
      binding: RestrauntHomeBinding(),

    ),

  ];
}
