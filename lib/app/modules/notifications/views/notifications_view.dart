import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/keys_widget.dart';
import 'package:toby_bills/app/components/table.dart';
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
                    child: const NotificationsHeaderWidget(),
                  ),
                  Expanded(
                    child: TableWidget(
                      header: [
                        "العميل",
                        "رقم الفاتورة",
                        "نوع الإشعار",
                        "التاريخ",
                        "المبلغ",
                        "ملحوظات",
                        "المعرض",
                        "",
                      ]
                          .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Text(e, textAlign: TextAlign.center,),
                      ))
                          .toList(),
                      headerHeight: 40,
                      rows: controller.notifications
                          .map((e) => [
                        "${e.organizationSiteName}",
                        "${e.invInvoiceSerial}",
                        (e.typeNotice == 0 ? "مدين" : e.typeNotice == 1 ? "خصم" : "دائن"),
                        (e.date == null ? "" : DateFormat("yyy-MM-dd").format(e.date!)),
                        "${e.value}",
                        "${e.remark}",
                        "${controller.galleries.singleWhere((element) => element.id == e.gallaryId).name}",
                        "X",
                      ].map((d) {
                        if(d == 'X'){
                          return IconButtonWidget(
                            icon: Icons.clear_rounded,
                            onPressed: ()=> controller.notifications.remove(e),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            d,
                            maxLines: 2, textAlign: TextAlign.center
                          ),
                        );
                      }).toList())
                          .toList(),
                      minimumCellWidth: 150,
                      rowHeight: 50,
                    ),
                  )
                ],
              )
          ),
        ),
      );
    });
  }
}
