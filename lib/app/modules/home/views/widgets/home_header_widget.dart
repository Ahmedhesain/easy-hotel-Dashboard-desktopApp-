import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:toby_bills/app/routes/app_pages.dart';

class HomeHeaderWidget extends GetView<HomeController> {
  const HomeHeaderWidget({Key? key}) : super(key: key);

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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Obx(() {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonWidget(text: "تنزيل عرض", onPressed: () {}),
                    const SizedBox(width: 5),
                    ButtonWidget(text: "تحديث", onPressed: () => controller.getItems()),
                    const SizedBox(width: 5),
                    ButtonWidget(text: controller.invoice.value != null ? "تعديل" : "حفظ", onPressed: () => controller.saveInvoice()),
                    if (controller.invoice.value != null) const SizedBox(width: 5),
                    if (controller.invoice.value != null)
                      ButtonWidget(
                          text: "طباعة",
                          onPressed: () => controller.printInvoice(context)),
                    if (controller.invoice.value != null) const SizedBox(width: 5),
                    if (controller.invoice.value != null)
                      ButtonWidget(
                          text: "طباعة قيد",
                          onPressed: () => controller.printGeneralJournal(context)),
                    const SizedBox(width: 5),
                    ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice()),
                    const SizedBox(width: 5),
                    ButtonWidget(text: "حذف هللة", onPressed: () => controller.removeHalala()),
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
