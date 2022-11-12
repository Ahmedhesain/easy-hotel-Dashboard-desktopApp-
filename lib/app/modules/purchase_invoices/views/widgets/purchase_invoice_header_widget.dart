import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:toby_bills/app/routes/app_pages.dart';

import '../../controllers/purchase_invoices_controller.dart';

class PurchaseInvoiceHeaderWidget extends GetView<PurchaseInvoicesController> {
  const PurchaseInvoiceHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final permissions = UserManager().user.userScreens["invpurchaseinvoice_1"]!;
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
                if((permissions.edit ?? false) || controller.invoice.value?.id == null)
                  const SizedBox(width: 5),
                if((permissions.edit ?? false) || controller.invoice.value?.id == null)
                  ButtonWidget(text: "حفظ", onPressed: () => controller.saveInvoice()),
                if (controller.invoice.value != null)
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      ButtonWidget(text: "طباعة", onPressed: () => controller.printInvoice(context)),
                      if (controller.invoice.value != null && (permissions.edit ?? false))
                        const SizedBox(width: 5),
                      if (controller.invoice.value != null && (permissions.edit ?? false))
                        ButtonWidget(
                            text: "طباعة قيد",
                            onPressed: () => controller.printGeneralJournal(context)),
                    ],
                  ),
                const SizedBox(width: 5),
                if((permissions.add ?? false))
                  const SizedBox(width: 5),
                if((permissions.add ?? false))
                  ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice()),
                if((permissions.delete ?? false) && controller.invoice.value?.id != null)
                  const SizedBox(width: 5),
                if((permissions.delete ?? false) && controller.invoice.value?.id != null)
                  ButtonWidget(text: "حذف", onPressed: () => controller.deleteInvoice()),
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
