import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_colors.dart';
import '../../controllers/customer_comparison_controller.dart';
class ComparisonPercentWidget extends GetView<CustomerComparisonController> {
  const ComparisonPercentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const space = SizedBox(height: 10,);
    return Obx(() =>  Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        color: AppColors.backGround,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: size.width * 0.1,
                            child: const TextWidget(
                              "اجمالي عدد الفواتير",
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: size.width * 0.1,
                            child:TextWidget(
                              controller.totalInvoiceNumber.value.toString(),
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    space,
                    Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.blue[700]!,
                                ),
                                 Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    child:TextWidget(
                                    "${100 -(controller.invoicePercent.value * 100)}%",
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            space,
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.red[700]!,
                                ),
                                 Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    child:TextWidget(
                                      "${controller.invoicePercent.value * 100}%",
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: size.height * 0.1,
                          lineWidth: size.height * 0.1,
                          percent:controller.invoicePercent.value,
                          progressColor: Colors.red[700]!,
                          backgroundColor: Colors.blue[700]!,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: size.width * 0.1,
                            child: const TextWidget(
                              "اجمالي عدد الثياب",
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: size.width * 0.1,
                            child:TextWidget(
                              controller.totalThobeNumber.value.toString(),
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    space,
                    Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.blue[700]!,
                                ),
                                 Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    child:TextWidget(
                                      "${100 - (controller.thobePercent.value * 100)}%",
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            space,
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.red[700]!,
                                ),
                                 Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    child:TextWidget(
                                      "${controller.thobePercent.value * 100}%",
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: size.height * 0.1,
                          lineWidth: size.height * 0.1,
                          percent: controller.thobePercent.value,
                          progressColor: Colors.red[700],
                          backgroundColor: Colors.blue[700]!,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: size.width * 0.1,
                            child: const TextWidget(
                              "اجمالي قيمة الفواتير",
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: size.width * 0.1,
                            child:TextWidget(
                              controller.totalValueNumber.value.toString(),
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    space,
                    Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.blue[700]!,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    child:TextWidget(
                                      "${100-(controller.valuePercent.value * 100)}%",
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            space,
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  color: Colors.red[700]!,
                                ),
                                 Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: SizedBox(
                                    child:TextWidget(
                                      "${controller.valuePercent.value * 100}%",
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: size.height * 0.1,
                          lineWidth: size.height * 0.1,
                          percent: controller.valuePercent.value,
                          progressColor: Colors.red[700]!,
                          backgroundColor: Colors.blue[700]!,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
