import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:toby_bills/app/modules/payments/controllers/payments_controller.dart';

class PaymentsButtonsWidget extends GetView<PaymentsController> {
  const PaymentsButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonWidget(text: "حفظ", onPressed: () {}),
            const SizedBox(width: 5),
            ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice()),
            const SizedBox(width: 5),
            ButtonWidget(text: "رجوع", onPressed: () => Get.back()),
          ],
        ),
      ),
    );
  }

}
