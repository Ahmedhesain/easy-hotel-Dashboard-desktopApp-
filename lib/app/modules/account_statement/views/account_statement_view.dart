import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';

import '../../../components/table.dart';
import '../controllers/account_statement_controller.dart';

class AccountStatementView extends GetView<AccountStatementController> {
  const AccountStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 0,
            title: Row(
              children: [
                UnconstrainedBox(
                  child: ElevatedButton(
                    child: const Text("رجوع"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                UnconstrainedBox(
                  child: ElevatedButton(
                    child: const Text("طباعة"),
                    onPressed: () {
                      PrintingHelper().statements(context, controller.reports);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                UnconstrainedBox(
                  child: ElevatedButton(
                    child: const Text("تصدير الى اكسل"),
                    onPressed: () {
                      ExcelHelper.statementsExcel(controller.reports, context);
                    },
                  ),
                ),
              ],
            ),
          ),
          body: TableWidget(
            header: [
              "رقم الفاتورة",
              "التاريخ",
              "عميل",
              "نوع الحركة",
              "رقم فاتورة المبيعات",
              "الخزينة",
              "مدين",
              "دائن",
              "الرصيد",
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text(e),
                    ))
                .toList(),
            headerHeight: 40,
            rows: controller.reports
                .map((e) => [
                      "${e.serial}",
                      (e.date == null ? "" : DateFormat("yyy-MM-dd").format(e.date!)),
                      (e.organizationName),
                      (e.screenName),
                      "${e.invoiceSerial}",
                      "${e.openningBalance}",
                      "${e.adding}",
                      "${e.exitt}",
                      "${e.remarks}"
                    ].map((d) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Text(
                          d,
                          maxLines: 2,
                        ),
                      );
                    }).toList())
                .toList(),
            minimumCellWidth: 150,
            rowHeight: 50,
          ),
        ),
      );
    });
  }
}
