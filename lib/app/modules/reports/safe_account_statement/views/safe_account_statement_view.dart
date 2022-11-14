import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:multiselect/multiselect.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/scrollable_row.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/views/widgets/CardShadow.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/views/widgets/search_widget.dart';

import '../controllers/safe_account_statement_controller.dart';

class SafeAccountStatementView extends GetView<SafeAccountStatmentController>{
  const SafeAccountStatementView({super.key});


  @override
  Widget build(BuildContext context) {
    return Obx((){
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child:
        Scaffold(
          body: Column(
        children: [
        ScrollableRow(
        minimumWidth: 800,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          textDirection: TextDirection.rtl,
          children: (isScrollable) {
            return [
              // const Text(
              //   "اختر معرض: ",
              //   textDirection: TextDirection.rtl,
              // ),
              // Obx( () {
              //       return SizedBox(
              //         width: 300,
              //         height: 35,
              //         child: DropDownMultiSelect(
              //           options: controller.galleries.map((e) => e.name??"").toList(),
              //           selectedValues: controller.selectedGalleries.map((e) => e.name??"").toList(),
              //           onChanged: controller.selectNewGalleries,
              //           isDense: true,
              //           childBuilder: (List<String> values) {
              //             return Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Text(
              //                 values.isEmpty ? "يرجى تحديد معرض على الاقل" : values.join(', '),
              //                 maxLines: 1,
              //               ),
              //             );
              //           },
              //         ),
              //       );
              //     }),
              // const SizedBox(width: 15),
              const Text(
                "اختر خزائن: ",
                textDirection: TextDirection.rtl,
              ),
              Obx( () {
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
                            child: Text(
                              values.isEmpty ? "يرجى تحديد معرض على الاقل" : values.join(', '),
                              maxLines: 1,
                            ),
                          );
                        },
                      ),
                    );
                  }),
              const SizedBox(width: 15),
              const Text(
                "من تاريخ: ",
                textDirection: TextDirection.rtl,
              ),
              Obx( () {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          onTap: () {
                            controller.pickFromDate();
                          },
                          child: Text(
                            DateFormat("yyyy-MM-dd").format(controller.dateFrom.value),
                            style: const TextStyle(decoration: TextDecoration.underline),
                          )),
                    );
                  }),
              const SizedBox(width: 15),
              const Text(
                "الى تاريخ: ",
                textDirection: TextDirection.rtl,
              ),
              Obx( () {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          onTap: () {
                            controller.pickToDate();
                          },
                          child: Text(
                            DateFormat("yyyy-MM-dd").format(controller.dateTo.value),
                            style: const TextStyle(decoration: TextDecoration.underline),
                          )),
                    );
                  }),
              if (!isScrollable) const Spacer(),
              if (isScrollable) const SizedBox(width: 15),
              ElevatedButton(
                onPressed: () => controller.getSales(),
                child: const Text("بحث"),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("رجوع"),
              ),
              const SizedBox(width: 15),
              // ElevatedButton(
              //   onPressed: () => PrintingHelper().treasuryStatement(context, provider.treasuries, provider.dateFrom, provider.dateTo),
              //   child: const Text("طباعة"),
              // ),
              const SizedBox(width: 15),
              // ElevatedButton(
              //   onPressed: () {
              //     ExcelHelper.treasuryStatementExcel(provider.statements, context);
              //   },
              //   child: const Text("تصدير الى اكسل"),
              // ),
            ];
          },
        ),
        const Divider(),
      //   Expanded(
      //     child:Obx(( () {
      //           const boldStyle = TextStyle(fontWeight: FontWeight.bold,fontFamily: "CairoBold");
      //           const normalStyle = TextStyle(fontFamily: "Cairo");
      //           final grey = Colors.grey.shade400;
      //           return CustomScrollView(
      //             slivers: [
      //               for(final bank in treasuries)
      //                 ...[
      //                   SliverToBoxAdapter(
      //                     child: Container(
      //                       margin: const EdgeInsets.symmetric(horizontal: 15),
      //                       child: Column(
      //                         children: [
      //                           divider,
      //                           IntrinsicHeight(
      //                             child: Row(
      //                               children: [
      //                                 verticalDivider,
      //                                 const SizedBox(width: 6),
      //                                 Expanded(
      //                                   flex: 9,
      //                                   child: Padding(
      //                                     padding: const EdgeInsets.symmetric(horizontal: 15),
      //                                     child: Text(bank.bankName ?? "",textAlign: TextAlign.right,style: normalStyle,),
      //                                   ),
      //                                 ),
      //                                 verticalDivider,
      //                                 Expanded(
      //                                   flex: 2,
      //                                   child: Container(
      //                                       decoration: BoxDecoration(
      //                                         color: Colors.grey.shade400,
      //                                       ),
      //                                       // margin: const EdgeInsets.only(left: 15),
      //                                       alignment: Alignment.center,
      //                                       child: const Text("اسم البنك", style: boldStyle,)),
      //                                 ),
      //                                 verticalDivider,
      //                               ],
      //                             ),
      //                           ),
      //                           divider,
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   SliverToBoxAdapter(
      //                     child: Padding(
      //                       padding: const EdgeInsets.symmetric(horizontal: 15),
      //                       child: IntrinsicHeight(
      //                         child: Row(
      //                           children: [
      //                             verticalDivider,
      //                             Expanded(
      //                               child: ColoredBox(
      //                                 color: grey,
      //                                 child: const Center(
      //                                   child: Text(
      //                                     "الرصيد",
      //                                     style: boldStyle,
      //                                     textDirection: TextDirection.rtl,
      //                                     textAlign: TextAlign.center,
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                             verticalDivider,
      //                             Expanded(
      //                               child: ColoredBox(
      //                                 color: grey,
      //                                 child: const Center(
      //                                   child: Text(
      //                                     "مدين",
      //                                     style: boldStyle,
      //                                     textDirection: TextDirection.rtl,
      //                                     textAlign: TextAlign.center,
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                             verticalDivider,
      //                             Expanded(
      //                               child: ColoredBox(
      //                                 color: grey,
      //                                 child: const Center(
      //                                   child: Text(
      //                                     "البيان",
      //                                     style: boldStyle,
      //                                     textDirection: TextDirection.rtl,
      //                                     textAlign: TextAlign.center,
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                             verticalDivider,
      //                             Expanded(
      //                               child: ColoredBox(
      //                                 color: grey,
      //                                 child: const Center(
      //                                   child: Text(
      //                                     "مناولة",
      //                                     style: boldStyle,
      //                                     textDirection: TextDirection.rtl,
      //                                     textAlign: TextAlign.center,
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                             verticalDivider,
      //                             Expanded(
      //                               flex: 2,
      //                               child: ColoredBox(
      //                                 color: grey,
      //                                 child: const Center(
      //                                   child: Text(
      //                                     "اسم العميل",
      //                                     style: boldStyle,
      //                                     textDirection: TextDirection.rtl,
      //                                     textAlign: TextAlign.center,
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                             verticalDivider,
      //                             Expanded(
      //                                 child: ColoredBox(
      //                                   color: grey,
      //                                   child: const Center(
      //                                     child: Text(
      //                                       "كود العميل",
      //                                       style: boldStyle,
      //                                       textDirection: TextDirection.rtl,
      //                                       textAlign: TextAlign.center,
      //                                     ),
      //                                   ),
      //                                 )),
      //                             verticalDivider,
      //                             Expanded(
      //                                 child: ColoredBox(
      //                                   color: grey,
      //                                   child: const Center(
      //                                     child: Text(
      //                                       "رقم الفاتورة",
      //                                       style: boldStyle,
      //                                       textDirection: TextDirection.rtl,
      //                                       textAlign: TextAlign.center,
      //                                     ),
      //                                   ),
      //                                 )),
      //                             verticalDivider,
      //                             Expanded(
      //                                 child: ColoredBox(
      //                                   color: grey,
      //                                   child: const Center(
      //                                     child: Text(
      //                                       "نوع الحركة",
      //                                       style: boldStyle,
      //                                       textDirection: TextDirection.rtl,
      //                                       textAlign: TextAlign.center,
      //                                     ),
      //                                   ),
      //                                 )),
      //                             verticalDivider,
      //                             Expanded(
      //                                 child: ColoredBox(
      //                                   color: grey,
      //                                   child: const Center(
      //                                     child: Text(
      //                                       "رقم",
      //                                       style: boldStyle,
      //                                       textDirection: TextDirection.rtl,
      //                                       textAlign: TextAlign.center,
      //                                     ),
      //                                   ),
      //                                 )),
      //                             verticalDivider,
      //                             Expanded(
      //                                 child: ColoredBox(
      //                                   color: grey,
      //                                   child: const Center(
      //                                     child: Text(
      //                                       "التاريخ",
      //                                       style: boldStyle,
      //                                       textDirection: TextDirection.rtl,
      //                                       textAlign: TextAlign.center,
      //                                     ),
      //                                   ),
      //                                 )),
      //                             verticalDivider,
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   SliverList(
      //                     delegate: SliverChildBuilderDelegate(
      //                           (BuildContext context, int index) {
      //                         final statement = bank.statements[index];
      //                         return Padding(
      //                           padding: const EdgeInsets.symmetric(horizontal: 15),
      //                           child: Column(
      //                             children: [
      //                               divider,
      //                               IntrinsicHeight(
      //                                 child: Row(
      //                                   crossAxisAlignment: CrossAxisAlignment.start,
      //                                   children: [
      //                                     verticalDivider,
      //                                     Expanded(
      //                                         child: Center(
      //                                           child: Text(
      //                                             statement.balance?.toStringAsFixed(2) ?? " ",
      //                                             style: normalStyle,
      //                                             textAlign: TextAlign.center,
      //                                             textDirection: TextDirection.rtl,
      //                                           ),
      //                                         )),
      //                                     verticalDivider,
      //                                     Expanded(
      //                                         child: Center(
      //                                           child: Text(
      //                                             statement.debitAmount?.toStringAsFixed(2) ?? " ",
      //                                             style: normalStyle,
      //                                             textAlign: TextAlign.center,
      //                                             textDirection: TextDirection.rtl,
      //                                           ),
      //                                         )),
      //                                     verticalDivider,
      //                                     Expanded(
      //                                         child: Center(
      //                                           child: Text(
      //                                             statement.remark ?? " ",
      //                                             style: normalStyle,
      //                                             textAlign: TextAlign.center,
      //                                             textDirection: TextDirection.rtl,
      //                                           ),
      //                                         )),
      //                                     verticalDivider,
      //                                     Expanded(
      //                                         child: Center(
      //                                           child: Text(
      //                                             statement.remark2 ?? " ",
      //                                             style: normalStyle,
      //                                             textAlign: TextAlign.center,
      //                                             textDirection: TextDirection.rtl,
      //                                           ),
      //                                         )),
      //                                     verticalDivider,
      //                                     Expanded(
      //                                       flex: 2,
      //                                       child: Center(
      //                                         child: Text(
      //                                           statement.customerName ?? " ",
      //                                           style: normalStyle,
      //                                           textAlign: TextAlign.center,
      //                                           textDirection: TextDirection.rtl,
      //                                         ),
      //                                       ),
      //                                     ),
      //                                     verticalDivider,
      //                                     Expanded(
      //                                         child: Center(
      //                                           child: Text(
      //                                             statement.customerCode ?? " ",
      //                                             style: normalStyle,
      //                                             textAlign: TextAlign.center,
      //                                             textDirection: TextDirection.rtl,
      //                                           ),
      //                                         )),
      //                                     verticalDivider,
      //                                     Expanded(
      //                                         child: Center(
      //                                           child: Text(
      //                                             statement.invoiceNumber?.toString() ?? "",
      //                                             style: normalStyle,
      //                                             textAlign: TextAlign.center,
      //                                             textDirection: TextDirection.rtl,
      //                                           ),
      //                                         )),
      //                                     verticalDivider,
      //                                     Expanded(
      //                                         child: Center(
      //                                           child: Text(
      //                                             statement.transactionType ?? " ",
      //                                             style: normalStyle,
      //                                             textAlign: TextAlign.center,
      //                                             textDirection: TextDirection.rtl,
      //                                           ),
      //                                         )),
      //                                     verticalDivider,
      //                                     Expanded(
      //                                         child: Center(
      //                                           child: Text(
      //                                             statement.serial?.toString() ?? " ",
      //                                             style: normalStyle,
      //                                             textAlign: TextAlign.center,
      //                                             textDirection: TextDirection.rtl,
      //                                           ),
      //                                         )),
      //                                     verticalDivider,
      //                                     Expanded(
      //                                         child: Center(
      //                                           child: Text(
      //                                             statement.date == null ? "" : DateFormat("MM-dd-yyyy").format(statement.date!),
      //                                             style: normalStyle,
      //                                             textAlign: TextAlign.center,
      //                                             textDirection: TextDirection.rtl,
      //                                           ),
      //                                         )),
      //                                     verticalDivider,
      //                                   ],
      //                                 ),
      //                               ),
      //                               // const Divider(height: 2,thickness: 2,color: Colors.black)
      //                             ],
      //                           ),
      //                         );
      //                       },
      //                       childCount: bank.statements.length,
      //                     ),
      //                   ),
      //                   SliverToBoxAdapter(
      //                     child: Container(
      //                       margin: const EdgeInsets.symmetric(horizontal: 15),
      //                       child: Column(
      //                         children: [
      //                           divider,
      //                           IntrinsicHeight(
      //                             child: Row(
      //                               children: [
      //                                 verticalDivider,
      //                                 const Spacer(),
      //                                 Expanded(
      //                                   child: Text(
      //                                     bank.statements.first.totalDebit?.toStringAsFixed(2) ?? "",
      //                                     style: normalStyle,
      //                                     textAlign: TextAlign.center,
      //                                   ),
      //                                 ),
      //                                 verticalDivider,
      //                                 Container(
      //                                   width: 4,
      //                                   decoration: BoxDecoration(
      //                                       color: grey,
      //                                       border: Border(right: BorderSide(color: grey,width: 4))
      //                                   ),
      //                                 ),
      //                                 Expanded(
      //                                   flex: 9,
      //                                   child: Container(
      //                                     color: grey,
      //                                     padding: const EdgeInsets.only(right: 15),
      //                                     child: const Text("الاجمالي", style: boldStyle,textAlign: TextAlign.right,),
      //                                   ),
      //                                 ),
      //                                 verticalDivider,
      //                               ],
      //                             ),
      //                           ),
      //                           divider,
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                   const SliverToBoxAdapter(child: SizedBox(height: 30)),
      //                 ],
      //             ],
      //           );
      //         }),
      //   ),
      //   // Expanded(
      //   //   child: Selector<TreasuryStatementProvider, List<TreasuryModel>>(
      //   //       selector: (_, provider) => provider.treasuries,
      //   //       builder: (context, treasuries, _) {
      //   //         return Scrollbar(
      //   //           controller: controller,
      //   //           thumbVisibility: true,
      //   //           child: ListView.separated(
      //   //               itemCount: provider.treasuries.length,
      //   //               controller: controller,
      //   //               separatorBuilder: (_,__) => const SizedBox(height: 10),
      //   //               itemBuilder: (context, index) {
      //   //                 final purchases = treasuries[index].statements;
      //   //                 return SizedBox(
      //   //                   height: purchases.length * 50 + 40,
      //   //                   child: Directionality(
      //   //                     textDirection: TextDirection.rtl,
      //   //                     child: TableWidget(
      //   //                       disableScroll: true,
      //   //                       header: [
      //   //                         "التاريخ",
      //   //                         "رقم",
      //   //                         "نوع الحركة",
      //   //                         "رقم الفاتورة",
      //   //                         "كود العميل",
      //   //                         "اسم العميل",
      //   //                         "مناولة",
      //   //                         "البيان",
      //   //                         "مدين",
      //   //                         "رصيد",
      //   //                       ]
      //   //                           .map((e) => Padding(
      //   //                         padding: const EdgeInsets.symmetric(horizontal: 7),
      //   //                         child: Text(e, textAlign: TextAlign.center),
      //   //                       ))
      //   //                           .toList(),
      //   //                       headerHeight: 40,
      //   //                       rows: purchases
      //   //                           .map((e) => <String>[
      //   //                         e.date == null?"":DateFormat("yyyy-MM-dd").format(e.date!),
      //   //                         e.serial ?? "",
      //   //                         e.transactionType ??"",
      //   //                         "${e.invoiceNumber}",
      //   //                         e.customerCode ??"",
      //   //                         e.customerName ?? "",
      //   //                         (e.remark2 ?? ""),
      //   //                         e.remark ?? "",
      //   //                         "${e.debitAmount}",
      //   //                         "${e.balance}",
      //   //                       ].map((d) {
      //   //                         return Padding(
      //   //                           padding: const EdgeInsets.symmetric(horizontal: 7),
      //   //                           child: Text(
      //   //                             d,
      //   //                             maxLines: 2,
      //   //                             textAlign: TextAlign.center,
      //   //                           ),
      //   //                         );
      //   //                       }).toList())
      //   //                           .toList(),
      //   //                       minimumCellWidth: 120,
      //   //                       rowHeight: 50,
      //   //                     ),
      //   //                   ),
      //   //                 );
      //   //               }
      //   //           ),
      //   //         );
      //   //       }),
      //   // ),
      //   ],
      // ),



         ] ),

        ));}
      );
  }



}
