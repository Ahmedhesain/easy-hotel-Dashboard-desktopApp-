import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

class NavigationBarWidget extends GetView<HomeController> {
  const NavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: double.infinity,
        child: Obx(() {
          return Wrap(
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
                    if(controller.invoice.value == null)
                      ButtonWidget(text: "حفظ", onPressed: () => controller.saveInvoice()),
                    if(controller.invoice.value == null)
                      const SizedBox(width: 5),
                    ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice()),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

