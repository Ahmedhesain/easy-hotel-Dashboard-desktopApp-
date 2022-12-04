import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/payments/controllers/payments_controller.dart';

class PaymentsButtonsWidget extends GetView<PaymentsController> {
  const PaymentsButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final permissions = UserManager().user.userScreens["settlementdeed"]!;
    return Center(
      child: Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 15.0),
        child: Row(
          children: [
            SizedBox(
              width: 250,
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {},
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    hintText: "ابحث",
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white70,
                    suffixIcon: IconButtonWidget(
                      icon: Icons.search,
                      onPressed: () => controller.searchPayment(),
                    )
                ),
                onFieldSubmitted: (_) => controller.searchPayment(),
                controller: controller.searchPaymentIdController,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
              child: Obx(() {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if((permissions.edit ?? false) || controller.payment.value?.id == null)
                      ButtonWidget(text: "حفظ", onPressed: () => controller.savePayment(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                    if(controller.payment.value != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (controller.payment.value != null && (permissions.edit ?? false))
                           ButtonWidget(text: "طباعة", onPressed: () => controller.printPayment(context), margin: const EdgeInsets.symmetric(horizontal: 2.5)),

                          if (controller.payment.value != null && (permissions.edit ?? false))
                            ButtonWidget(text: "طباعة قيد", onPressed: () => controller.printGeneralJournal(context), margin: const EdgeInsets.symmetric(horizontal: 2.5)),

                          if((permissions.delete ?? false) && controller.payment.value?.id != null)
                            ButtonWidget(text: "حذف", onPressed: () => controller.deletePayment(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                        ],
                      ),
                    if((permissions.add ?? false))
                      ButtonWidget(text: "جديد", onPressed: () => controller.newPayment(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                    ButtonWidget(text: "رجوع", onPressed: () => Get.back(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
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
