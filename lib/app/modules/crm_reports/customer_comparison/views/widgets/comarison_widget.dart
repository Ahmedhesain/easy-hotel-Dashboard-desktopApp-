

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_colors.dart';
import '../../controllers/customer_comparison_controller.dart';

class ComparisonWidget extends GetView<CustomerComparisonController> {
  const ComparisonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const space = SizedBox(height: 10,);
    return Obx(() =>Container(
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
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: size.width * 0.1,
                            child: const TextWidget(
                              "العميل الاول",
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.blue,
                        )
                      ],
                    ),
                    space,

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
                            width: size.width * 0.06,
                            child: TextWidget(
                              controller.reportResponse.value?.firstCustomer.totalInvoiceNumber?.toString() ?? "0",
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
                            width: size.width * 0.06,
                            child: TextWidget(
                              controller.reportResponse.value?.firstCustomer.totalThobeNumber?.toString() ?? "0",
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
                            width: size.width * 0.06,
                            child: TextWidget(
                              controller.reportResponse.value?.firstCustomer.totalInvoiceValue?.toString() ?? "0",
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: size.width * 0.3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            width: size.width * 0.1,
                            child: const TextWidget(
                              "العميل الثاني",
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          color: Colors.red,
                        )
                      ],
                    ),
                    space,
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
                            width: size.width * 0.06,
                            child: TextWidget(
                              controller.reportResponse.value?.secondCustomer.totalInvoiceNumber?.toString() ?? "0",
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
                            width: size.width * 0.06,
                            child: TextWidget(
                              controller.reportResponse.value?.secondCustomer.totalThobeNumber?.toString() ?? "0",
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
                            width: size.width * 0.06,
                            child: TextWidget(
                              controller.reportResponse.value?.secondCustomer.totalInvoiceValue?.toString() ?? "0",
                              size: 15,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    ) );

  }
}
