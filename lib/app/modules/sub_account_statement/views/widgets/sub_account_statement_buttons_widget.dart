import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/sub_account_statement/controllers/sub_account_statement_controller.dart';

class SubAccountStatementButtonsWidget extends GetView<SubAccountStatementController> {
  const SubAccountStatementButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 15.0),
        child: Row(
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
              padding: const EdgeInsets.all(5),
              child: Obx(() {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(controller.statements.isNotEmpty)
                      ButtonWidget(text: "تصدير الى اكسل", onPressed: () => ExcelHelper.subAccountStatements(controller.statements, context)),
                    if(controller.statements.isNotEmpty)
                      const SizedBox(width: 5),
                    if(controller.statements.isNotEmpty)
                      ButtonWidget(text: "طباعة", onPressed: () =>
                          PrintingHelper().printSubAccountStatements(context, statements: controller.statements,
                              fromDate: controller.dateFrom.value,
                              toDate: controller.dateFrom.value,
                              fromCenter: controller.selectedCenterFrom.value?.name ?? '--',
                              toCenter: controller.selectedCenterTo.value?.name ?? '--')),
                    if(controller.statements.isNotEmpty)
                      const SizedBox(width: 5),
                    ButtonWidget(text: "بحث", onPressed: () => controller.getStatements()),
                    const SizedBox(width: 5),
                    ButtonWidget(text: "رجوع", onPressed: () => Get.back()),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

}
