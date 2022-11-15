import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import '../../controllers/purchase_invoices_controller.dart';

class PurchaseInvoiceHeaderWidget extends GetView<PurchaseInvoicesController> {
  const PurchaseInvoiceHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Obx(() {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonWidget(text: controller.invoice.value != null ? "تعديل" : "حفظ", onPressed: () => controller.saveInvoice()),
                if (controller.invoice.value != null)
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      ButtonWidget(text: "طباعة", onPressed: () => controller.printInvoice(context)),
                      const SizedBox(width: 5),
                      ButtonWidget(text: "طباعة قيد", onPressed: () => controller.printGeneralJournal(context)),
                    ],
                  ),
                const SizedBox(width: 5),
                ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice()),
                const SizedBox(width: 5),
                ButtonWidget(text: "رجوع", onPressed: () => Get.back()),
              ],
            );
          }),
        ),
      ),
    );
  }
}
