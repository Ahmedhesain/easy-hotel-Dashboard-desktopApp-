import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/intl.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/colors.dart';
import 'package:toby_bills/app/components/date_field_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_styles.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_statement_of_bonds_by_branch_report_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoices_without_sewing_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/item_balances_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/sales_of_items_by_company_response.dart';
import 'package:toby_bills/app/modules/reports/find_statement_of_bonds_by_branch_report/controllers/find_statement_of_bonds_by_branch_report_controller.dart';
import 'package:toby_bills/app/modules/reports/invoices_without_swing_statement/controllers/invoices_without_swing_controller.dart';
import 'package:toby_bills/app/modules/reports/item_balances_statement/controllers/item_balances_statement_controller.dart';
import 'package:toby_bills/app/modules/reports/profit_sold/controllers/profit_sold_controller.dart';
import 'package:toby_bills/app/modules/reports/sales_items_by_company/controllers/sales_items_by_company_controller.dart';


class FindStatementOfBondsByBranchReportView extends GetView<FindStatementOfBondsByBranchReportController> {
  const FindStatementOfBondsByBranchReportView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child:Scaffold(
            body:  Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Center(
                  child: Container(width: size.width*.97,
                      height: size.height*.96,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 20, 15, 0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    color: appGreyDark,
                                    border: Border.all(color: Colors.grey)),
                                height: size.height*.15,
                                width: size.width*.95,
                                child: Column(
                                  children: [

                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                        child: Row(
                                          children: [

                                            SizedBox(width: size.width*.2,),

                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                              child: Row(
                                                children: [

                                                   Text('من تاريخ',style: smallTextStyleNormal(size)),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    width:  size.width * .2,
                                                    child: DateFieldWidget(
                                                      onComplete: controller.dateFrom,
                                                      date: controller.dateFrom.value,
                                                      fillColor: Colors.white,
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                  //   child:
                                                  //   Container(
                                                  //     width: size.width * .2,
                                                  //     height: size.height * .04,
                                                  //     decoration: BoxDecoration(
                                                  //       color: Colors.white70,
                                                  //       borderRadius: BorderRadius.circular(5),
                                                  //
                                                  //     ),child:
                                                  //
                                                  //   Center(
                                                  //     child: MouseRegion(
                                                  //       cursor: SystemMouseCursors.click,
                                                  //       child: GestureDetector(
                                                  //           onTap: () {
                                                  //             controller.pickFromDate();
                                                  //           },
                                                  //           child: Obx(() {
                                                  //             return Text(
                                                  //               controller.dateFrom.value == null ? "yyyy-mm-dd":DateFormat("yyyy-MM-dd").format(controller.dateFrom.value!),
                                                  //               style: const TextStyle(decoration: TextDecoration.underline),
                                                  //             );
                                                  //           })),
                                                  //     ),
                                                  //   ),
                                                  //
                                                  //
                                                  //
                                                  //
                                                  //   ),
                                                  // ),

                                                  SizedBox(width: size.width*.05,),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                    child: Text('الي تاريخ',style: smallTextStyleNormal(size)),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  SizedBox(
                                                    width:  size.width * .2,
                                                    child: DateFieldWidget(
                                                      onComplete: controller.dateTo,
                                                      date: controller.dateTo.value,
                                                      fillColor: Colors.white,
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                                  //   child: Container(
                                                  //     width: size.width * .2,
                                                  //     height: size.height * .04,
                                                  //     decoration: BoxDecoration(
                                                  //       color: Colors.white70,
                                                  //       borderRadius: BorderRadius.circular(5),
                                                  //
                                                  //     ),child:
                                                  //
                                                  //   Center(
                                                  //     child: MouseRegion(
                                                  //       cursor: SystemMouseCursors.click,
                                                  //       child: GestureDetector(
                                                  //           onTap: () {
                                                  //             controller.pickToDate();
                                                  //           },
                                                  //           child: Obx(() {
                                                  //             return Text(
                                                  //               controller.dateTo.value == null ? "yyyy-mm-dd":DateFormat("yyyy-MM-dd").format(controller.dateTo.value!),
                                                  //               style: const TextStyle(decoration: TextDecoration.underline),
                                                  //             );
                                                  //           })),
                                                  //     ),
                                                  //   ),
                                                  //
                                                  //
                                                  //
                                                  //
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: size.width*.05,)
                                          ],
                                        ),
                                      ),
                                    ),
                                       Padding(
                                      padding: EdgeInsets.fromLTRB(0, size.height * .01, 0, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                              onTap: (){
                                                // controller.getStatements();
                                                // context.read<TobyEditBillsProvider>().getEditBillsScreenGroups(182, numController.text, startdate, enddate);
                                                // glpaydtolist = context.read<TobyEditBillsProvider>().glBankList ;
                                                // setState(() {
                                                //
                                                // });
                                              },

                                              child:Row(children: [

                                                const SizedBox(width: 10),
                                                GestureDetector(onTap: (){
                                                  controller.FindStatementOfBondsByBranchReport();
                                                },
                                                  child: Container(alignment: Alignment.centerRight,

                                                    height: size.height * .05,
                                                    width: size.width * .1,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(6.00)), color:coloryellow,
                                                    ),
                                                    child: Row(mainAxisAlignment: MainAxisAlignment
                                                        .spaceAround,
                                                      children: [
                                                        Text('بحث',
                                                          style: smallTextStyleNormal(size,color: Colors.black),),
                                                        const Icon(Icons.search,color: Colors.black,)
                                                      ],
                                                    ),

                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  height: size.height * .048,
                                                  width: size.width * .1,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(6.00)),
                                                    color:coloryellow,
                                                  ),
                                                  child: ElevatedButton(
                                                    child: const Text("رجوع"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                UnconstrainedBox(
                                                  child: Obx(() {
                                                    return ElevatedButton(
                                                      onPressed: controller.reports.isEmpty ? null : () => PrintingHelper().printStatementOfBondsByBranch(context, controller.reports),
                                                      child: const Text("طباعة"),
                                                    );
                                                  }),
                                                ),
                                                const SizedBox(width: 10),
                                                UnconstrainedBox(
                                                  child: Obx(() {
                                                    return ElevatedButton(
                                                      onPressed: controller.reports.isEmpty ? null : () => ExcelHelper.StatementOfBondsByBranchExcel(controller.reports, context),
                                                      child: const Text("تصدير الى اكسل"),
                                                    );
                                                  }),
                                                ),
                                              ],)

                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                )


                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              color: coloryellow,
                              width:size.width*.97,
                              height: size.height*.06,
                              child:
                              Container(width:size.width*.03,
                                  height: size.height*.03,child:const SizedBox()),
                            ),
                          ),
                          Container(
                              width:size.width,
                              height:size.height*.72,
                              child:SingleChildScrollView(physics:  const AlwaysScrollableScrollPhysics(),
                                child: Column(children: [
                                  Container(
                                    margin: const EdgeInsets.all(0),
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(size.width * .194),
                                      border: TableBorder.all(
                                          borderRadius: const BorderRadius.all(Radius.circular(0)),
                                          color: Colors.grey,
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [

                                        TableRow(children: [
                                          Column(children: [const Text("كود الفرع",
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text(' الفرع',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text('النوع ',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text(' نوع السداد',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text(' المبلغ ',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),





                                        ],
                                          decoration: const BoxDecoration(color: appGreyDark,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(0),
                                                  topLeft: Radius.circular(0))),
                                        ),
                                        if(controller.reports != null)


                                          for(FindStatementOfBondsByBranchReportResponse kha in controller.reports??[] )
                                            TableRow(children: [
                                              Column(children: [
                                                Text(
                                                    kha.galleryCode==null?"": kha.galleryCode!,
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                        kha.galleryName ??"",
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.paymentType??"",
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),

                                              Column(children: [
                                                Text(
                                                    kha.type??"",
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                              kha.totalAmount==null?"": kha.totalAmount!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),




                                            ],
                                              decoration: const BoxDecoration( color: appGreyLight,
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(0),
                                                      topLeft: Radius.circular(0))),
                                            )








                                      ],
                                    ),
                                  ),

                                ],),
                              )

                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          //   child: Container(
                          //     color: coloryellow,
                          //     width:size.width*.97,
                          //     height: size.height*.06,
                          //     child: Padding(
                          //       padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                          //       child: Container(
                          //           child:Row(children: [
                          //             index==0?
                          //             Padding(
                          //               padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
                          //               child: Row(children: [
                          //                 Padding(
                          //                   padding: EdgeInsets.fromLTRB(0, size.height * .001, size.width*.75, 0),
                          //                   child: Row(
                          //                     mainAxisAlignment: MainAxisAlignment.center,
                          //                     children: [
                          //                       GestureDetector(onTap: () {
                          //                         print('dfjdfjh');
                          //                         context.read<TobyPayProvider>().save(clientname!.id!,remarkselected.text , context.read<TobyPayProvider>().glPayDtoList,context.read<AuthProvider>().branchId,context.read<AuthProvider>().companyId,context.read<AuthProvider>().id,context);
                          //                         setState(() {
                          //                           index++;
                          //                         });
                          //
                          //                         print('2323');
                          //                       },
                          //                         child: Container(alignment: Alignment.centerRight,
                          //
                          //                           height: size.height * .05,
                          //                           width: size.width * .05,
                          //                           decoration: BoxDecoration(
                          //                             borderRadius: BorderRadius.all(
                          //                                 Radius.circular(6.00)), color:Colors.green,
                          //                           ),
                          //                           child: Row(mainAxisAlignment: MainAxisAlignment
                          //                               .spaceAround,
                          //                             children: [
                          //                               Text('حفظ',
                          //                                 style: smallTextStyleNormal(size,color: Colors.black),),
                          //                               Icon(Icons.save,color: Colors.black,)
                          //                             ],
                          //                           ),
                          //
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],),
                          //             ):
                          //             Padding(
                          //               padding: EdgeInsets.fromLTRB(0, 0, size.width*.8, 0),
                          //               child: Row(
                          //                 mainAxisAlignment: MainAxisAlignment.center,
                          //                 children: [
                          //
                          //                   GestureDetector(onTap: () {
                          //                     context.read<TobyPayProvider>().preprint(clientname!.id!,remarkselected.text , context.read<TobyPayProvider>().glPayDtoList,182,125,201,clientselected.text, context);
                          //                     // printInvoice(context.read<tobypayProvider>().glBankTransactionApi!,context);
                          //                     // create();
                          //                     // testReceipt('192.168.0.123', port: 9100);
                          //
                          //                   },
                          //                     child: Container(alignment: Alignment.centerRight,
                          //
                          //                       height: size.height * .05,
                          //                       width: size.width * .05,
                          //                       decoration: BoxDecoration(
                          //                         borderRadius: BorderRadius.all(
                          //                             Radius.circular(6.00)),
                          //                         color: Colors.green,
                          //                       ),
                          //                       child: Row(mainAxisAlignment: MainAxisAlignment
                          //                           .spaceAround,
                          //                         children: [
                          //                           Text('طباعه ',
                          //                             style: smallTextStyleNormal(size),),
                          //                           Icon(Icons.print)
                          //                         ],
                          //                       ),
                          //
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //
                          //
                          //           ],)),
                          //     ),
                          //   ),
                          // ),
                        ],)
                  ),
                )







            ),
          )
      );
    });
  }
}
