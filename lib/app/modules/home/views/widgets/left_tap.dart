import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:toby_bills/app/components/text_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';


class BranchWidget extends GetView<HomeController> {
  const BranchWidget(this.name, this.index, this.valueOne, this.valueTwo,
      this.valueThree, this.valueFour, {Key? key}) : super(key: key);
  final String? name;
  final int ?index;
  final double? valueOne;
  final double? valueTwo;
  final double? valueThree;
  final double? valueFour;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: size.height * .2,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15.00)),
            border: Border.all(color: AppColors.appGreyDark, width: 2),

            color: index == 0 ? AppColors.brownOne : index == 1 ? AppColors
                .greenOne : index == 2 ?
            AppColors.redOne : index! % 3 == 0 ? AppColors.blueOne : index! %
                5 == 0 ? AppColors.greyOne :
            AppColors.brownOne,
          ),
          child: Column(
            children: [
              SizedBox(
                  height: 30,
                  width: size.width,
                  child: Center(child: TextWidget(name!, size: 15,
                    weight: FontWeight.bold,
                    textColor: Colors.white,))),
              Container(
                color: AppColors.appGreyDark,
                width: size.width,
                height: 1,
              ),
              Container(
                  color: index == 0 ? AppColors.brownTwo : index == 1 ? AppColors
                      .greenTwo : index == 2 ?
                  AppColors.redTwo : index! % 3 == 0 ? AppColors.blueTwo : index! %
                      5 == 0 ? AppColors.greyTwo :
                  AppColors.brownTwo,
                  height: 55,
                  width: size.width,
                  child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.0,0,15,5),
                          child: TextWidget("اليوم",size: 13,textColor: Colors.white,weight: FontWeight.bold,),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(5.0,15,5,5),
                              child: new LinearPercentIndicator(
                                width: size.width *.13,
                                trailing: TextWidget("55",size: 10,textColor: Colors.white,),
                                animation: true,
                                lineHeight: 9.0,
                                animationDuration: 2500,
                                percent: 0.8,
                                // center: TextWidget("80.0%",size: 6,),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: AppColors.yellow,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5.0,5,5,5),
                              child: new LinearPercentIndicator(
                                width: size.width *.13,
                                animation: true,
                                trailing: TextWidget("55",size: 10,textColor: Colors.white,),
                                lineHeight: 9.0,
                                animationDuration: 2500,
                                percent: 0.65,
                                // center: TextWidget("80.0%",size: 6,),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: AppColors.blue,
                              ),
                            ),


                          ],
                        )

                      ],
                    )


              ),
              Container(
                color: AppColors.appGreyDark,
                width: size.width,
                height: 1,
              ),
              Container(
                  color: index == 0 ? AppColors.brownThree : index == 1 ? AppColors
                      .greenThree : index == 2 ?
                  AppColors.redThree : index! % 3 == 0 ? AppColors.blueThree : index! %
                      5 == 0 ? AppColors.greyTwo :
                  AppColors.brownThree,
                  height: 55,
                  width: size.width,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.0,0,15,5),
                        child: TextWidget("اليوم",size: 13,textColor: Colors.white,weight: FontWeight.bold,),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(5.0,15,5,5),
                            child: new LinearPercentIndicator(
                              width: size.width *.13,
                              trailing: TextWidget("55",size: 10,textColor: Colors.white,),
                              animation: true,
                              lineHeight: 9.0,
                              animationDuration: 2500,
                              percent: 0.8,
                              // center: TextWidget("80.0%",size: 6,),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: AppColors.yellow,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5.0,5,5,5),
                            child: new LinearPercentIndicator(
                              width: size.width *.13,
                              animation: true,
                              trailing: TextWidget("55",size: 10,textColor: Colors.white,),
                              lineHeight: 9.0,
                              animationDuration: 2500,
                              percent: 0.65,
                              // center: TextWidget("80.0%",size: 6,),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: AppColors.blue,
                            ),
                          ),


                        ],
                      )

                    ],
                  )


              ),
              Container(
                color: AppColors.appGreyDark,
                width: size.width,
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 14,height: 14,color: AppColors.yellow,
                    ),
                    TextWidget("عدد الاوردرات",size: 12,textColor: Colors.white,weight: FontWeight.bold,),
                    Container(
                      width: 14,height: 14,color: AppColors.blue,
                    ),
                    TextWidget("المبيعات",size: 12,textColor: Colors.white,weight: FontWeight.bold,)
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
