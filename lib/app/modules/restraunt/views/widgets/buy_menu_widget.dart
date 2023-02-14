import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:hotel_manger/app/components/text_widget.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/modules/home/controllers/home_controller.dart';


class BuyMenuWidget extends GetView<HomeController> {
  const BuyMenuWidget(  {Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size.height * .27,
          width: size.width*.2,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15.00)),
            border: Border.all(color: AppColors.appGreyDark, width: 1.5),

            color: Colors.white
          ),
          child:Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,66,0,0),
              child: PieChart(
                dataMap: {
              "المتاخرات": controller.listPurchase!.lateOrders!/10,
              "اجمالي الاوردرات": controller.listPurchase!.totalOrders!/10,

              },
                animationDuration: Duration(milliseconds: 900),
                chartLegendSpacing: 32,
                chartRadius: size.width *.04,
                colorList:controller.gradientList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 140,
                // centerText: "HYBRID",
                legendOptions: const LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                  showLegends: false,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                    decimalPlaces: 0,
                    chartValueBackgroundColor: Colors.transparent,
                    chartValueStyle: TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold,backgroundColor: Colors.transparent)
                ),
                // gradientList: ---To add gradient colors---
                // emptyColorGradient: ---Empty Color gradient---
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,66,0,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 14,height: 14,color: AppColors.blue,
                  ),
                  TextWidget("اجمالي الاوردرات",size: 15,textColor: AppColors.blue,weight: FontWeight.bold,),
                  Container(
                    width: 14,height: 14,color: AppColors.redOne,
                  ),
                  TextWidget("المتاخرات",size: 15,textColor: AppColors.redOne,weight: FontWeight.bold,)
                ],
              ),
            )

          ],)

        ),
      ),
    );
  }
}
