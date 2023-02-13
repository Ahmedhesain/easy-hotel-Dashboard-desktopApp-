import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/table.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/values/app_colors.dart';
import '../../controllers/daily_report_controller.dart';

class DailyReportTable extends GetView<DailyReportController> {
  const DailyReportTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const space = SizedBox(
      width: 20,
    );
    const spaceV = SizedBox(
      height: 20,
    );
    const boldFontSize = 17.0;
    const fontSize = 15.0;
    const headerDecoration = BoxDecoration(
        color:Colors.black26,
        border: Border(
          top: BorderSide.none,
          bottom: BorderSide(color: Colors.black,width: 1),
          right: BorderSide(color: Colors.black,width: 1),
        ));
    const rowDecoration = BoxDecoration(
        color: AppColors.backGround,
        border: Border(
          top: BorderSide.none,
          bottom: BorderSide(color: Colors.black,width: 1),
          right: BorderSide(color: Colors.black,width: 1),
        ));
    const rowDecorationDark = BoxDecoration(
        color: AppColors.appGreyLight,
        border: Border(
          top: BorderSide.none,
          bottom: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black),
        ));
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
                  height: size.height * 0.7,
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
                          [
                            Container(
                              decoration:
                                  i.isEven ? rowDecoration : rowDecorationDark,
                              child: const Center(
                                  child: TextWidget(
                                "",
                                size: fontSize,
                                weight: FontWeight.w700,
                              )),
                            ),
                            Container(
                              decoration:
                                  i.isEven ? rowDecoration : rowDecorationDark,
                              child: Center(
                                  child: TextWidget(
                                controller.treasuries[i].statements.first
                                        .totalDebit
                                        ?.toString() ??
                                    "",
                                size: fontSize,
                                weight: FontWeight.w700,
                              )),
                            ),
                            Container(
                              decoration:
                                  i.isEven ? rowDecoration : rowDecorationDark,
                              child: Center(
                                  child: TextWidget(
                                controller.treasuries[i].bankName ?? "",
                                size: fontSize,
                                weight: FontWeight.w700,
                              )),
                            ),
                            Container(
                              decoration:
                                  i.isEven ? rowDecoration : rowDecorationDark,
                              child: Center(
                                  child: TextWidget(
                                (i + 1).toString(),
                                size: fontSize,
                                weight: FontWeight.normal,
                              )),
                            )
                          ],
                        [
                          Container(
                            decoration: headerDecoration,
                            child: const Center(
                                child: TextWidget(
                              "",
                              size: fontSize,
                              weight: FontWeight.w700,
                            )),
                          ),
                          Obx(() {
                            return Container(
                              decoration: headerDecoration,
                              child: Center(
                                  child: TextWidget(
                                controller.treasuriesTotal.value.toString(),
                                size: fontSize,
                                weight: FontWeight.w700,
                              )),
                            );
                          }),
                          Container(
                            decoration: headerDecoration,
                            child: const Center(
                                child: TextWidget(
                              "الاجمالي",
                              size: boldFontSize,
                              weight: FontWeight.w700,
                            )),
                          ),
                          Container(
                            decoration: headerDecoration,
                            child: const Center(
                                child: TextWidget(
                              "",
                              size: fontSize,
                              weight: FontWeight.normal,
                            )),
                          )
                        ],
                        for (int i = 0; i < controller.expenses.length; i++)
                          [
                            Container(
                              decoration:
                                  i.isEven ? rowDecoration : rowDecorationDark,
                              child: const Center(
                                  child: TextWidget(
                                "",
                                size: fontSize,
                                weight: FontWeight.w700,
                              )),
                            ),
                            Container(
                              decoration:
                                  i.isEven ? rowDecoration : rowDecorationDark,
                              child: Center(
                                  child: TextWidget(
                                controller.expenses[i].value?.toString() ?? "",
                                size: fontSize,
                                weight: FontWeight.w700,
                              )),
                            ),
                            Container(
                              decoration:
                                  i.isEven ? rowDecoration : rowDecorationDark,
                              child: Center(
                                  child: TextWidget(
                                controller.expenses[i].remarks ?? "",
                                size: fontSize,
                                weight: FontWeight.w700,
                              )),
                            ),
                            Container(
                              decoration:
                                  i.isEven ? rowDecoration : rowDecorationDark,
                              child: Center(
                                  child: TextWidget(
                                (i + 1).toString(),
                                size: fontSize,
                                weight: FontWeight.normal,
                              )),
                            )
                          ],
                        [
                          Container(
                            decoration: headerDecoration,
                            child: const Center(
                                child: TextWidget(
                              "",
                              size: fontSize,
                              weight: FontWeight.w700,
                            )),
                          ),
                          Obx(() {
                            return Container(
                              decoration: headerDecoration,
                              child: Center(
                                  child: TextWidget(
                                controller.expensesTotal.value.toString(),
                                size: fontSize,
                                weight: FontWeight.w700,
                              )),
                            );
                          }),
                          Container(
                            decoration: headerDecoration,
                            child: const Center(
                                child: TextWidget(
                              "الاجمالي",
                              size: boldFontSize,
                              weight: FontWeight.w700,
                            )),
                          ),
                          Container(
                            decoration: headerDecoration,
                            child: const Center(
                                child: TextWidget(
                              "",
                              size: fontSize,
                              weight: FontWeight.normal,
                            )),
                          )
                        ],
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
}
