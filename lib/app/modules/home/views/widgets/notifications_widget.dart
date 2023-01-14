import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/text_widget.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../../data/model/fcm/dto/response/notification_response_dto.dart';

class NotificationsWidget extends GetView<HomeController> {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: SizedBox(
            width: size.width * 0.16,
            child: const Center(
              child: TextWidget('الاشعارات' , weight: FontWeight.bold,),
            ),
          ),
        ),
        Container(
          width: size.width * 0.16,
          height: size.height * 0.25,
          decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 for(NotificationResponseDTO noti in controller.notificationsList)
                   Padding(
                     padding: const EdgeInsets.all(4.0),
                     child: Container(
                       width: size.width *0.15,
                       decoration: BoxDecoration(
                         color: Colors.grey ,
                         borderRadius: BorderRadius.circular(10)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.all(4.0),
                         child: Center(
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               SizedBox(
                                   height: 20,
                                   width: size.width * 0.15,
                                   child: IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever_outlined , color: Colors.red, size: 15,))),
                               TextWidget(noti.text ?? ''),
                             ],
                           ),
                         ),
                       ),
                     ),
                   )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
