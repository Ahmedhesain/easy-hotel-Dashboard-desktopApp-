import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/catch_receipt/controllers/catch_receipt_controller.dart';
import 'package:toby_bills/app/modules/notifications/controllers/notifications_controller.dart';

class CatchReceiptButtonsWidget extends GetView<CatchReceiptController> {
  const CatchReceiptButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15.0),
      child: Row(
        children: [
          const Spacer(),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonWidget(text: "حفظ", onPressed: () {}),
                const SizedBox(width: 5),
                ButtonWidget(text: "جديد", onPressed: () {}),
                const SizedBox(width: 5),
                ButtonWidget(text: "رجوع", onPressed: () => Get.back()),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
