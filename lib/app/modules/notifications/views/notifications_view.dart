import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/keys_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/notifications/views/widgets/notifications_header_widget.dart';

import '../controllers/notifications_controller.dart';
import 'widgets/notifications_buttons_widget.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return KeysWidget(
        enabled: !controller.isLoading.value,
        newFunc: () => controller.newInvoice(),
        saveFunc: () => controller.saveNotification(),
        printJournalFunc: () => controller.printGeneralJournal(context),
        child: AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Scaffold(
              body: Column(
                children: [
                  const NotificationsButtonsWidget(),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: Colors.grey)),
                    margin: const EdgeInsets.all(20),
                    clipBehavior: Clip.antiAlias,
                    child: NotificationsHeaderWidget(),
                  ),
                ],
              )
          ),
        ),
      );
    });
  }
}
