import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/notifications/controllers/notifications_controller.dart';

class NotificationsButtonsWidget extends GetView<NotificationsController> {
  const NotificationsButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final permission = UserManager().user.userScreens["customeraddnotice"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 15.0),
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
                  hintText: "ابحث عن سند اشعار",
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white70,
                  suffixIcon: IconButtonWidget(
                    icon: Icons.search,
                    onPressed: () => controller.searchByNotification(),
                  )
              ),
              onFieldSubmitted: (_) => controller.searchByNotification(),
              controller: controller.notificationNumberController,
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
                  ButtonWidget(text: "إضافة", onPressed: () => controller.addNotification()),
                  const SizedBox(width: 5),
                  if((permission?.edit ?? false) || controller.invoice.value?.id == null)
                    ButtonWidget(text: "حفظ", onPressed: () => controller.saveNotification()),
                  if((permission?.add ?? false))
                    const SizedBox(width: 5),
                  if((permission?.add ?? false))
                    ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice()),
                  if(controller.notification.value?.id != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 5),
                        ButtonWidget(text: "طباعة قيد", onPressed: () => controller.printGeneralJournal(context)),
                        if((permission?.delete ?? false) && controller.invoice.value?.id != null)
                          const SizedBox(width: 5),
                        if((permission?.delete ?? false) && controller.invoice.value?.id != null)
                          ButtonWidget(text: "حذف", onPressed: () => controller.deleteNotification()),
                      ],
                    ),
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
