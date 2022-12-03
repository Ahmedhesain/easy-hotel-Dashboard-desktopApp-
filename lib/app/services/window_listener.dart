import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/content_dialog.dart';
import 'package:toby_bills/app/components/text_widget.dart';
import 'package:toby_bills/main.dart';
import 'package:window_manager/window_manager.dart';

class MyWindowListener with WindowListener{

  @override
  void onWindowClose() async {
    if(windowController != null){
      windowController!.close();
      return;
    }
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      Get.dialog(ContentDialog(
        title: const TextWidget('تأكيد الإغلاق', weight: FontWeight.bold,size: 20),
        content: const TextWidget('هل انت متأكد انك تريد اغلاق البرنامج'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(150)
            ),
            onPressed: () {
              Get.back();
            },
            child: const TextWidget('لا'),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromWidth(150)
            ),
            onPressed: () {
              windowManager.destroy();
            },
            child: const TextWidget('نعم'),
          ),
        ],
      ));
    }
  }

}