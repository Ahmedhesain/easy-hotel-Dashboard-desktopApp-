


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';

import '../../controllers/customers_controller.dart';

class SendMsgDialog extends GetView<CustomersController> {
  const SendMsgDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        color: Colors.white,
        width: size.width * 0.7 ,
        height: size.height * 0.4 ,
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.7 ,
              height: size.height * 0.2 ,
              child: TextFormField(
                controller: controller.msgController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "ارسل رسالة للعملاء"
                ),
              ),
            ),
            ButtonWidget(text: "ارسال", contentPadding: EdgeInsets.all(20), onPressed: () => controller.sendSms(),)
          ],
        ),
      ),
    );
  }
}
