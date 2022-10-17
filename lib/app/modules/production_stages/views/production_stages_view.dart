import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:toby_bills/app/modules/production_stages/controllers/production_stages_controller.dart';

class ProductionStagesView extends GetView<ProductionStagesController>{
  const ProductionStagesView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx((){
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: size.width * 0,
            title: Row(
              children: [
                UnconstrainedBox(
                  child: ElevatedButton(
                    child: const Text("رجوع"),
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 10),
                UnconstrainedBox(
                  child: ElevatedButton(
                    child: const Text("طباعة"),
                    onPressed: () {
                      PrintingHelper().productionStages(context, controller.reports, Get.find<HomeController>().invoice.value!);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                UnconstrainedBox(
                  child: ElevatedButton(
                    child: const Text("تصدير الى اكسل"),
                    onPressed: () {
                      ExcelHelper.productionStagesExcel(controller.reports, context);
                    },
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              rowHeader(),
              Expanded(child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.reports.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: (index % 2) == 0 ? Colors.grey.withOpacity(0.1) : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: TextDirection.rtl,
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  controller.reports[index].number.toString(),
                                  // style: subtitleStyle.copyWith(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.reports[index].date == null
                                    ? ""
                                    : DateFormat("MM/dd/yyyy").format(controller.reports[index].date!),
                                // style: subtitleStyle.copyWith(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.reports[index].productName.toString(),
                                // style: subtitleStyle.copyWith(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.reports[index].quantity.toString(),
                                // style: subtitleStyle.copyWith(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  controller.reports[index].stage.toString(),
                                  // style: subtitleStyle.copyWith(fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                controller.reports[index].empName.toString(),
                                // style: subtitleStyle.copyWith(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),)
            ],
          ),
        ),
      );
    });
  }

  Widget rowHeader() {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: headerBar(nameHeader: "#")),
        Expanded(child: headerBar(nameHeader: "التاريخ")),
        Expanded(child: headerBar(nameHeader: "اسم الصنف")),
        Expanded(child: headerBar(nameHeader: "الكمية")),
        Expanded(child: headerBar(nameHeader: "المرحلة")),
        Expanded(child: headerBar(nameHeader: "الموظف")),
      ],
    );
  }

  Widget headerBar({required String nameHeader}) {
    return SizedBox(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 20.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              nameHeader,
            ),
          ),
          Container(
            width: 2,
            height: 40,
            color: Colors.grey.withOpacity(0.6),
          )
        ],
      ),
    );
  }

}