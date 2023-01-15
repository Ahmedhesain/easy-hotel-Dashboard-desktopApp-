import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/text_widget.dart';
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: size.width * 0.16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget('الاشعارات', weight: FontWeight.bold,),
                Obx(() =>
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle ,
                          color: Colors.red
                        ),
                        width: 15,
                        child: Center(child: Text(controller.notificationsList.length.toString() , style: TextStyle(color: Colors.white),)),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
        Container(
          width: size.width * 0.16,
          height: size.height * 0.25,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: SingleChildScrollView(
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
          ),
        ),
      ],
    );
  }
}
