import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../data/model/reports/dto/response/categories_totals_response.dart';
import '../../controllers/branches_report_controller.dart';

class GalleryInfoWidget extends GetView<BranchesReportController> {
  const GalleryInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const space = SizedBox(
      width: 20,
    );
    const spaceV = SizedBox(
      height: 20,
    );
    return Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Card(
            color: AppColors.backGround,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          width: size.width * 0.06,
                          height: size.height * 0.07,
                          child: TextWidget(
                            controller.reportResponse.value?.gallaryName ?? "",
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.5,
                      child: GridView.count(
                        crossAxisCount: 3,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        childAspectRatio: size.aspectRatio *.6,
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            width : size.width * 0.2 ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: SizedBox(
                                    child: TextWidget(
                                      'اجمالي عدد الفواتير',
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Container(
                                    width: size.width * 0.06,
                                    height: size.height * 0.05,
                                    color: AppColors.appGreyLight,
                                    child: Center(
                                      child: TextWidget(
                                        controller
                                                .reportResponse.value?.invoiceNumber
                                                .toString() ??
                                            "",
                                        size: 15,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height *0.4,
                                  child: SfCircularChart(
                                      series: <CircularSeries>[
                                        // Render pie chart
                                          PieSeries<CategoriesTotalsResponse, String>(
                                            dataSource:controller.reportResponse.value?.summitionItemsViewList ?? [CategoriesTotalsResponse(name: "" , number: -0.01)],
                                            // dataSource: controller.reportResponse.value?.summitionItemsViewList ?? [],
                                            pointColorMapper:(CategoriesTotalsResponse data, _) => data.color,
                                            dataLabelSettings:  DataLabelSettings(
                                              color: Colors.black,
                                              textStyle: const TextStyle(fontSize: 12),

                                              labelPosition: ChartDataLabelPosition.inside,
                                                isVisible: controller.reportResponse.value?.summitionItemsViewList?.isNotEmpty ?? false
                                            ),
                                            xValueMapper: (CategoriesTotalsResponse data, i) => data.name,
                                            yValueMapper: (CategoriesTotalsResponse data, i) => data.number ?? -0.01,
                                            enableTooltip: true,
                                            dataLabelMapper:(CategoriesTotalsResponse data, i) => "${data.name}\n${data.number}",

                                        )
                                      ]
                                  ),
                                )

                              ],
                            ),
                          ),
                          SizedBox(
                            width : size.width * 0.2 ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: SizedBox(
                                    child: TextWidget(
                                      'اجمالي قيمة الفواتير',
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Container(
                                    width: size.width * 0.06,
                                    height: size.height * 0.05,
                                    color: AppColors.appGreyLight,
                                    child: Center(
                                      child: TextWidget(
                                        controller
                                                .reportResponse.value?.invoiceValue
                                                .toString() ??
                                            "",
                                        size: 15,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height *0.4,
                                  child: SfCircularChart(
                                      series: <CircularSeries>[
                                        // Render pie chart
                                        PieSeries<CategoriesTotalsResponse, String>(
                                          dataSource:controller.reportResponse.value?.summitionItemsViewList ?? [CategoriesTotalsResponse(name: "" , allCost: -0.01)],
                                          // dataSource: controller.reportResponse.value?.summitionItemsViewList ?? [],
                                          pointColorMapper:(CategoriesTotalsResponse data, _) => data.color,
                                          dataLabelSettings: DataLabelSettings(
                                              color: Colors.black,
                                              textStyle: const TextStyle(fontSize: 12),

                                              labelPosition: ChartDataLabelPosition.inside,
                                              isVisible: controller.reportResponse.value?.summitionItemsViewList?.isNotEmpty ?? false
                                          ),
                                          xValueMapper: (CategoriesTotalsResponse data, i) => data.name,
                                          yValueMapper: (CategoriesTotalsResponse data, i) => data.allCost ?? -0.01,
                                          enableTooltip: true,
                                          dataLabelMapper:(CategoriesTotalsResponse data, i) => "${data.name}\n${data.allCost == -0.01 ? "": data.allCost}",

                                        )
                                      ]
                                  ),
                                )

                              ],
                            ),
                          ),
                          SizedBox(
                            width : size.width * 0.2 ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: SizedBox(
                                    child: TextWidget(
                                      'اجمالي قيمة التكلفة',
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Container(
                                    width: size.width * 0.06,
                                    height: size.height * 0.05,
                                    color: AppColors.appGreyLight,
                                    child: Center(
                                      child: TextWidget(
                                        controller.allCostAverage.value?.toString() ??
                                            "",
                                        size: 15,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height *0.4,
                                  child: SfCircularChart(
                                      series: <CircularSeries>[
                                        // Render pie chart
                                        PieSeries<CategoriesTotalsResponse, String>(
                                          dataSource:controller.reportResponse.value?.summitionItemsViewList ?? [CategoriesTotalsResponse(name: "" , allAvarageCost: -0.01)],
                                          // dataSource: controller.reportResponse.value?.summitionItemsViewList ?? [],
                                          pointColorMapper:(CategoriesTotalsResponse data, _) => data.color,
                                          dataLabelSettings: DataLabelSettings(
                                              color: Colors.black,
                                              textStyle: const TextStyle(fontSize: 12),

                                              labelPosition: ChartDataLabelPosition.inside,
                                              isVisible: controller.reportResponse.value?.summitionItemsViewList?.isNotEmpty ?? false
                                          ),
                                          xValueMapper: (CategoriesTotalsResponse data, i) => data.name,
                                          yValueMapper: (CategoriesTotalsResponse data, i) => data.allAvarageCost ?? -0.01,
                                          enableTooltip: true,
                                          dataLabelMapper:(CategoriesTotalsResponse data, i) => "${data.name}\n${data.allAvarageCost == -0.01 ? "": data.allAvarageCost}",

                                        )
                                      ]
                                  ),
                                )

                              ],
                            ),
                          ),
                          SizedBox(
                            width : size.width * 0.2 ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: SizedBox(
                                    child: TextWidget(
                                      'اجمالي عدد العملاء',
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Container(
                                    width: size.width * 0.06,
                                    height: size.height * 0.05,
                                    color: AppColors.appGreyLight,
                                    child: Center(
                                      child: TextWidget(
                                        controller
                                                .reportResponse.value?.allCustomer
                                                .toString() ??
                                            "",
                                        size: 15,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width : size.width * 0.2 ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: SizedBox(
                                    child: TextWidget(
                                      'اجمالي عدد العملاء الجدد',
                                      size: 15,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Container(
                                    width: size.width * 0.06,
                                    height: size.height * 0.05,
                                    color: AppColors.appGreyLight,
                                    child: Center(
                                      child: TextWidget(
                                        controller
                                                .reportResponse.value?.allNewCustomer
                                                .toString() ??
                                            "",
                                        size: 15,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
