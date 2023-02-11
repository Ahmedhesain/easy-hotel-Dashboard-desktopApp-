import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../data/model/crm_reports/dto/response/branch_report_response.dart';
import '../../../../../data/model/reports/dto/response/categories_totals_response.dart';

class GalleryInfoWidget extends StatelessWidget {
  const GalleryInfoWidget({Key? key , required this.reportResponse}) : super(key: key);
  final BranchReportResponse  reportResponse ;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                child: ExpansionTile(
                  title: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SizedBox(
                        child: TextWidget(
                          reportResponse.gallaryName ??
                              "",
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ) ,

                  children:[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        spaceV,
                        SizedBox(
                          width: size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
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
                                            height: size.height * 0.05,
                                            color: AppColors.appGreyLight,
                                            child: Center(
                                              child: TextWidget(
                                                reportResponse.invoiceNumber
                                                    .toString() ??
                                                    "",
                                                size: 15,
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.4,
                                          child:SfCircularChart(
                                              series: <CircularSeries>[
                                                // Render pie chart
                                                PieSeries<
                                                    CategoriesTotalsResponse,
                                                    String>(
                                                    dataSource: reportResponse
                                                        .summitionItemsViewList,

                                                    // dataSource: controller.reportResponse.value?.summitionItemsViewList ?? [],
                                                    pointColorMapper: (
                                                        CategoriesTotalsResponse data,
                                                        _) => data.color,
                                                    dataLabelSettings: DataLabelSettings(
                                                        textStyle: const TextStyle(
                                                            fontSize: 10),
                                                        overflowMode: OverflowMode.trim,

                                                        builder: (data , point , _ , i , ii){
                                                          return Container(
                                                            color:
                                                            reportResponse
                                                                .summitionItemsViewList?[i].color ?? Colors.black,
                                                            child: Padding(padding: const EdgeInsets.all(1)
                                                              ,child: TextWidget("${data
                                                                  .name}\n${data
                                                                  .number}" , weight: FontWeight.bold,), ),
                                                          );
                                                        },
                                                        labelPosition: ChartDataLabelPosition
                                                            .outside,
                                                        isVisible: true
                                                    ),
                                                    xValueMapper: (
                                                        CategoriesTotalsResponse data,
                                                        i) => data.name ?? "",
                                                    yValueMapper: (
                                                        CategoriesTotalsResponse data,
                                                        i) => data.number ?? 0,
                                                    enableTooltip: true,
                                                    radius: "100"
                                                )
                                              ]
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
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
                                            height: size.height * 0.05,
                                            color: AppColors.appGreyLight,
                                            child: Center(
                                              child: TextWidget(reportResponse.invoiceValue
                                                  .toString() ??
                                                  "",
                                                size: 15,
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.4,
                                          child: SfCircularChart(
                                              series: <CircularSeries>[
                                                // Render pie chart
                                                PieSeries<
                                                    CategoriesTotalsResponse,
                                                    String>(
                                                  dataSource:
                                                  reportResponse
                                                      ?.summitionItemsViewList,
                                                  radius: "100",
                                                  // dataSource: controller.reportResponse.value?.summitionItemsViewList ?? [],
                                                  pointColorMapper: (
                                                      CategoriesTotalsResponse data,
                                                      _) => data.color,
                                                  dataLabelSettings: DataLabelSettings(
                                                    overflowMode: OverflowMode.trim,
                                                    labelAlignment: ChartDataLabelAlignment.outer,
                                                    textStyle: const TextStyle(
                                                        fontSize: 10),
                                                    builder: (data , point , _ , i , ii){
                                                      return Container(
                                                        color:
                                                        reportResponse
                                                            .summitionItemsViewList?[i].color ?? Colors.black,
                                                        child: Padding(padding: EdgeInsets.all(1)
                                                          ,child: TextWidget("${data
                                                              .name}\n${data.allCost}" , weight: FontWeight.bold,),),
                                                      );
                                                    },
                                                    isVisible: true ,
                                                    labelPosition: ChartDataLabelPosition.outside,

                                                  ),
                                                  enableTooltip: true,
                                                  xValueMapper: (
                                                      CategoriesTotalsResponse data,
                                                      i) => data.name ?? "null",
                                                  yValueMapper: (
                                                      CategoriesTotalsResponse data,
                                                      i) => data.allCost ?? 0.0,

                                                )
                                              ]
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
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
                                            height: size.height * 0.05,
                                            color: AppColors.appGreyLight,
                                            child: Center(
                                              child: TextWidget(
                                                reportResponse.allCostAverage.toString() ??"0",
                                                size: 15,
                                                weight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: size.width * 0.4,
                                          child:SfCircularChart(
                                        series: <CircularSeries>[
                                        // Render pie chart
                                        PieSeries<
                                          CategoriesTotalsResponse,
                                          String>(
                                              dataSource:
                                              reportResponse.summitionItemsViewList,
                                              // dataSource: controller.reportResponse.value?.summitionItemsViewList ?? [],
                                              pointColorMapper: (
                                              CategoriesTotalsResponse data,
                                              _) => data.color,
                                          dataLabelSettings: DataLabelSettings(
                                              color: Colors.black,
                                              textStyle: const TextStyle(
                                                  fontSize: 10),
                                              builder: (data , point , _ , i , ii){
                                                return Container(
                                                  color:
                                                  reportResponse.summitionItemsViewList?[i].color ?? Colors.black,
                                                  child: Padding(padding: EdgeInsets.all(2)
                                                    ,child: TextWidget("${data
                                                        .name}\n${data
                                                        .allAvarageCost}" , weight: FontWeight.bold,),),
                                                );
                                              },
                                              labelPosition: ChartDataLabelPosition
                                                  .outside,
                                              isVisible: true
                                          ),
                                          xValueMapper: (
                                              CategoriesTotalsResponse data,
                                              i) => data.name ?? "",
                                          radius: "100",
                                          yValueMapper: (
                                              CategoriesTotalsResponse data,
                                              i) =>
                                          data.allAvarageCost ?? 0,
                                          enableTooltip: true,
                                          explode: true,
                                        )
                                      ]
                              ),
                                        )

                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
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
                                              child: TextWidget(reportResponse.allCustomer
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
                                    width: size.width * 0.2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
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

                                                reportResponse.allNewCustomer
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
