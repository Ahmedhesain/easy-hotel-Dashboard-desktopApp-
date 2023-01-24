


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import '../../controllers/coupons_controller.dart';

class AddCouponsButtonWidget extends GetView<CouponsController> {
  const AddCouponsButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonWidget(
              text: "حفظ",
              contentPadding: EdgeInsets.all(5),
              buttonColor: Colors.green,
              onPressed: ()=> controller.saveCoupon(),
              ),
            ButtonWidget(
              text: "رجوع",
              contentPadding: EdgeInsets.all(5),
              buttonColor: Colors.red,
              onPressed: () => Get.back(),
              ),
          ],
        ),
      ),
    );
  }
}
