import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/table.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/values/app_colors.dart';
import '../../controllers/daily_report_controller.dart';

class DailyReportTable extends GetView<DailyReportController> {
  const DailyReportTable({Key? key}) : super(key: key);

  final headerDecoration = const BoxDecoration(
      color: AppColors.appGrey,
      border: Border(
        top: BorderSide.none,
        bottom: BorderSide(color: Colors.black, width: 1),
        right: BorderSide(color: Colors.black, width: 1),
      ));

  final rowDecoration = const BoxDecoration(
      color: AppColors.backGround,
      border: Border(
        top: BorderSide.none,
        bottom: BorderSide(color: Colors.black, width: 1),
        right: BorderSide(color: Colors.black, width: 1),
      ));
  final rowDecorationDark = const BoxDecoration(
      color: AppColors.appGreyLight,
      border: Border(
        top: BorderSide.none,
        bottom: BorderSide(color: Colors.black),
        right: BorderSide(color: Colors.black),
      ));

  final double boldFontSize = 17.0;
  final double fontSize = 15.0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Card(
            color: AppColors.backGround,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  height: size.height * 0.6,
                  child: Obx(() {
                    return TableWidget(
                      header: ["السندات", "المنصرف", "بيان", "م"]
                          .map(
                            (e) => Container(
                              decoration: headerDecoration,
                              child: Center(
                                  child: TextWidget(
                                e,
                                size: boldFontSize,
                                weight: FontWeight.bold,
                              )),
                            ),
                          )
                          .toList(),
                      rows: [
                        for (int i = 0; i < controller.treasuries.length; i++)
                          detailRow(
                            i: i,
                            value: controller
                                    .treasuries[i].statements.first.totalDebit
                                    ?.toString() ??
                                "",
                            remark: controller.treasuries[i].bankName ?? "",
                          ),
                        headRow(
                            remark: "الاجمالي",
                            value: controller.treasuriesTotal.value.toStringAsFixed(2)) ,
                        for (int x = 0; x < controller.expenses.length; x++)
                          detailRow(
                            i: x,
                            value:
                                controller.expenses[x].value?.toString() ?? "",
                            remark: controller.expenses[x].remarks ?? "",
                          ),
                       headRow(
                            remark: "الاجمالي",
                            value: controller.expensesTotal.value.toStringAsFixed(2)),
                        headRow(
                            remark: "رصيد الصندوق باليوم السابق",
                            value: controller.treasuriesPreviousTotal.value
                                .toStringAsFixed(2)),
                        headRow(
                            remark: "يضاف ايرادات اليوم الحالي",
                            value: controller.treasuriesTotal.value.toStringAsFixed(2)),
                        headRow(
                            remark: "يخصم اجمالي المصروفات",
                            value: controller.expensesTotal.value.toStringAsFixed(2)),
                        headRow(
                            remark: "الرصيد الفعلي",
                            value:
                                controller.treasuriesNetTotal.value.toStringAsFixed(2)),
                        headRow(remark: "ايداع البنك", value: ""),
                        headRow(remark: "حوالات البنك", value:  controller.transfersBank.value.toStringAsFixed(2)),
                        headRow(remark: "ايداع الشبكة", value:  controller.netBank.value.toStringAsFixed(2)),
                        headRow(remark: "اجمالي فواتير تمارا", value: controller.netTamaraBank.value.toStringAsFixed(2)),
                        headRow(remark: "رصيد اليوم التالي", value: "0.0"),
                      ],
                      minimumCellWidth: size.width * 0.1,
                      headerHeight: size.height * 0.05,
                      rowHeight: size.height * 0.05,
                    );
                  }),
                )
              ],
            )));
  }

  List<Widget> headRow({String? value, String? remark, String? index}) => [
        Container(
          decoration: headerDecoration,
          child: Center(
              child: TextWidget(
            "",
            size: fontSize,
            weight: FontWeight.w700,
          )),
        ),
        Container(
          decoration: headerDecoration,
          child: Center(
              child: TextWidget(
            value ?? "",
            size: fontSize,
            weight: FontWeight.w700,
          )),
        ),
        Container(
          decoration: headerDecoration,
          child: Center(
              child: TextWidget(
            remark ?? "",
            size: boldFontSize,
            weight: FontWeight.w700,
          )),
        ),
        Container(
          decoration: headerDecoration,
          child: Center(
              child: TextWidget(
            index ?? "",
            size: fontSize,
            weight: FontWeight.normal,
          )),
        )
      ];

  List<Widget> detailRow({String? value, String? remark, required int i}) => [
        Container(
          decoration: i.isEven ? rowDecoration : rowDecorationDark,
          child: Center(
              child: TextWidget(
            "",
            size: fontSize,
            weight: FontWeight.w700,
          )),
        ),
        Container(
          decoration: i.isEven ? rowDecoration : rowDecorationDark,
          child: Center(
              child: TextWidget(
                value ??
                "",
            size: fontSize,
            weight: FontWeight.w700,
          )),
        ),
        Container(
          decoration: i.isEven ? rowDecoration : rowDecorationDark,
          child: Center(
              child: TextWidget(
                remark ?? "",
            size: fontSize,
            weight: FontWeight.w700,
          )),
        ),
        Container(
          decoration: i.isEven ? rowDecoration : rowDecorationDark,
          child: Center(
              child: TextWidget(
            (i + 1).toString(),
            size: fontSize,
            weight: FontWeight.normal,
          )),
        )
      ];
}
