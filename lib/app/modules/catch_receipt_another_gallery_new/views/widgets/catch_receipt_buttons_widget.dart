import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/catch_receipt/controllers/catch_receipt_controller.dart';
import 'package:toby_bills/app/modules/notifications/controllers/notifications_controller.dart';

import '../../controllers/catch_receipt_another_gallery_new_controller.dart';

class CatchReceiptAnotherGalleryNewButtonsWidget extends GetView<CatchReceiptAnotherGalleryNewController> {
  const CatchReceiptAnotherGalleryNewButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final permission = UserManager().user.userScreens["notesreceivables"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 15.0),
      child: Row(
        children: [
          const Spacer(),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
            child: Obx(() {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(permission?.edit ?? false)
                    ButtonWidget(text: "حفظ", onPressed: () => controller.save(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                  if((permission?.add ?? false))
                    ButtonWidget(text: "جديد", onPressed: () => controller.newPay(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                  if(controller.glBankTransactionApi.value != null && (permission?.edit ?? false))
                    ButtonWidget(text: "طباعة قيد", onPressed: () => controller.printGeneralJournal(context), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                  if(controller.glBankTransactionApi.value != null && (permission?.edit ?? false))
                    ButtonWidget(text: "طباعة", onPressed: () => PrintingHelper().printCatchReceipt(controller.glBankTransactionApi.value!, context , controller.selectedCustomer.value?.name , controller.selectedGallery.value?.name), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                  ButtonWidget(text: "رجوع", onPressed: () => Get.back(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

}
