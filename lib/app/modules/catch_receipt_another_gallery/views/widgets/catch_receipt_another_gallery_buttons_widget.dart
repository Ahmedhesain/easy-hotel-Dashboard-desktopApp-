import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/catch_receipt_another_gallery/controllers/catch_receipt_another_gallery_controller.dart';

class CatchReceiptAnotherGalleryButtonsWidget extends GetView<CatchReceiptAnotherGalleryController> {
  const CatchReceiptAnotherGalleryButtonsWidget({Key? key}) : super(key: key);

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
            child: Obx(() {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonWidget(text: "حفظ", onPressed: () => controller.save()),
                  const SizedBox(width: 5),
                  ButtonWidget(text: "جديد", onPressed: () => controller.newPay()),
                  if(controller.glBankTransactionApi.value != null)
                    const SizedBox(width: 5),
                  if(controller.glBankTransactionApi.value != null)
                    ButtonWidget(text: "طباعة قيد", onPressed: () => controller.printGeneralJournal(context)),
                  const SizedBox(width: 5),
                  ButtonWidget(text: "رجوع", onPressed: () => Get.back()),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

}
