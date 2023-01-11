import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
import 'package:toby_bills/app/components/scrollable_row.dart';
import 'package:toby_bills/app/components/table.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';

import '../../../components/date_field_widget.dart';
import '../controllers/invoices_query_controller.dart';

class InvoicesQueryView extends GetView<InvoicesQueryController> {
  const InvoicesQueryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Obx(() {
        return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Column(
            children: [
              ScrollableRow(
                minimumWidth: 800,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                children: (isScrollable) {
                  return [
                    Container(
                      width: 200,
                      margin: const EdgeInsets.all(5.0),
                      child: TextFormField(
                          controller: controller.searchedInvoiceController,
                          onFieldSubmitted: (_) => controller.getInvoices(),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "ابحث عن رقم الفاتورة",
                              contentPadding: EdgeInsets.symmetric(horizontal: 5))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          const Text(
                            "من تاريخ: ",
                          ),
                          SizedBox(
                            width: 110,
                            child: DateFieldWidget(
                              onComplete: (date) {
                                controller.dateFrom(date);
                              },
                              date: controller.dateFrom.value,
                            ),
                          ),
                          // Obx(() {
                          //       return MouseRegion(
                          //         cursor: SystemMouseCursors.click,
                          //         child: GestureDetector(
                          //             onTap: () {
                          //               controller.pickFromDate();
                          //             },
                          //             child: Text(
                          //               DateFormat("yyyy-MM-dd").format(controller.dateFrom.value),
                          //               style: const TextStyle(decoration: TextDecoration.underline),
                          //             )),
                          //       );
                          //     }),
                          const SizedBox(width: 15),
                          const Text(
                            "الى تاريخ: ",
                          ),
                          SizedBox(
                            width: 110,
                            child: DateFieldWidget(
                              onComplete: (date) {
                                controller.dateTo(date);
                              },
                              date: controller.dateTo.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      return SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.15,
                              child: RadioListTile(
                                value: 0,
                                groupValue: controller.searchType.value,
                                onChanged: (val) => controller.searchType.value = val!,
                                title: const Text("بحث برقم الفاتورة"),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.15,
                              child: RadioListTile(
                                value: 1,
                                groupValue: controller.searchType.value,
                                onChanged: (val) => controller.searchType.value = val!,
                                title: const Text("بحث بالتاريخ"),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    if (!isScrollable) const Spacer(),
                    if (isScrollable) const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => controller.getInvoices(),
                      child: const Text("بحث"),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => PrintingHelper().galleryInvoices(context, controller.invoices),
                      child: const Text("طباعة"),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        ExcelHelper.invoicesQueryExcel(controller.invoices, context);
                      },
                      child: const Text("تصدير الى اكسل"),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      child: const Text("رجوع"),
                    ),
                  ];
                },
              ),
              const Divider(),
              Obx(() {
                return Expanded(
                  child: TableWidget(
                    header: [
                      "رقم الفاتورة",
                      "رقم امر الشغل",
                      "التاريخ",
                      "كود",
                      "العميل",
                      "الهاتف",
                      "الحالة",
                      "المرحلة",
                      "الاستلام",
                      "المتبقي",
                      "شركات",
                      "عدد الثوب",
                      "مدخل الفاتورة",
                      "ملاحظات",
                      "check",
                    ]
                        .map((e) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(e, textAlign: TextAlign.center),
                        ))
                        .toList(),
                    headerHeight: 40,
                    rows: controller.invoices.value
                        .map((e) =>
                        <String>[
                          "${e.serialTax}",
                          "${e.serial}",
                          e.date == null ? "" : DateFormat("yyyy-MM-dd").format(e.date!),
                          "${e.customerCode}",
                          (e.customerName ?? ""),
                          (e.customerMobile ?? ""),
                          (e.invoiceStatus ?? ""),
                          (e.invoiceLastStatus ?? ""),
                          e.dueDate == null ? "" : DateFormat("yyyy-MM-dd").format(e.dueDate!),
                          (e.remain?.toString() ?? ""),
                          (e.customerNotice ?? ""),
                          (e.numberOfToob?.toString() ?? ""),
                          (e.createdByName ?? ""),
                          (e.remarks ?? ""),
                          "",
                        ].map((d) {
                          return TextFormField(
                            initialValue: d,
                            readOnly: true,
                            decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          );
                        }).toList())
                        .toList(),
                    minimumCellWidth: 100,
                    rowHeight: 50,
                  ),
                );
              }),
            ],
          ),
        );
      },
      ),
    );
  }
}
