import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:hotel_manger/app/components/text_widget.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/modules/cars/controllers/cars_controller.dart';


class LeftTapWidget extends GetView<CarsHomeController> {
  const LeftTapWidget(this.name, this.value, this.color, {Key? key}) : super(key: key);
  final String? name;
  final double ?value;
  final Color ?color;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(onTap: () {},
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12,25,12,0),
        child: Container(
          height: size.height * .115,
          width: size.width*.15,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15.00)),
            border: Border.all(color: AppColors.appGreyDark, width: 2),

            color:color,
          ),
          child: Column(
            children: [
              TextWidget(name!,size: 30,weight: FontWeight.bold,textColor: Colors.white,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(value!.toStringAsFixed(0),size: 25,weight: FontWeight.bold,textColor: Colors.white,),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
