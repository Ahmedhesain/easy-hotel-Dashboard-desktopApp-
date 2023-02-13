import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import '../../../../components/button_widget.dart';
import '../../../../components/date_field_widget.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/utils/daily_printing_helper.dart';
import '../../../../core/values/app_colors.dart';
import '../../controllers/daily_report_controller.dart';

class DailyReportSearchWidget extends GetView<DailyReportController> {
  const DailyReportSearchWidget({Key? key}) : super(key: key);

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
                  children: [
                    SizedBox(
                      width: size.width,
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: SizedBox(
                                      width: size.width * 0.06,
                                      child: const TextWidget(
                                        'المعرض',
                                        size: 15,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  space,
                                  Container(
                                    width: size.width * 0.2,
                                    height: size.height * 0.06,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: AppColors.appGreyLight,
                                      // border: Border.all(color: Colors.grey)
                                    ),
                                    child: Obx(() {
                                      return DropDownMultiSelect(
                                        options: controller.galleries
                                            .map((e) => e.name ?? "")
                                            .toList(),
                                        selectedValues: controller.selectedGalleries
                                            .map((e) => e.name ?? "")
                                            .toList(),
                                        onChanged: (values) {
                                          Get.back();
                                          controller.selectNewDeliveryplace(values);
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                        isDense: true,
                                        childBuilder: (List<String> values) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                values.isEmpty
                                                    ? "يرجى تحديد معرض على الاقل"
                                                    : values.join(', '),
                                                maxLines: 1,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              space,
                              SizedBox(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: SizedBox(
                                        width: size.width * 0.06,
                                        child: const TextWidget(
                                          "الفتره",
                                          size: 15,
                                          weight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    space,
                                    Container(
                                      width: size.width * 0.1,
                                      height: size.height * 0.07,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.appGreyLight,
                                      ),
                                      child: DateFieldWidget(
                                        date: controller.dateFrom.value,
                                        label: "من",
                                        hideBorder: true,
                                        onComplete: (DateTime date) {
                                          controller.dateFrom.value = date;
                                        },
                                      ),
                                    ),
                                    space,
                                    Container(
                                      width: size.width * 0.1,
                                      height: size.height * 0.07,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.appGreyLight,
                                      ),
                                      child: DateFieldWidget(
                                        date: controller.dateTo.value,
                                        label: "الي",
                                        hideBorder: true,
                                        onComplete: (DateTime date) {
                                          controller.dateTo.value = date;
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    spaceV,
                    SizedBox(
                      width: size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: size.width * 0.06,
                              height: size.height * 0.06,
                              child: const TextWidget(
                                "الخزائن",
                                size: 15,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                          space,
                          Container(
                            width: size.width * 0.2,
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.appGreyLight,
                            ),
                            child: Obx(() {
                              return DropDownMultiSelect(
                                options: controller.banks
                                    .map((e) => e.name ?? "")
                                    .toList(),
                                selectedValues: controller.selectedBanks
                                    .map((e) => e.name ?? "")
                                    .toList(),
                                onChanged: (values) {
                                  Get.back();
                                  controller.selectNewBank(values);
                                },
                                isDense: true,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                childBuilder: (List<String> values) {
                                  return Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0)
                                          .copyWith(left: 15),
                                      child: Text(
                                        values.isEmpty
                                            ? "يرجى تحديد خزينة على الاقل"
                                            : values.join(', '),
                                        maxLines: 1,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    spaceV,
                    SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonWidget(
                            text: "بحث",
                            onPressed: () => controller.getReport(false),
                            contentPadding: const EdgeInsets.all(15),
                          ),
                          space,
                          ButtonWidget(
                            text: "طباعة",
                            onPressed: () => DailyPrintingHelper().dailyReport(
                                context: context,
                                treasuries: controller.treasuries,
                                expenses: controller.expenses,
                                date: controller.dateFrom.value,
                                actualNet: controller.treasuriesNetTotal.value,
                                netBank: controller.netBank.value,
                                tamara: controller.netTamaraBank.value,
                                totalExpenses: controller.expensesTotal.value,
                                totalTreasuries:
                                    controller.treasuriesTotal.value,
                                totalTreasuriesPreviousDay:
                                    controller.treasuriesPreviousTotal.value,
                                transfers: controller.transfersBank.value),
                            contentPadding: const EdgeInsets.all(15),
                          ),
                          space,
                          ButtonWidget(
                            text: "رجوع",
                            onPressed: () => Get.back(),
                            buttonColor: Colors.redAccent,
                            contentPadding: const EdgeInsets.all(15),
                          )
                        ],
                      ),
                    )
                  ],
                ))));
  }
}
