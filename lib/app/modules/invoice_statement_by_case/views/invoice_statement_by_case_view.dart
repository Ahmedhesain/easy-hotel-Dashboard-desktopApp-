import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:multiselect/multiselect.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/date_field_widget.dart';
import 'package:toby_bills/app/components/scrollable_row.dart';
import 'package:toby_bills/app/components/table.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import '../controllers/invoice_statement_by_case_controller.dart';

class InvoiceStatementByCaseView extends GetView<InvoiceStatementByCaseController> {
  const InvoiceStatementByCaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Column(
            children: [
              ScrollableRow(
                minimumWidth: 800,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                textDirection: TextDirection.rtl,
                children: (isScrollable) {
                  return [
                    const Text(
                      "اختر معرض: ",
                      textDirection: TextDirection.rtl,
                    ),
                    Obx(() {
                          return SizedBox(
                            width: 300,
                            height: 35,
                            child: DropDownMultiSelect(
                              options: controller.galleries.map((e) => e.name??"").toList(),
                              selectedValues: controller.selectedGalleries.map((e) => e.name??"").toList(),
                              onChanged: controller.selectNewGalleries,
                              isDense: true,
                              childBuilder: (List<String> values) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      values.isEmpty ? "يرجى تحديد معرض على الاقل" : values.join(', '),
                                      maxLines: 1,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                    const SizedBox(width: 15),
                    const Text(
                      "اختر حالة: ",
                      textDirection: TextDirection.rtl,
                    ),
                    Obx(() {
                          return SizedBox(
                            width: 200,
                            height: 35,
                            child: DropdownSearch<String>(
                              selectedItem: controller.statusList[controller.selectedStatus.value],
                              items: controller.statusList,
                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                  border: OutlineInputBorder()
                                ),
                              ),
                              onChanged: (value) => controller.selectedStatus(controller.statusList.indexOf(value!)),
                            ),
                          );
                        }),
                    const SizedBox(width: 15),
                    const Text(
                      "من تاريخ: ",
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      width: 110,
                      child: DateFieldWidget(
                        onComplete: (date){
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
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      width: 110,
                      child: DateFieldWidget(
                        onComplete: (date){
                          controller.dateTo(date);
                        },
                        date: controller.dateTo.value,
                      ),
                    ),
                    // Obx(() {
                    //       return MouseRegion(
                    //         cursor: SystemMouseCursors.click,
                    //         child: GestureDetector(
                    //             onTap: () => controller.pickToDate(),
                    //             child: Text(
                    //               DateFormat("yyyy-MM-dd").format(controller.dateTo.value),
                    //               style: const TextStyle(decoration: TextDecoration.underline),
                    //             )),
                    //       );
                    //     }),
                    if (!isScrollable) const Spacer(),
                    if (isScrollable) const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => controller.getInvoices(context),
                      child: const Text("بحث"),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => ExcelHelper.galleryInvoicesExcel(controller.invoices, context),
                      child: const Text("التصدير الى اكسل"),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => PrintingHelper().invoicesByStatus(context, controller.invoices),
                      child: const Text("طباعة"),
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
              Expanded(
                child: Obx(() {
                  final invoices = controller.invoices;
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: TableWidget(
                          header: [
                            "#",
                            "الفاتورة",
                            "الملاحظات",
                            "الفرع",
                            "تاريخ الفاتورة",
                            "كود العميل",
                            "اسم العميل",
                            "رقم العميل",
                            "تاريخ الاستحقاق",
                            "عدد الثوب",
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 7),
                                    child: Text(e, textAlign: TextAlign.center),
                                  ))
                              .toList(),
                          headerHeight: 40,
                          rows: invoices
                              .map((e) => <String>[
                                    (invoices.indexOf(e) + 1).toString(),
                                    "${e.serial}",
                                    (e.remarks ?? ""),
                                    (e.gallaryName ?? ""),
                                    e.date == null ? "" : DateFormat("yyyy-MM-dd").format(e.date!),
                                    (e.customerCode?.toString() ?? ""),
                                    (e.customerName ?? ""),
                                    (e.customerMobile ?? ""),
                                    e.dueDate == null ? "" : DateFormat("yyyy-MM-dd").format(e.dueDate!),
                                    "${e.numberOfToob}",
                                  ].map((d) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 7),
                                      child: Text(
                                        d,
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList())
                              .toList(),
                          minimumCellWidth: 120,
                          rowHeight: 50,
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      }),
    );
  }
}
