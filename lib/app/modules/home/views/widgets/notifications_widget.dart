import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/text_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../../data/model/fcm/dto/response/notification_response_dto.dart';

class NotificationsWidget extends GetView<HomeController> {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => controller.notificationsSelectedIndex.value = 0,
                child: Card(
                  elevation: controller.notificationsSelectedIndex.value == 0 ? 3 : 0,
                  color: controller.notificationsSelectedIndex.value == 0 ? Colors.white : AppColors.appGreyDark,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget('الاشعارات', weight: FontWeight.bold, onTap: () => controller.notificationsSelectedIndex.value = 0),
                        Obx(() =>
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red
                                ),
                                width: 15,
                                child: Center(
                                    child: Text(controller.notificationsList.length.toString(), style: TextStyle(color: Colors.white),)),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.notificationsSelectedIndex.value = 0,
                child: Card(
                  elevation: controller.notificationsSelectedIndex.value == 1 ? 3 : 0,
                  color: controller.notificationsSelectedIndex.value == 1 ? Colors.white : AppColors.appGreyDark,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget('الشكاوي', weight: FontWeight.bold, onTap: () => controller.notificationsSelectedIndex.value = 1,),
                        Obx(() =>
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red
                                ),
                                width: 15,
                                child: Center(child: Text(controller.eventsList.length.toString(), style: TextStyle(color: Colors.white),)),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Card(
            elevation: 3,
            child: Container(
              width: size.width * 0.16,
              height: size.height * 0.25,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: controller.notificationsSelectedIndex.value == 0 ? SingleChildScrollView(
                child: Obx(() {
                  return Column(
                    children: [
                      for(NotificationResponseDTO noti in controller.notificationsList)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextWidget(noti.text ?? ''),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: MaterialButton(
                                      child: Center(child: Icon(Icons.delete_forever_outlined, color: Colors.red, size: 15,)),
                                      onPressed: () => controller.deleteNotification(noti.id),
                                    ),
                                  ),),
                              ],
                            ),
                          ),
                        )
                    ],
                  );
                }),
              ) : SingleChildScrollView(
                child: Obx(() {
                  return Column(
                    children: [
                      for(NotificationResponseDTO noti in controller.eventsList)
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextWidget(noti.text ?? ''),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: MaterialButton(
                                      child: Center(child: Icon(Icons.delete_forever_outlined, color: Colors.red, size: 15,)),
                                      onPressed: () => controller.deleteEvent(noti.id),
                                    ),
                                  ),),
                              ],
                            ),
                          ),
                        )
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      );
    });
  }
}
