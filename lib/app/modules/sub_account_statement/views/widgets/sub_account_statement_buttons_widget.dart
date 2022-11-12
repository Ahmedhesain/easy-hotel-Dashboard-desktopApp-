import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/sub_account_statement/controllers/sub_account_statement_controller.dart';

class SubAccountStatementButtonsWidget extends GetView<SubAccountStatementController> {
  const SubAccountStatementButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 15.0),
        child: Row(
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonWidget(text: "بحث", onPressed: () => controller.getStatements()),
                  const SizedBox(width: 5),
                  ButtonWidget(text: "رجوع", onPressed: () => Get.back()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
