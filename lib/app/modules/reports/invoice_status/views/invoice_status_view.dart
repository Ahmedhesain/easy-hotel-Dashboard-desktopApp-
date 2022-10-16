import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/invoice_status_controller.dart';

class InvoiceStatusView extends GetView<InvoiceStatusController> {
  const InvoiceStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 0,
        title: Row(
          children: [
            UnconstrainedBox(
              child: ElevatedButton(
                child: Text("رجوع"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(width: 10),
            UnconstrainedBox(
              child: ElevatedButton(
                child: Text("طباعة"),
                onPressed: () {
                  // PrintingHelper().movementSalesReports(context, provider.reports);
                },
              ),
            ),
            const SizedBox(width: 10),
            UnconstrainedBox(
              child: ElevatedButton(
                child: Text("تصدير الى اكسل"),
                onPressed: () {
                  // ExcelHelper.movementSalesReportsExcel(provider.reports, context);
                },
              ),
            ),
          ],
        )
        ,
      ),
      // body:
      // TableWidget(
      //   header: [
      //     "#",
      //     "الفاتورة",
      //     "الفرع",
      //     "اسم العميل",
      //     "عدد الثياب\nبالفاتورة",
      //     "تاريخ التسليم\nالمشغل",
      //     "عدد الثياب\nبالمشغل",
      //     "تاريخ التسليم\nللطيار",
      //     "عدد الثياب\nللطيار",
      //     "تاريخ الاستلام\nبالمعرض",
      //     "عدد الثياب\nبالمعرض",
      //     "تاريخ التسليم\nللعميل",
      //   ]
      //       .map((e) => Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 7),
      //     child: Text(e,textAlign: TextAlign.center),
      //   ))
      //       .toList(),
      //   headerHeight: 40,
      //   rows: statements
      //       .map((e) => [
      //     "${e.id}",
      //     "${e.invoiceSerial}",
      //     (e.inventoryName??""),
      //     (e.clientName ?? ""),
      //     "${e.numberTobInvoice}",
      //     e.factoryDate == null?"":(DateFormat("yyyy-MM-dd\nHH:mm:ss").format(e.factoryDate!)),
      //     "${e.numberToFactory}",
      //     e.deliveryDate == null?"":(DateFormat("yyyy-MM-dd\nHH:mm:ss").format(e.deliveryDate!)),
      //     "${e.numberTobExitFactory}",
      //     (e.galaryDate==null?"":DateFormat("yyyy-MM-dd\nHH:mm:ss").format(e.galaryDate!)),
      //     "${e.numberTobgallary}",
      //     (e.clientDate==null?"":DateFormat("yyyy-MM-dd\nHH:mm:ss").format(e.clientDate!)),
      //   ].map((d) {
      //     return Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 7),
      //       child: Text(
      //           d,
      //           maxLines: 2,
      //           textAlign: TextAlign.center
      //       ),
      //     );
      //   }).toList())
      //       .toList(),
      //   minimumCellWidth: 100,
      //   rowHeight: 50,
      // ),
    );
  }
}
