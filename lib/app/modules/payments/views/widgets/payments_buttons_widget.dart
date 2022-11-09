import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/payments/controllers/payments_controller.dart';

class PaymentsButtonsWidget extends GetView<PaymentsController> {
  const PaymentsButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.all(5),
              child: Obx(() {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonWidget(text: controller.payment.value != null ? "تعديل" : "حفظ", onPressed: () => controller.savePayment()),
                    if(controller.payment.value != null)
                      const SizedBox(width: 5),
                    if(controller.payment.value != null)
                      ButtonWidget(text: "طباعة", onPressed: () => controller.printPayment(context)),
                    if(controller.payment.value != null)
                      const SizedBox(width: 5),
                    if(controller.payment.value != null)
                      ButtonWidget(text: "حذف", onPressed: () => controller.deletePayment()),
                    const SizedBox(width: 5),
                    ButtonWidget(text: "جديد", onPressed: () => controller.newPayment()),
                    const SizedBox(width: 5),
                    ButtonWidget(text: "رجوع", onPressed: () => Get.back()),
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
