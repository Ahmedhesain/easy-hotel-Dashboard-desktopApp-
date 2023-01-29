

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';

import '../../controllers/customers_controller.dart';

class CustomersReportFilterWidget extends GetView<CustomersController> {
  const CustomersReportFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0 , 0 , 15 , 0),
      child: Card(
        elevation: 2,
          color: AppColors.backGround,
          child: Container(
            width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Container(
                width: size.width *0.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColors.appGreyLight)
                ),
                child: TextFormField(
                  onChanged: controller.filter,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "ابحث عن عميل معين"
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
