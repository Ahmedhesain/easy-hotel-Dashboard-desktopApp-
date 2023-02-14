import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manger/app/components/text_widget.dart';
import 'package:hotel_manger/app/core/utils/common.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/modules/home/controllers/home_controller.dart';
import 'package:hotel_manger/app/modules/restraunt/views/widgets/branch.dart';
import 'package:hotel_manger/app/modules/restraunt/views/widgets/buy_menu_widget.dart';
import 'package:hotel_manger/app/modules/restraunt/views/widgets/left_tap.dart';
import 'package:hotel_manger/app/modules/restraunt/views/widgets/percentage_widget.dart';
import 'package:hotel_manger/app/modules/restraunt/views/widgets/user_card.dart';
import 'package:hotel_manger/app/modules/restraunt/controllers/restraunt_controller.dart';


import '../../restraunt/views/widgets/top_bar_widget.dart';
import 'widgets/complain_card.dart';


class RestrauntHomeView extends GetView<RestrauntHomeController> {
  const RestrauntHomeView

  ({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appHallsRedDark,
        title: const Text(
          "Restraunt Service",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Common.getSpin(),
          );
        }
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
              color: AppColors.appGreyLight,
              width: size.width,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
                    child: Container(
                      width: size.width * 0.21,
                      height: size.height * .95,

                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10.00)),
                          border: Border.all(
                              color: AppColors.appGreyDark, width: 1.5),
                          color: Colors.white
                      ),
                      child: Column(

                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextWidget("بيان نمو وحاله الاقسام",
                              textColor: AppColors.appBlue, size: 20,),
                          ),
                          SizedBox(
                            height: size.height * .86,
                            child:
                            ListView.builder(
                              itemCount: controller.groupValueForDayAndMonth.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return BranchWidget(
                                    controller.groupValueForDayAndMonth[index].name, index, controller.groupValueForDayAndMonth[index].countOrderDay,
                                    controller.groupValueForDayAndMonth[index].valueOrderDay, controller.groupValueForDayAndMonth[index].countOrderMonth, controller.groupValueForDayAndMonth[index].valueOrderMonth
                                );
                              },

                            ),),


                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: SizedBox(
                          width: size.width * .75,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Obx(() {
                                    return TopBarWidget("عدد الاوردرات",
                                        controller.numOrders.value.toDouble());
                                  }),
                                  TopBarWidget("تحت التجهيز",
                                      controller.numberOrdersUnderProcessing
                                          .value.toDouble()),
                                  TopBarWidget("قيد التسليم",
                                      controller.numberOrdersUnderDelivery!.number
                                          .toDouble()),
                                  TopBarWidget("الاوردرات المتآخره",
                                      controller.numberOrdersLate!.number.toDouble() ),
                                  TopBarWidget("تم تسليمها",
                                      controller.numberOrdersDelivered!.number
                                          .toDouble()),
                                  TopBarWidget("اجمالي قيمه الاوردرات",
                                      controller.totalValueOrders!.value!),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              TextWidget("قائمه المشتريات", size: 20,
                                textColor: AppColors.font,
                                weight: FontWeight.bold,),
                              BuyMenuWidget(),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget("الاصناف الاكثر مبيعا", size: 20,
                                textColor: AppColors.font,
                                weight: FontWeight.bold,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: size.height * .27,
                                    width: size.width * .35,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15.00)),
                                        border: Border.all(
                                            color: AppColors.appGreyDark,
                                            width: 1.5),

                                        color: Colors.white
                                    ),
                                    child: ListView.builder(
                                      itemCount: controller.bestSellingList
                                          .length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return PercentageWidget(
                                            controller.bestSellingList[index]
                                                .name,
                                            controller.bestSellingList[index]
                                                .amount
                                        );
                                      },

                                    )

                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              LeftTapWidget(
                                  "مبيعات الاسبوع", controller.salesOfTheWeek!.value??0, AppColors.greenOne),
                              // LeftTapWidget(
                              //     "العملاء الجدد", controller.newClient!.number.toDouble(),
                              //     AppColors.blueOne)

                            ],
                          )

                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget(
                                "قائمه العملاء الاكثر شراءا", size: 20,
                                textColor: AppColors.font,
                                weight: FontWeight.bold,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: size.height * .43,
                                    width: size.width * .25,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(0.00)),
                                        border: Border.all(
                                            color: AppColors.appGreyDark,
                                            width: 1.5),

                                        color: Colors.white
                                    ),
                                    child: ListView.builder(
                                      itemCount: controller.mostBuyingClientsList
                                          .length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return UserCardWidget(
                                          title: controller
                                              .mostBuyingClientsList[index].name!,
                                          subtitle: controller
                                              .mostBuyingClientsList[index]
                                              .numbers!.toString(),
                                        );
                                      },

                                    )

                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget("تعليقات وشكاوي العملاء", size: 20,
                                textColor: AppColors.font,
                                weight: FontWeight.bold,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: size.height * .43,
                                    width: size.width * .23,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(0.00)),
                                        border: Border.all(
                                            color: AppColors.appGreyDark,
                                            width: 1.5),

                                        color: Colors.white
                                    ),
                                    child: ListView.builder(
                                      itemCount: controller.clientComments.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return  ComplainCardWidget(
                                          color: AppColors.greenOne,
                                          title: controller.clientComments[index].comment!,
                                          subtitle: '',
                                        );
                                      },

                                    )

                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget("رسائل العملاء", size: 20,
                                textColor: AppColors.font,
                                weight: FontWeight.bold,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    height: size.height * .43,
                                    width: size.width * .23,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(0.00)),
                                        border: Border.all(
                                            color: AppColors.appGreyDark,
                                            width: 1.5),

                                        color: Colors.white
                                    ),
                                    child: ListView.builder(
                                      itemCount: controller.groupClientMasseges.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return  ComplainCardWidget(
                                          color: AppColors.redOne,
                                          title: controller.groupClientMasseges[index].massege!,
                                          subtitle: '',
                                        );
                                      },

                                    )

                                ),
                              )
                            ],
                          ),


                        ],
                      ),
                    ],
                  )

                ],
              )
          ),
        );
      }),
    );
  }
}
