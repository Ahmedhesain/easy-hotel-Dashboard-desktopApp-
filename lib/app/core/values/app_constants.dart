// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';

abstract class AppConstants {
  static const double BUTTON_TEXT_SIZE = 20.0;
  static const double BUTTON_PADDING = 16.0;
  static const double radius = 4.0;
  static const EdgeInsets PAGE_PADDING = EdgeInsets.all(15);
  static const Duration ANIMATION_DURATION = Duration(milliseconds: 400);
  static const appName = "";
  static const List<String> invoiceTypeList = [
    "الكل",
    "مانيكنات الفروع",
    "مانيكنات القماشين",
    "علاقات عامه",
    "تفصيل القماشين",
    "موظفي الفروع",
    "تعديلات",
    "اخري",
    "مبيعات"
  ];

  static final List<GlAccountResponse> accounts = [
    GlAccountResponse(name: "مخزون القماش", id: 11619),
    GlAccountResponse(name: "مخزون الاشمغة والغتر", id: 11620),
    GlAccountResponse(name: "مخزون العود", id: 11621),
    GlAccountResponse(name: "مخزون الأحذية", id: 11622),
    GlAccountResponse(name: "لوجو", id: 13282),
    GlAccountResponse(name: "طقطق وازرار خارجية هاروت", id: 13343),
  ];
}
