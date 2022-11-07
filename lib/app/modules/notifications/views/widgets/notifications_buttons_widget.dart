import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';

class NotificationsButtonsWidget extends StatelessWidget {
  const NotificationsButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
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
    );
  }

}
