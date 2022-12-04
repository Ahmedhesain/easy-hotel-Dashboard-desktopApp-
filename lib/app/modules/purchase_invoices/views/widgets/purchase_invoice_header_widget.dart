import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import '../../controllers/purchase_invoices_controller.dart';

class PurchaseInvoiceHeaderWidget extends GetView<PurchaseInvoicesController> {
  const PurchaseInvoiceHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final permission = UserManager().user.userScreens["invpurchaseinvoice_1"];
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Obx(() {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(permission?.edit ?? false)
                ButtonWidget(text: controller.invoice.value != null ? "تعديل" : "حفظ", onPressed: () => controller.saveInvoice(), margin: const EdgeInsets.symmetric(horizontal: 2.5),),
                if (controller.invoice.value != null)
                  Row(
                    children: [
                      if(permission?.edit ?? false)
                      ButtonWidget(text: "طباعة", onPressed: () => controller.printInvoice(context), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                      if(permission?.edit ?? false)
                      ButtonWidget(text: "طباعة قيد", onPressed: () => controller.printGeneralJournal(context), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                    ],
                  ),
                if(permission?.add ?? false)
                ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                ButtonWidget(text: "رجوع", onPressed: () => Get.back(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
              ],
            );
          }),
        ),
      ),
    );
  }
}
