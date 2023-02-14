import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manger/app/modules/spa/controllers/spa_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:hotel_manger/app/components/text_widget.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/modules/home/controllers/home_controller.dart';


class PercentageWidget extends GetView<SpaHomeController> {
  const PercentageWidget(this.name, this.value, this.best, {Key? key}) : super(key: key);
  final String? name;
  final double? value;
  final double? best;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWidget(name!, size: 20,
              textColor: AppColors.font,
              weight: FontWeight.bold,),
          ),


              Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 0, 20, 5),
              child: LinearPercentIndicator(
                width: size.width * .28,
                trailing: TextWidget(
                  (value! + best!).toStringAsFixed(0), size: 25, textColor: AppColors.font,),
                animation: true,
                lineHeight: 11.0,
                animationDuration: 2500,
                percent: (value! + best!) / 100,
                // center: TextWidget("80.0%",size: 6,),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: AppColors.blue,
              ),
            )


        ],
      ),

    );
  }
}
