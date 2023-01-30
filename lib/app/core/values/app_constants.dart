// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';

abstract class AppConstants {
  static const double BUTTON_TEXT_SIZE = 20.0;
  static const double BUTTON_PADDING = 16.0;
  static const double radius = 4.0;
  static const EdgeInsets PAGE_PADDING = EdgeInsets.all(15);
  static const Duration ANIMATION_DURATION = Duration(milliseconds: 400);
  static const appName = "";
  static const List<String> invoiceTypeList = [
    "مبيعات",
    "مانيكنات الفروع",
    "مانيكنات القماشين",
    "علاقات عامه",
    "تفصيل القماشين",
    "موظفي الفروع",
    "تعديلات",
    "اخري"
  ];


}
