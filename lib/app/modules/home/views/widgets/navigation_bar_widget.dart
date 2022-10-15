import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:toby_bills/app/routes/app_pages.dart';

class NavigationBarWidget extends GetView<HomeController> {
  const NavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.appGreyDark
              ),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonWidget(text: "تنزيل عرض", onPressed: () {}),
                  const SizedBox(width: 5),
                  ButtonWidget(text: "تحديث", onPressed: () => controller.getItems()),
                  const SizedBox(width: 5),
                  Obx(() {
                      return ButtonWidget(text: controller.invoice.value != null?"تعديل":"حفظ", onPressed: () => controller.saveInvoice());
                    }
                  ),
                  const SizedBox(width: 5),
                  ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice()),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.appGreyDark
              ),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonWidget(text: "اجماليات الفئات", onPressed: () => Get.toNamed(Routes.CATEGORIES_TOTALS)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

