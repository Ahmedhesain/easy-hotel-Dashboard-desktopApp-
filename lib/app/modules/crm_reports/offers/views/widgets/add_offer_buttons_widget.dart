


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import '../../controllers/offers_controller.dart';

class AddOffersButtonWidget extends GetView<OffersController> {
  const AddOffersButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonWidget(
              text: "حفظ",
              contentPadding: EdgeInsets.all(5),
              buttonColor: Colors.green,
              onPressed: (){},
              ),
            ButtonWidget(
              text: "رجوع",
              contentPadding: const EdgeInsets.all(5),
              buttonColor: Colors.red,
              onPressed: () => Get.back(),
              ),
          ],
        ),
      ),
    );
  }
}
