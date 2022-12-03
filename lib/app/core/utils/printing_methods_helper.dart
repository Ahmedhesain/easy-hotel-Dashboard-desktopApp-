import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:toby_bills/app/components/heads_widget.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/response/cost_center_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/account_statement_response.dart';
import 'package:toby_bills/app/data/model/general_journal/dto/response/account_summary_response.dart';
import 'package:toby_bills/app/data/model/general_journal/generaljournaldetail_model.dart';
import 'package:toby_bills/app/data/model/general_journal/genraljournal.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_status_response.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/balance_galary_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/balance_galary_unpaid_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_items_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/client_no_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_sales_value_added_details_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_sales_value_added_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_statement_of_bonds_by_branch_report_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/inv_item_dto_response.dart';
import 'package:toby_bills/app/data/model/payments/payment_model.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_statement_by_case_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoices_without_sewing_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/item_balances_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/journal_document_dialy_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/production_stages_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/purchases_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/safe_account_statement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/sales_of_items_by_company_response.dart';
import 'package:toby_bills/app/modules/reports/invoices_without_swing_statement/controllers/invoices_without_swing_controller.dart';

import '../../data/model/reports/dto/response/categories_totals_response.dart';

class PrintingHelper {


  void printCatchReceipt(GlBankTransactionApi glBankTransactionApi, m.BuildContext context) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    DateTime date = DateTime.now();
    final boldStyle =
    TextStyle(font: ttfBold, fontSize: 7.5, fontBold: ttfBold);
    doc.addPage(MultiPage(
        footer: (context) => Container(
            height: 25,
            decoration: const BoxDecoration(),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateTime.now().toIso8601String().split("T")[0],
                    style: normalStyle,
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    "user!.data!.name!",
                    style: normalStyle,
                    textDirection: TextDirection.rtl,
                  ),
                ])),
        pageTheme: const PageTheme(
            pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl),
        build: (Context context) {
          return [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Column(children: [
                SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              "سند قبض نقدي",
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            ),
                          )
                        ])),
                SizedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //customer data and date
                          SizedBox(
                              width: 120,
                              child: Column(children: [

                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // "${date.year.toString()}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}.padLeft(2,'0')}",
                                        DateFormat('yyyy-MM-dd').format(date),
                                        style: normalStyle,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        "التاريخ:",
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ]),

                              ])),
                          //barcode widget

                          // seller data
                          SizedBox(
                              width: 120,
                              child: Column(children: [
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(
                                        glBankTransactionApi.customerName ?? "",
                                        style: normalStyle,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        "اسم العميل:",
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ]),
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(
                                        glBankTransactionApi.remark??"",
                                        style: normalStyle,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      Text(
                                        "الملاحظات:",
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ]),


                              ])),
                        ])),
                Table(border: TableBorder.all(width: 1), children: [

                  TableRow(children: [
                    Container(
                        color: grey,
                        width: 50,
                        child: Center(
                            child: Text(
                              'اسم الخزنه',
                              style: normalStyle,
                              textDirection: TextDirection.rtl,
                            ))),


                    Container(
                        color: grey,
                        width: 30,
                        child: Center(
                            child: Text(
                              " المدفوع",
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            ))),


                    Container(
                        color: grey,
                        width: 30,
                        child: Center(
                            child: Text(
                              "رقم السند",
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            ))),

                    Container(
                        color: grey,
                        width: 30,
                        child: Center(
                            child: Text(
                              "رقم الفاتورة",
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            ))),
                  ]),
                  //table content
                  for (GlPayDTO detail
                  in glBankTransactionApi.glPayDTOAPIList!)
                    TableRow(children: [
                      Container(
                          width: 30,
                          child: Center(
                              child: Text(
                                detail.bankName.toString(),
                                style: normalStyle,
                                textDirection: TextDirection.rtl,
                              ))),
                      Container(
                          width: 80,
                          child: Center(
                              child: Text(
                                detail.value.toString(),
                                style: normalStyle,
                                textDirection: TextDirection.rtl,
                              ))),
                      Container(
                          width: 30,
                          child: Center(
                              child: Text(
                                detail.serial.toString(),
                                style: normalStyle,
                                textDirection: TextDirection.rtl,
                              ))),

                      Container(
                          width: 30,
                          child: Center(
                              child: Text(
                                detail.invoiceSerial.toString(),
                                style: normalStyle,
                                textDirection: TextDirection.rtl,
                              ))),
                    ]),
                ]),
                //table headers





              ]),
            )
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return PdfPreview(
            actions: [
              m.IconButton(
                onPressed: () => m.Navigator.pop(context),
                icon: const m.Icon(
                  m.Icons.close,
                  color: m.Colors.red,
                ),
              )
            ],
            build: (format) => doc.save(),
          );
        });
  }
  
  void printSubAccountStatements(m.BuildContext context, {required List<AccountSummaryResponse> statements, DateTime? fromDate, DateTime? toDate,required  String fromCenter, required String toCenter}) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(2),
      4:const FlexColumnWidth(1),
      5:const FlexColumnWidth(1),
      6:const FlexColumnWidth(1),
      // 7:const FlexColumnWidth(1),
    };
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, margin: EdgeInsets.all(10)),
        maxPages: 50,
        build: (Context context) {
          return [
            SizedBox(height: 50),
            Center(
              child: Container(
                color: grey,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Text(
                  "تقارير الحسابات الفرعية",
                  style: boldStyle,
                ),
              ),
            ),
            SizedBox(height: 20.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Expanded(
                            child: Text(
                              fromDate == null?'--':DateFormat("dd/MM/yyyy").format(fromDate),
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            )
                        ),
                        SizedBox(width: 15),
                        SizedBox(
                            width: 60,
                            child: Text(
                              "من تاريخ",
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            )
                        ),
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                                toDate ==null ?'--':DateFormat("dd/MM/yyyy").format(toDate),
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                              )
                          ),
                          SizedBox(width: 15),
                          SizedBox(
                              width: 60,
                              child: Text(
                                "الى تاريخ",
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex:2,
                              child: Text(
                                fromCenter,
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                              )
                          ),
                          SizedBox(width: 15),
                          SizedBox(
                              width: 60,
                              child: Text(
                                "من مركز",
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                              )
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                  child: Text(
                                    toCenter,
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  )
                              )
                          ),
                          SizedBox(width: 15),
                          SizedBox(
                              width: 60,
                              child: Text(
                                "الى مركز",
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Table(border: TableBorder.all(width: 1), columnWidths: widths, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الرصيد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("دائن",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("مدين",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("بيان القيد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                // Container(
                //     color: grey,
                //     child: Center(
                //         child: Text("نوع اليومية",
                //             style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم السند",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم القيد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child:
                        Text("التاريخ", style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ]),
              //table content
              for (int i = 0; i < statements.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        statements[i].balance?.toStringAsFixed(2) ?? "",
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        statements[i].creditAmount?.toStringAsFixed(2) ?? "",
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        statements[i].debitAmount?.toStringAsFixed(2)??"",
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        statements[i].discribtion??"",
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  // Center(
                  //     child: Text(
                  //       statements[i].rem?.toString()??"",
                  //       style: boldStyle,
                  //       textAlign: TextAlign.center,
                  //       textDirection: TextDirection.rtl,
                  //     )),
                  Center(
                      child: Text(
                        statements[i].generalDecument?.toString()??"",
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        statements[i].serial?.toString()??"",
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        statements[i].date == null?"--":DateFormat("dd/MM/yyyy").format(statements[i].date!),
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                ]),
              TableRow(children: [
                SizedBox(),
                Container(
                    width: 55,
                    child: Center(
                        child: Text(
                          statements.fold<num>(0,(a,b) => a+(b.creditAmount??0)).toStringAsFixed(2) ?? "",
                          style: boldStyle,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    width: 55,
                    child: Center(
                        child: Text(
                          statements.fold<num>(0,(a,b) => a+(b.debitAmount??0)).toStringAsFixed(2) ?? "",
                          style: boldStyle,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    width: 60,
                    child: Center(
                        child: Text(
                          "الإجمالي",
                          style: boldStyle,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ))),
                SizedBox(),
                SizedBox(),
                SizedBox(),
              ]),
            ]),
            SizedBox(height: 5),
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return PdfPreview(
            actions: [
              m.IconButton(
                onPressed: () => m.Navigator.pop(context),
                icon: const m.Icon(
                  m.Icons.close,
                  color: m.Colors.red,
                ),
              )
            ],
            build: (format) => doc.save(),
          );
        });
  }

  void printGeneralJournal(GeneralJournalModel generalJournalModel,  m.BuildContext context) async {
    final user = UserManager().user;
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle =
    TextStyle(font: ttfBold, fontSize: 7.5, fontBold: ttfBold);
    double allDebitAmount = 0.0;
    double allCreditAmount = 0.0;

    for (GenralJournalDetailModel detail
    in generalJournalModel.detailDtoList!) {
      detail.creditAmount != null
          ? allCreditAmount += detail.creditAmount!
          : null;
      detail.debitAmount != null ? allDebitAmount += detail.debitAmount! : null;
    }
    doc.addPage(MultiPage(
        footer: (context) => Container(
            height: 25,
            width: 650,
            decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: PdfColors.black, width: 2))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.now()),
                    style: boldStyle,
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    user.name,
                    style: boldStyle,
                    textDirection: TextDirection.rtl,
                  ),
                ])),
        pageTheme: PageTheme(
          pageFormat: PdfPageFormat.a4,
        ),
        build: (Context context) {
          return [
            Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Container(
                      color: grey,
                      width: 100,
                      height: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text('بيان قيود اليومية',
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HeadWidget(
                              value: generalJournalModel.generalData
                                  ?.toIso8601String()
                                  .split("T")[0],
                              title: 'تاريخ السند',
                              textStyle: boldStyle,
                              color: grey),
                          SizedBox(width: 40),
                          HeadWidget(
                              value: generalJournalModel.generalTypeName,
                              title: "نوع السند",
                              textStyle: boldStyle,
                              color: grey),
                          SizedBox(width: 60),
                          HeadWidget(
                              value: generalJournalModel.generalDecument,
                              title: "رقم السند ",
                              textStyle: boldStyle,
                              color: grey),
                          SizedBox(width: 60),
                          HeadWidget(
                              value: generalJournalModel.serial,
                              title: 'رقم القيد',
                              textStyle: boldStyle,
                              color: grey),
                        ]),
                    SizedBox(height: 20),
                    Row(children: [
                      Container(
                          width: 500,
                          height: 80,
                          color: PdfColors.white,
                          child: Table(
                              border: TableBorder.all(
                                  color: PdfColors.black, width: 1),
                              // border: TableBorder(),
                              children: [
                                TableRow(
                                    decoration: const BoxDecoration(
                                      color: PdfColors.white,
                                    ),
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 25,
                                        child: Column(children: [
                                          Text(
                                              generalJournalModel
                                                  .generalStatement ??
                                                  "",
                                              style: boldStyle,
                                              textDirection:
                                              TextDirection.rtl)
                                        ]),
                                      ),
                                      Container(
                                          color: grey,
                                          height: 25,
                                          child: Center(
                                              child: Text('عنوان القيد',
                                                  style: boldStyle,
                                                  textDirection:
                                                  TextDirection.rtl,
                                                  textAlign:
                                                  TextAlign.center))),
                                    ]),
                              ]))
                    ]),
                    SizedBox(height: 20),
                    Container(
                      // width: double.infinity,
                        color: PdfColors.white,
                        child: Table(
                            border: TableBorder.all(
                                color: PdfColors.black, width: 1),
                            tableWidth: TableWidth.max,
                            // columnWidths: {
                            //   0 : FixedColumnWidth(300),
                            //   1 : FixedColumnWidth(300),
                            //   2 : FixedColumnWidth(300),
                            //   3 : FixedColumnWidth(300),
                            //   4 : FixedColumnWidth(300),
                            //   5 : FixedColumnWidth(300),
                            // },
                            // border: TableBorder(),
                            children: [
                              TableRow(
                                  decoration: const BoxDecoration(
                                    color: grey,
                                  ),
                                  children: [
                                    Container(
                                        width: 100,
                                        child: Text('البيان',
                                            style: boldStyle,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center)),
                                    // Container(
                                    //     width: 40,
                                    //     child: Text('وحدة ادارية',
                                    //         style: boldStyle,
                                    //         textDirection: TextDirection.rtl,
                                    //         textAlign: TextAlign.center)),
                                    Container(
                                        width: 70,
                                        child: Text('مركز التكلفة',
                                            style: boldStyle,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center)),
                                    Container(
                                        width: 70,
                                        child: Text('اسم الحساب',
                                            style: boldStyle,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center)),
                                    Container(
                                        width: 40,
                                        child: Text('رقم الحساب',
                                            style: boldStyle,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center)),
                                    Container(
                                        width: 30,
                                        child: Text('دائن',
                                            style: boldStyle,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center)),
                                    Container(
                                        width: 30,
                                        child: Text('مدين',
                                            style: boldStyle,
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.center)),
                                  ]),
                            ])),
                    for (GenralJournalDetailModel detail in generalJournalModel.detailDtoList!)
                      Container(
                          color: PdfColors.white,
                          child: Table(
                              border: TableBorder.all(
                                  color: PdfColors.black, width: 1),
                              // border: TableBorder(),
                              children: [
                                TableRow(children: [
                                  Container(
                                      width: 100,
                                      child: Text(detail.discribtion!,
                                          style: boldStyle,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center)),
                                  // Container(
                                  //     width: 40,
                                  //     child: Text("",
                                  //         style: normalStyle,
                                  //         textDirection: TextDirection.rtl,
                                  //         textAlign: TextAlign.center)),
                                  Container(
                                      width: 70,
                                      child: Text(detail.glCostCenterName!,
                                          style: boldStyle,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center)),
                                  Container(
                                      width: 70,
                                      child: Text(detail.glAccountName!,
                                          style: boldStyle,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center)),
                                  Container(
                                      width: 40,
                                      child: Text(detail.glAccountNumber!,
                                          style: boldStyle,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center)),
                                  Container(
                                      width: 30,
                                      child: Text(
                                          detail.creditAmount != null
                                              ? detail.creditAmount!.toString()
                                              : "",
                                          style: boldStyle,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center)),
                                  Container(
                                      width: 30,
                                      child: Text(
                                          detail.debitAmount != null
                                              ? detail.debitAmount!.toString()
                                              : "",
                                          style: boldStyle,
                                          textDirection: TextDirection.rtl,
                                          textAlign: TextAlign.center)),
                                ]),
                              ])),
                    Container(
                        color: PdfColors.white,
                        child: Table(
                            border: TableBorder.all(
                                color: PdfColors.black, width: 1),
                            // border: TableBorder(),
                            children: [
                              TableRow(children: [
                                Container(
                                    width: 30,
                                    child: Text('مرحل',
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center)),
                                Container(
                                    width: 30,
                                    child: Text('موزون',
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center)),
                                Container(
                                    width: 30,
                                    color: grey,
                                    child: Text('قيد',
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center)),
                                Container(
                                    child: Text(
                                        DateFormat("dd-MM-yyyy").format(generalJournalModel.createdDate ?? DateTime.now()),
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center)),
                                Container(
                                    width: 65,
                                    child: Text(
                                        generalJournalModel.createdByName ?? "",
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center)),
                                Container(
                                    width: 75,
                                    color: grey,
                                    child: Text('اسم و تاريخ منشئ القيد',
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center)),
                                Container(
                                    width: 30,
                                    child: Text(allCreditAmount.toStringAsFixed(2),
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center)),
                                Container(
                                    width: 30,
                                    child: Text(allDebitAmount.toStringAsFixed(2),
                                        style: boldStyle,
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center)),
                              ]),
                            ])),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(children: [
                          Column(children: [
                            Text('اعتماد',
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center),
                            Text('.........',
                                style: const TextStyle(color: grey)),
                          ]),
                          SizedBox(width: 150),
                          Column(children: [
                            Text('مدير الحسابات',
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center),
                            Text('.........',
                                style: const TextStyle(color: grey)),
                          ]),
                          SizedBox(width: 150),
                          Column(children: [
                            Text('المحاسب',
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center),
                            Text('.........',
                                style: const TextStyle(color: grey)),
                          ]),
                        ]))
                  ],
                ))
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return PdfPreview(
            actions: [
              m.IconButton(
                onPressed: () => m.Navigator.pop(context),
                icon: const m.Icon(
                  m.Icons.close,
                  color: m.Colors.red,
                ),
              )
            ],
            build: (format) => doc.save(),
          );
        });
  }

  void printPayments(m.BuildContext context, PaymentModel payment) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(2),
      2:const FlexColumnWidth(2),
      3:const FlexColumnWidth(1),
    };
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            SizedBox(height: 50),
            Center(
              child: Container(
                color: grey,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Text(
                  "سند صرف نقدي",
                  style: boldStyle,
                ),
              ),
            ),
            SizedBox(height: 20.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all()
                                ),
                                child: Text(
                                  payment.serial?.toString()??"",
                                  style: boldStyle,
                                  textDirection: TextDirection.rtl,
                                )
                            )
                        ),
                        SizedBox(width: 15),
                        SizedBox(
                          width: 60,
                          child: Text(
                            "رقم السند",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          )
                        ),
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all()
                                  ),
                                  child: Text(
                                    payment.date == null?"":DateFormat("yyyy/MM/dd").format(payment.date!),
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  )
                              )
                          ),
                          SizedBox(width: 15),
                          SizedBox(
                            width: 60,
                            child: Text(
                              "التاريخ",
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex:2,
                            child: Text(
                              payment.valueName??"",
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            )
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all()
                                ),
                                child: Text(
                                  payment.totalValue?.toString()??"",
                                  style: boldStyle,
                                  textDirection: TextDirection.rtl,
                                )
                            )
                          ),
                          SizedBox(width: 15),
                          SizedBox(
                            width: 60,
                            child: Text(
                              "المبلغ",
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            )
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all()
                                  ),
                                  child: Text(
                                    payment.remark??"",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  )
                              )
                          ),
                          SizedBox(width: 15),
                          SizedBox(
                            width: 60,
                            child: Text(
                              "وذلك قيمة:",
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Table(border: TableBorder.all(width: 1), columnWidths: widths, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 55,
                    child: Center(
                        child: Text("المبلغ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text("البيان",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("اسم الحساب",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child:
                        Text("م", style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ]),
              //table content
              for (int i = 0; i < payment.glBankTransactionDetailFromApiList!.length; i++)
                TableRow(children: [
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            payment.glBankTransactionDetailFromApiList![i].value?.toStringAsFixed(2) ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            payment.glBankTransactionDetailFromApiList![i].remarks ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            payment.glBankTransactionDetailFromApiList![i].glAccountDebitName ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            "${i+1}",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                ]),
              TableRow(children: [
                Container(
                    width: 55,
                    child: Center(
                        child: Text(
                          payment.totalValue?.toStringAsFixed(2) ?? "",
                          style: boldStyle,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    width: 60,
                    child: Center(
                        child: Text(
                          "الإجمالي",
                          style: boldStyle,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ))),
                SizedBox(),
                SizedBox(),
              ]),
            ]),
            SizedBox(height: 5),
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return PdfPreview(
            actions: [
              m.IconButton(
                onPressed: () => m.Navigator.pop(context),
                icon: const m.Icon(
                  m.Icons.close,
                  color: m.Colors.red,
                ),
              )
            ],
            build: (format) => doc.save(),
          );
        });
  }

  void printReceipt(m.BuildContext context, GlBankTransactionApi receipt) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(2),
      2:const FlexColumnWidth(2),
      3:const FlexColumnWidth(1),
    };
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            SizedBox(height: 50),
            Center(
              child: Container(
                color: grey,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Text(
                  "سند قبض",
                  style: boldStyle,
                ),
              ),
            ),
            SizedBox(height: 20.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all()
                                ),
                                child: Text(
                                  receipt.glPayDTOAPIList?.first.serial?.toString()??"",
                                  style: boldStyle,
                                  textDirection: TextDirection.rtl,
                                )
                            )
                        ),
                        SizedBox(width: 15),
                        SizedBox(
                            width: 60,
                            child: Text(
                              "رقم السند",
                              style: boldStyle,
                              textDirection: TextDirection.rtl,
                            )
                        ),
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all()
                                  ),
                                  child: Text(
                                    receipt.date == null?"":DateFormat("yyyy/MM/dd").format(receipt.date!),
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  )
                              )
                          ),
                          SizedBox(width: 15),
                          SizedBox(
                              width: 60,
                              child: Text(
                                "التاريخ",
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all()
                                  ),
                                  child: Text(
                                    receipt.glPayDTOAPIList?.first.value?.toString()??"",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  )
                              )
                          ),
                          SizedBox(width: 15),
                          SizedBox(
                              width: 60,
                              child: Text(
                                "المبلغ",
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                              )
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                                constraints: const BoxConstraints(minHeight: 20),
                                  decoration: BoxDecoration(
                                      border: Border.all()
                                  ),
                                  child: Text(
                                    receipt.remark??"",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  )
                              )
                          ),
                          SizedBox(width: 15),
                          SizedBox(
                              width: 60,
                              child: Text(
                                "وذلك قيمة:",
                                style: boldStyle,
                                textDirection: TextDirection.rtl,
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Table(border: TableBorder.all(width: 1), columnWidths: widths, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 55,
                    child: Center(
                        child: Text("المبلغ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text("البيان",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("اسم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child:
                        Text("م", style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ]),
              //table content
              for (int i = 0; i < receipt.glPayDTOAPIList!.length; i++)
                TableRow(children: [
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            receipt.glPayDTOAPIList![i].value?.toStringAsFixed(2) ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            receipt.glPayDTOAPIList![i].remark ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            receipt.glPayDTOAPIList![i].customerName??"",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            "${i+1}",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                ]),
              TableRow(children: [
                Container(
                    width: 55,
                    child: Center(
                        child: Text(
                          receipt.glPayDTOAPIList?.first.value?.toStringAsFixed(2) ?? "",
                          style: boldStyle,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    width: 60,
                    child: Center(
                        child: Text(
                          "الإجمالي",
                          style: boldStyle,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ))),
                SizedBox(),
                SizedBox(),
              ]),
            ]),
            SizedBox(height: 5),
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return PdfPreview(
            actions: [
              m.IconButton(
                onPressed: () => m.Navigator.pop(context),
                icon: const m.Icon(
                  m.Icons.close,
                  color: m.Colors.red,
                ),
              )
            ],
            build: (format) => doc.save(),
          );
        });
  }

  void printPurchaseInvoice(m.BuildContext context, InvoiceModel invoiceModel, {num? value, num? dariba, num? total, num? discount, num? net, num? payed, num? remain}) async {
    // LoginData? user = context.read<AuthProvider>().user ;
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
    // final dm = Barcode.dataMatrix();
    //
    // final svg = dm.toSvg('114625', width: 80, height: 25);
    // final List<int> bytes = svg.codeUnits;
    // final im.Image? image = im.decodePng(bytes);
    doc.addPage(MultiPage(
        // header: (_) => Container(
        //     height: 25,
        //     decoration: const BoxDecoration(),
        //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //       Text(
        //         DateTime.now().toIso8601String().split("T")[0],
        //         style: boldStyle,
        //         textDirection: TextDirection.rtl,
        //       ),
        //       Text(
        //         context.read<AuthProvider>().userModel!.data!.name!,
        //         style: boldStyle,
        //         textDirection: TextDirection.rtl,
        //       ),
        //     ])),
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl),
        build: (Context context) {
          return [
            SizedBox(height: 50.5),
            Center(
                child: Text(
                  "فاتورة مشتريات آجلة",
                  style: boldStyle,
                  textDirection: TextDirection.rtl,
                )),
            SizedBox(height: 20.5),
            SizedBox(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  //customer data and date
                  SizedBox(
                      width: 120,
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.customerName??"--",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            "المورد",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.supplierInvoiceNumber?.toString()??"--",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            "فاتورة المورد",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.supplierDate == null?"--":DateFormat("dd/MM/yyyy").format(invoiceModel.supplierDate!),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            "تاريخها",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                      ])),
                  // seller data
                  SizedBox(
                      width: 180,
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            "مستودع رئيسي",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "الفرع",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.serial?.toString()??"--",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "رقم الفاتورة",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.date == null?"--":DateFormat("dd/MM/yyyy").format(invoiceModel.date!),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "تاريخ التسليم",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.remarks?.toString()??"",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "ملاحظات",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                      ])),
                ])),
            SizedBox(height: 15),
            //table headers
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
              TableRow(decoration: const BoxDecoration(color: grey),children: [
                Center(
                    child: Text(
                      "القيمة",
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    )),
                Center(
                    child: Text(
                      "تكلفة وحدة",
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    )),
                Center(
                    child: Text(
                      "كمية",
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    )),
                Center(
                    child: Text(
                      "الوحدة",
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    )),
                Center(
                    child: Text(
                      "اسم الصنف",
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    )),
                Center(
                    child: Text(
                      "رقم الصنف",
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    )),
                Center(
                    child: Text(
                      "م",
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    )),
              ]),
              //table content
              for (int i = 0; i < invoiceModel.invoiceDetailApiList!.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        (invoiceModel.invoiceDetailApiList![i].net ?? 0).toStringAsFixed(2),
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        (invoiceModel.invoiceDetailApiList![i].price ?? 0).toStringAsFixed(2),
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        (invoiceModel.invoiceDetailApiList![i].quantity ?? 0).toStringAsFixed(2),
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        invoiceModel.invoiceDetailApiList![i].unitName.toString(),
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        invoiceModel.invoiceDetailApiList![i].name.toString(),
                        style: boldStyle2,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        invoiceModel.invoiceDetailApiList![i].code.toString(),
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        "${i + 1}",
                        style: boldStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                ]),
            ]),
            SizedBox(height: 5),
            SizedBox(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                      width: 120,
                      child: Table(tableWidth: TableWidth.max, border: TableBorder.all(width: 0.5), children: [
                        TableRow(children: [
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    value?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    "القيمه",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                        TableRow(children: [
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    dariba?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    "الضريبة",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                        TableRow(children: [
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    discount?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    "الخصم",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                        TableRow(children: [
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    total?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    "الاجمالي",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                      ])),
                ]))
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return m.LayoutBuilder(builder: (context, c) {
            return PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            );
          });
        });
  }

  void printInvoice(m.BuildContext context, InvoiceModel invoiceModel, {num? value, num? dariba, num? total, num? discount, num? net, num? payed, num? remain}) async {
    // LoginData? user = context.read<AuthProvider>().user ;
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
    // final dm = Barcode.dataMatrix();
    //
    // final svg = dm.toSvg('114625', width: 80, height: 25);
    // final List<int> bytes = svg.codeUnits;
    // final im.Image? image = im.decodePng(bytes);
    doc.addPage(MultiPage(
      // header: (_) => Container(
      //     height: 25,
      //     decoration: const BoxDecoration(),
      //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //       Text(
      //         DateTime.now().toIso8601String().split("T")[0],
      //         style: boldStyle,
      //         textDirection: TextDirection.rtl,
      //       ),
      //       Text(
      //         context.read<AuthProvider>().userModel!.data!.name!,
      //         style: boldStyle,
      //         textDirection: TextDirection.rtl,
      //       ),
      //     ])),
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl),
        build: (Context context) {
          return [

            SizedBox(height: 50.5),
            SizedBox(
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      invoiceModel.serial.toString(),
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      "فاتورة ضريبيه مبسطة",
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    ),
                  )
                ])),

            SizedBox(height: 20.5),
            SizedBox(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  //customer data and date
                  SizedBox(
                      width: 120,
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            DateFormat("dd/MM/yyyy hh:mm aa").format(invoiceModel.date!),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            "التاريخ",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.customerName.toString(),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            "العميل",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.customerCode.toString(),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.customerMobile.toString(),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                      ])),
                  //barcode widget
                  SizedBox(
                      width: 130,
                      height: 50,
                      child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Container(
                            width: 80,
                            height: 25,
                            child: BarcodeWidget(
                              height: 25,
                              width: 80,
                              color: PdfColor.fromHex("#000000"),
                              barcode: Barcode.fromType(BarcodeType.Codabar),
                              drawText: false,
                              data: invoiceModel.serial.toString(),
                            ))
                      ])),
                  // seller data
                  SizedBox(
                      width: 180,
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.daribaValue.toString(),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "الرقم الضريبي",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.segilValue.toString(),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "رقم السجل",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.gallaryName.toString(),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "المعرض",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(
                            invoiceModel.dueDate == null?"--":DateFormat("dd/MM/yyyy").format(invoiceModel.dueDate!),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "تاريخ التسليم",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ]),
                      ])),
                ])),
            SizedBox(height: 15),
            // m.LayoutBuilder(
            //   builder: (context, c){
            //     return Text(c?.maxWidth.toString()??"");
            //   }
            // ),
            //table headers
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 55,
                    child: Center(
                        child: Text(
                          "القيمة",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text(
                          "الخصم",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 55,
                    child: Center(
                        child: Text(
                          "السعر",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text(
                          "مستودع",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text(
                          "كمية",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text(
                          "العدد",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 50,
                    child: Center(
                        child: Text(
                          "الوحدة",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 160,
                    child: Center(
                        child: Text(
                          "اسم الصنف",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 70,
                    child: Center(
                        child: Text(
                          "رقم الصنف",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 30,
                    child: Center(
                        child: Text(
                          "م",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
              ]),
              //table content
              for (int i = 0; i < invoiceModel.invoiceDetailApiList!.length; i++)
                TableRow(children: [
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            (invoiceModel.invoiceDetailApiList![i].net ?? 0).toStringAsFixed(2),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 45,
                      child: Center(
                          child: Text(
                            (invoiceModel.invoiceDetailApiList![i].discount ?? 0).toStringAsFixed(2),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            (invoiceModel.invoiceDetailApiList![i].price ?? 0).toStringAsFixed(2),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            invoiceModel.invoiceDetailApiList![i].inventoryCode.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            invoiceModel.invoiceDetailApiList![i].quantity?.toStringAsFixed(2) ?? '',
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            invoiceModel.invoiceDetailApiList![i].number.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 50,
                      child: Center(
                          child: Text(
                            invoiceModel.invoiceDetailApiList![i].unitName.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 160,
                      child: Center(
                          child: Text(
                            invoiceModel.invoiceDetailApiList![i].name.toString(),
                            style: boldStyle2,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 70,
                      child: Center(
                          child: Text(
                            invoiceModel.invoiceDetailApiList![i].code.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 30,
                      child: Center(
                          child: Text(
                            "${i + 1}",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                ]),
            ]),
            SizedBox(height: 5),
            SizedBox(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                      width: 120,
                      child: Table(tableWidth: TableWidth.max, border: TableBorder.all(width: 0.5), children: [
                        TableRow(children: [
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    value?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    "القيمه",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                        TableRow(children: [
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    dariba?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    "الضريبة",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                        TableRow(children: [
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    total?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    "الاجمالي",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                        TableRow(children: [
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    discount?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    "الخصم",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                        TableRow(children: [
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    net?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(
                                    "الصافي",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                      ])),
                  SizedBox(
                      width: 145,
                      child: Table(tableWidth: TableWidth.max, border: TableBorder.all(width: 0.5), children: [
                        TableRow(children: [
                          SizedBox(
                              width: 60,
                              child: Center(
                                  child: Text(
                                    payed?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 80,
                              child: Center(
                                  child: Text(
                                    "المبلغ المدفوع",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                        TableRow(children: [
                          SizedBox(
                              width: 60,
                              child: Center(
                                  child: Text(
                                    remain?.toStringAsFixed(2)??"--",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                          SizedBox(
                              width: 80,
                              child: Center(
                                  child: Text(
                                    "المبلغ المتبقي",
                                    style: boldStyle,
                                    textDirection: TextDirection.rtl,
                                  ))),
                        ]),
                      ])),
                  SizedBox(
                      width: 120,
                      child: Container(
                          width: 80,
                          height: 80,
                          child: BarcodeWidget(
                            color: PdfColor.fromHex("#000000"),
                            barcode: Barcode.fromType(BarcodeType.QrCode),
                            drawText: false,
                            data: invoiceModel.qrCode.toString(),
                          )))
                ]))
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return m.LayoutBuilder(builder: (context, c) {
            return PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            );
          });
        });
  }

  void printSalesReports(m.BuildContext context, List<CategoriesTotalsResponse> salesReports) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final ttfBold = Font.ttf(font);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl),
        build: (Context context) {
          return [
            SizedBox(height: 50.5),
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text(
                          "التكلفة",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text(
                          "سعر البيع",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 55,
                    child: Center(
                        child: Text(
                          "العدد",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text(
                          "الفئة",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
                Container(
                    color: grey,
                    width: 55,
                    child: Center(
                        child: Text(
                          "الكود",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ))),
              ]),
              //table content
              for (int i = 0; i < salesReports.length; i++)
                TableRow(children: [
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            salesReports[i].allAvarageCost?.toStringAsFixed(2)??"",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            salesReports[i].allCost?.toStringAsFixed(2)??"",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            salesReports[i].number?.toStringAsFixed(2)??"",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 45,
                      child: Center(
                          child: Text(
                            salesReports[i].name ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            (salesReports[i].code)?.toStringAsFixed(2) ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                ]),
            ]),
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return m.LayoutBuilder(builder: (context, c) {
            return PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            );
          });
        });
  }

  void movementSalesReports(m.BuildContext context, List<InvoiceStatusResponse> data) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(
            pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [

            SizedBox(height: 50.5),
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child:
                        Text("#", style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("الفاتورة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 55,
                    child: Center(
                        child: Text("الفرع",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text("اسم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("عدد الثياب بالفاتورة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("تاريخ التسليم المشغل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("عدد الثياب بالمشغل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("تاريخ التسليم للطيار",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("عدد الثياب للطيار",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("تاريخ الاستعلام بالمعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("عدد الثياب بالمعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("تاريخ التسليم للعميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ]),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            (data[i].id)?.toStringAsFixed(2) ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 45,
                      child: Center(
                          child: Text(
                            data[i].invoiceSerial?.toStringAsFixed(2) ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            data[i].inventoryName ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            data[i].clientName ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].numberTobInvoice.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].factoryDate == null ? "" : DateFormat("MM-dd-yyy").format(data[i].factoryDate!),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].numberToFactory.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].deliveryDate == null ? "" : DateFormat("MM-dd-yyy").format(data[i].deliveryDate!),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].numberTobExitFactory.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].galaryDate == null ? "--" : DateFormat("MM-dd-yyy").format(data[i].galaryDate!),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].numberTobgallary.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].clientDate == null ? "--" : DateFormat("MM-dd-yyy").format(data[i].clientDate!),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void statements(m.BuildContext context, List<AccountStatementResponse> data) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            SizedBox(height: 50.5),
            Center(
              child:Text("كشف حساب العميل\n${data.first.organizationName} ${data.first.organizationCode}",
                  textAlign: TextAlign.center,
                  style: boldStyle
              )
            ),
            SizedBox(height: 10),
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("الرصيد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("دائن",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("مدين",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("الخزينة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("رقم فاتورة المبيعات",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text("نوع الحركة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                // Container(
                //     color: grey,
                //     width: 55,
                //     child: Center(
                //         child: Text("عميل",
                //             style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("التاريخ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("رقم الفاتورة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ]),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].balance?.toStringAsFixed(2)??"",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].adding.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].exitt.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].openningBalance?.toStringAsFixed(2)??"",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].invoiceSerial?.toString() ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            data[i].screenName??"",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  // Container(
                  //     width: 55,
                  //     child: Center(
                  //         child: Text(
                  //           data[i].organizationName??"",
                  //           style: boldStyle,
                  //           textAlign: TextAlign.center,
                  //           textDirection: TextDirection.rtl,
                  //         ))),
                  Container(
                      width: 45,
                      child: Center(
                          child: Text(
                            data[i].date == null ? "" : DateFormat("MM-dd-yyy").format(data[i].date!),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            data[i].serial.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                ]),
              TableRow(children: [
                SizedBox(),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text(data.fold<num>(0, (p, e) => p + (e.adding??0)).toStringAsFixed(2),
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text(data.fold<num>(0, (p, e) => p + (e.exitt??0)).toStringAsFixed(2),
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
              ]),
            ]),
            SizedBox(height: 5),
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return PdfPreview(
            actions: [
              m.IconButton(
                onPressed: () => m.Navigator.pop(context),
                icon: const m.Icon(
                  m.Icons.close,
                  color: m.Colors.red,
                ),
              )
            ],
            build: (format) => doc.save(),
          );
        });
  }

  void productionStages(m.BuildContext context, List<ProductionStagesResponse> data, InvoiceModel invoiceModel) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
    // final dm = Barcode.dataMatrix();
    //
    // final svg = dm.toSvg('114625', width: 80, height: 25);
    // final List<int> bytes = svg.codeUnits;
    // final im.Image? image = im.decodePng(bytes);
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            SizedBox(height: 50),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      invoiceModel.serial.toString(),
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: Text(
                      "مراحل الانتاج لفاتورة ذات رقم",
                      style: boldStyle,
                      textDirection: TextDirection.rtl,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //customer data and date
                SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(
                          invoiceModel.customerName ?? "",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ),
                        Spacer(),
                        Text(
                          "اسم العميل",
                          style: boldStyle,
                          textDirection: TextDirection.rtl,
                        ),
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            invoiceModel.customerCode ?? "",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "كود العميل",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // seller data
                SizedBox(
                  width: 180,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            invoiceModel.date == null ? "" : DateFormat("dd/MM/yyyy").format(invoiceModel.date!),
                            style: boldStyle.copyWith(fontSize: 10),
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "تاريخ الفاتورة",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            invoiceModel.dueDate == null ? "" : DateFormat("dd/MM/yyyy").format(invoiceModel.dueDate!),
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Text(
                            "تاريخ التسليم",
                            style: boldStyle,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            SizedBox(height: 50.5),
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("الموظف",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("المرحلة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 55,
                    child: Center(
                        child: Text("الكمية",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text("اسم الصنف",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("التاريخ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child:
                        Text("#", style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ]),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            data[i].empName ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 45,
                      child: Center(
                          child: Text(
                            data[i].stage ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            data[i].quantity?.toStringAsFixed(2) ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            data[i].productName ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].date == null ? "" : DateFormat("MM-dd-yyyy").format(data[i].date!),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].number?.toStringAsFixed(2) ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return PdfPreview(
            actions: [
              m.IconButton(
                onPressed: () => m.Navigator.pop(context),
                icon: const m.Icon(
                  m.Icons.close,
                  color: m.Colors.red,
                ),
              )
            ],
            build: (format) => doc.save(),
          );
        });
  }

  void treasuryStatement(m.BuildContext context, List<TreasuryModel> data, DateTime fromDate, DateTime toDate) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final style = TextStyle(font: ttfLight, fontBold: ttfBold);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 11);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
    Text text(String text, {double? size, FontWeight? weight}) => Text(text, style: style.copyWith(fontSize: size, fontWeight: weight));

    for (var i = 0; i < data.length; i++) {
      final bank = data[i];
      doc.addPage(MultiPage(
          pageTheme: const PageTheme(
            pageFormat: PdfPageFormat.a4,
            textDirection: TextDirection.rtl,
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
            orientation: PageOrientation.landscape,
          ),
          build: (Context context) {
            return [
              if (data.indexOf(bank) == 0)
                Column(
                  children: [
                    Center(
                        child: Container(
                            decoration: const BoxDecoration(color: PdfColors.grey400),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                            child: Text(
                              "كشف حساب خزينة - بنك",
                              style: boldStyle.copyWith(fontSize: 10),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                            ))),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        text(DateFormat("MM-dd-yyyy").format(fromDate), weight: FontWeight.bold),
                        SizedBox(width: 15),
                        text("من تاريخ:", weight: FontWeight.bold),
                        SizedBox(width: 15),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        text(DateFormat("MM-dd-yyyy").format(toDate), weight: FontWeight.bold),
                        SizedBox(width: 15),
                        text("الى تاريخ:", weight: FontWeight.bold),
                        SizedBox(width: 15),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              Container(
                foregroundDecoration: BoxDecoration(border: Border.all()),
                child: Row(
                  children: [
                    Expanded(
                      flex: 12,
                      child: text(bank.bankName ?? "", size: 10),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                          decoration: const BoxDecoration(
                            color: PdfColors.grey400,
                            border: Border(left: BorderSide()),
                          ),
                          margin: const EdgeInsets.only(left: 15),
                          alignment: Alignment.center,
                          child: text("اسم البنك", weight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(), color: grey),
                      child: Center(
                        child: Text(
                          "الرصيد",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(), color: grey),
                      child: Center(
                        child: Text(
                          "مدين",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(), color: grey),
                      child: Center(
                        child: Text(
                          "البيان",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(), color: grey),
                      child: Center(
                        child: Text(
                          "مناولة",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(), color: grey),
                      child: Center(
                        child: Text(
                          "اسم العميل",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(border: Border.all(), color: grey),
                    child: Center(
                      child: Text(
                        "كود العميل",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(border: Border.all(), color: grey),
                    child: Center(
                      child: Text(
                        "رقم الفاتورة",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(border: Border.all(), color: grey),
                    child: Center(
                      child: Text(
                        "نوع الحركة",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(border: Border.all(), color: grey),
                    child: Center(
                      child: Text(
                        "رقم",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(border: Border.all(), color: grey),
                    child: Center(
                      child: Text(
                        "التاريخ",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                ],
              ),
              for (final statement in bank.statements)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 40,
                          child: Center(
                            child: Text(
                              statement.balance?.toStringAsFixed(2) ?? " ",
                              style: normalStyle,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        )),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 40,
                          child: Center(
                            child: Text(
                              statement.debitAmount?.toStringAsFixed(2) ?? " ",
                              style: normalStyle,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        )),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 40,
                          child: Center(
                            child: Text(
                              statement.remark ?? " ",
                              style: normalStyle,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        )),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 40,
                          child: Center(
                            child: Text(
                              statement.remark2 ?? " ",
                              style: normalStyle,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        height: 40,
                        child: Center(
                          child: Text(
                            statement.customerName ?? " ",
                            style: normalStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 40,
                          child: Center(
                            child: Text(
                              statement.customerCode ?? " ",
                              style: normalStyle,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        )),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 40,
                          child: Center(
                            child: Text(
                              statement.invoiceNumber?.toString() ?? "",
                              style: normalStyle,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        )),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 40,
                          child: Center(
                            child: Text(
                              statement.transactionType ?? " ",
                              style: normalStyle,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        )),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 40,
                          child: Center(
                            child: Text(
                              statement.serial?.toString() ?? " ",
                              style: normalStyle,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        )),
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Border.all()),
                          height: 40,
                          child: Center(
                            child: Text(
                              statement.date == null ? "" : DateFormat("MM-dd-yyyy").format(statement.date!),
                              style: normalStyle,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        )),
                  ],
                ),
              Container(
                foregroundDecoration: BoxDecoration(border: Border.all()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(flex: 1),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(left: BorderSide(width: 1.1)),
                        ),
                        child: text(
                          bank.statements.first.totalDebit?.toStringAsFixed(2) ?? "",
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: PdfColors.grey400,
                          border: Border(left: BorderSide()),
                        ),
                        padding: const EdgeInsets.only(right: 15),
                        child: text("الاجمالي", weight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          }));
    }

    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }
  //
  // void galleryInvoices(m.BuildContext context, List<InvoiceModel> data) async {
  //   final doc = Document();
  //   const PdfColor grey = PdfColors.grey400;
  //   final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
  //   final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  //   final ttfBold = Font.ttf(font);
  //   final ttfLight = Font.ttf(fontLight);
  //   final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
  //   final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
  //   final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
  //   // final dm = Barcode.dataMatrix();
  //   //
  //   // final svg = dm.toSvg('114625', width: 80, height: 25);
  //   // final List<int> bytes = svg.codeUnits;
  //   // final im.Image? image = im.decodePng(bytes);
  //   doc.addPage(MultiPage(
  //       // header: (_) => Container(
  //       //     height: 25,
  //       //     decoration: const BoxDecoration(),
  //       //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //       //       Text(
  //       //         DateTime.now().toIso8601String().split("T")[0],
  //       //         style: boldStyle,
  //       //         textDirection: TextDirection.rtl,
  //       //       ),
  //       //       Text(
  //       //         context.read<AuthProvider>().userModel!.data!.name!,
  //       //         style: boldStyle,
  //       //         textDirection: TextDirection.rtl,
  //       //       ),
  //       //     ])),
  //       pageTheme: const PageTheme(
  //           pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
  //       build: (Context context) {
  //         return [
  //           Directionality(
  //             textDirection: TextDirection.ltr,
  //             child: Column(children: [
  //               SizedBox(height: 50.5),
  //               Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
  //                 TableRow(children: [
  //                   Container(
  //                       color: grey,
  //                       width: 45,
  //                       child: Center(
  //                           child: Text("رقم الفاتورة",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 45,
  //                       child: Center(
  //                           child: Text("رقم امر الشغل",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 55,
  //                       child: Center(
  //                           child: Text("التاريخ",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 60,
  //                       child: Center(
  //                           child:
  //                               Text("كود", style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("العميل",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("الهاتف",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("الحالة",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("المرحلة",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("الاستلام",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("المتبقي",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("شركات",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("عدد الثوب",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("مدخل الفاتورة",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("ملاحظات",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                   Container(
  //                       color: grey,
  //                       width: 40,
  //                       child: Center(
  //                           child: Text("check",
  //                               style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //                 ]),
  //                 //table content
  //                 for (int i = 0; i < data.length; i++)
  //                   TableRow(children: [
  //                     Container(
  //                         width: 55,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].serialTax?.toStringAsFixed(2) ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 45,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].serial?.toStringAsFixed(2) ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 55,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].date == null ? "" : DateFormat("MM-dd-yyyy").format(data[i].date!),
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 60,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].customerCode ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].customerName ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].customerMobile ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].status ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].invoiceLastStatus ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].dueDate == null ? "" : DateFormat("MM-dd-yyyy").format(data[i].dueDate!),
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].remain?.toStringAsFixed(2) ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].customerNotice ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].numberOfToob?.toStringAsFixed(2) ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].createdByName ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           data[i].remarks ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                     Container(
  //                         width: 40,
  //                         child: Center(
  //                             child: Text(
  //                           "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                   ]),
  //               ]),
  //               SizedBox(height: 5),
  //             ]),
  //           )
  //         ];
  //       }));
  //
  //   m.showDialog(
  //       context: context,
  //       builder: (context) {
  //         return m.RotatedBox(
  //           quarterTurns: 3,
  //           child: PdfPreview(
  //             actions: [
  //               m.IconButton(
  //                 onPressed: () => m.Navigator.pop(context),
  //                 icon: const m.Icon(
  //                   m.Icons.close,
  //                   color: m.Colors.red,
  //                 ),
  //               )
  //             ],
  //             build: (format) => doc.save(),
  //           ),
  //         );
  //       });
  // }
  //

  void invoicesByStatus(m.BuildContext context, List<InvoiceStatementByCaseResponse> data) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(2),
      5:const FlexColumnWidth(2),
      6:const FlexColumnWidth(1),
      7:const FlexColumnWidth(1),
      8:const FlexColumnWidth(2),
      9:const FlexColumnWidth(2),
      10:const FlexColumnWidth(1),
      11:const FlexColumnWidth(1),
    };
    doc.addPage(MultiPage(
      maxPages:1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            SizedBox(height: 50.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اخر مرحلة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد الثواب",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد الايام المتبقية",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("تاريخ الاستحقاق",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("كود العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("تاريخ الفاتورة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child:
                        Text("الفرع", style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الملاحظات",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الفاتورة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("#",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].invoiceLastStatus ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].numberOfToob?.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].remainDueDayesNumber?.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].dueDate == null ? "" : DateFormat("MM-dd-yyyy").format(data[i].dueDate!),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].customerMobile ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].customerName ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].customerCode ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].date == null ?"":DateFormat("MM/dd/yyyy").format(data[i].date!),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].gallaryName ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].remarks??'',
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].serial?.toStringAsFixed(2) ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        "${i+1}",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void fash(m.BuildContext context, List<InvoiceDetailsModel> data, InvoiceModel invoiceModel) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final ttfBold = Font.ttf(font);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            SizedBox(height: 50),
            SizedBox(
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                padding: const EdgeInsets.all(2),
                child: Text(
                  "تفاصيل الفسح",
                  style: boldStyle,
                  textDirection: TextDirection.rtl,
                ),
              )
            ])),
            SizedBox(height: 20.5),
            SizedBox(
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //customer data and date
              SizedBox(
                  width: 200,
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        invoiceModel.supplierDate == null?"":DateFormat("dd/MM/yyyy").format(invoiceModel.supplierDate!),
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                      ),
                      Spacer(),
                      Text(
                        "تاريخ فاتورة العميل",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        invoiceModel.customerName ?? "",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                      Spacer(),
                      Text(
                        "العميل",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        invoiceModel.customerCode ?? "",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                      Spacer(),
                      Text(
                        "كود العميل",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                    ]),
                  ])),
              // seller data
              SizedBox(
                  width: 180,
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        invoiceModel.serial?.toString() ?? "",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                      Spacer(),
                      Text(
                        "رقم الفسح",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        invoiceModel.date == null ? "" : DateFormat("dd/MM/yyyy").format(invoiceModel.date!),
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                      Spacer(),
                      Text(
                        "التاريخ",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        invoiceModel.loadedSerial.toString()??"",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                      Spacer(),
                      Text(
                        "رقم فاتورة المبيعات",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        invoiceModel.remarks ?? "",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                      Spacer(),
                      Text(
                        "ملاحظات",
                        style: boldStyle,
                        textDirection: TextDirection.rtl,
                      ),
                    ]),
                  ])),
            ])),
            SizedBox(height: 15),
            SizedBox(height: 50.5),
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("العدد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("البند",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ]),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Container(
                      width: 45,
                      child: Center(
                          child: Text(
                            data[i].quantityOfOneUnit?.toStringAsFixed(2) ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            "${data[i].name} ${data[i].code}",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return PdfPreview(
            actions: [
              m.IconButton(
                onPressed: () => m.Navigator.pop(context),
                icon: const m.Icon(
                  m.Icons.close,
                  color: m.Colors.red,
                ),
              )
            ],
            build: (format) => doc.save(),
          );
        });
  }

  void itemSales(m.BuildContext context, List<PurchaseBySupplierGroup> data, DateTime fromDate, DateTime toDate) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey300;
    const PdfColor grey4 = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final style = TextStyle(font: ttfLight, fontBold: ttfBold);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 11);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
    Text text(String text, {double? size, FontWeight? weight}) => Text(text, style: style.copyWith(fontSize: size, fontWeight: weight));
    final widths = <int, TableColumnWidth>{
      0: const FlexColumnWidth(1),
      1: const FlexColumnWidth(1),
      2: const FlexColumnWidth(1),
      3: const FlexColumnWidth(1),
      4: const FlexColumnWidth(1),
      5: const FlexColumnWidth(2),
      6: const FlexColumnWidth(1),
      7: const FlexColumnWidth(1),
      8: const FlexColumnWidth(1),
      9: const FlexColumnWidth(1),
      10: const  FlexColumnWidth(2),
    };
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(
          pageFormat: PdfPageFormat.a4,
          textDirection: TextDirection.rtl,
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
          orientation: PageOrientation.landscape,
        ),
        build: (Context context) {
          return [
            Center(
                child: Container(
                    decoration: const BoxDecoration(color: PdfColors.grey400),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Text(
                      "مبيعات الاصناف حسب العملاء",
                      style: boldStyle.copyWith(fontSize: 10),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                    ))),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    text(DateFormat("dd-MM-yyyy").format(toDate), weight: FontWeight.bold),
                    SizedBox(width: 15),
                    text("الى الفترة:", weight: FontWeight.bold),
                    SizedBox(width: 15),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    text(DateFormat("dd-MM-yyyy").format(fromDate), weight: FontWeight.bold),
                    SizedBox(width: 15),
                    text("من الفترة:", weight: FontWeight.bold),
                    SizedBox(width: 15),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max,columnWidths: widths, children: [
              TableRow(children: [
                Center(
                  child: Text(
                    "قيمة",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "الخصم",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "تكلفة الشراء",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "الكمية",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "الوحدة",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "البيان",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "رقم الصنف",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "تاريخ الفاتورة",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "رقم الشغل",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "رقم الفاتورة",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                Center(
                  child: Text(
                    "اسم العميل",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],decoration: const BoxDecoration(color: grey)),
            ]),
            for (final supplier in data)
              Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max,columnWidths: widths, children: [
                TableRow(children: [
                  Container(
                    color: grey4,
                    child: Center(
                      child: Text(
                        supplier.purchases.fold<num>(0, (p, e) => p+(e.cost??0)).toStringAsFixed(2),
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: grey4,
                    child: Center(
                      child: Text(
                        "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: grey4,
                    child: Center(
                      child: Text(
                        "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: grey4,
                    child: Center(
                      child: Text(
                        "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: grey4,
                    child: Center(
                      child: Text(
                        "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: grey4,
                    child: Center(
                      child: Text(
                        "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: grey4,
                    child: Center(
                      child: Text(
                        "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: grey4,
                    child: Center(
                      child: Text(
                        "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: grey4,
                    child: Center(
                      child: Text(
                        "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: grey4,
                    child: Center(
                      child: Text(
                        "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    color: grey4,
                    width: 100,
                    child: Center(
                      child: Text(
                        supplier.name,
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],decoration: const BoxDecoration(color: grey4)),
                for (final purchase in supplier.purchases)
                  TableRow(children: [
                    Center(
                      child: Text(
                        purchase.cost?.toStringAsFixed(2)??"",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        purchase.discount?.toStringAsFixed(2) ?? "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        purchase.costAvarage?.toStringAsFixed(2) ?? "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        purchase.quantityOfOne?.toStringAsFixed(2) ?? "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        purchase.itemUnitName ?? "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        purchase.itemName ?? '',
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        purchase.itemCode ??'',
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        purchase.date == null?"null":DateFormat("MM/dd/yyyy").format(purchase.date!),
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        purchase.number.toString(),
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        purchase.serial.toString(),
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        "",
                        style: boldStyle.copyWith(fontSize: 10),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
              ]),

            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max,columnWidths: widths, children: [
              TableRow(children: [
                Center(
                  child: Text(
                    data.fold<num>(0, (p, e) => p + (e.purchases.fold<num>(0, (p, e) => p + (e.cost ?? 0)))).toStringAsFixed(2),
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                SizedBox(),
                Center(
                  child: Text(
                    "الاجمالي",
                    style: boldStyle.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],decoration: const BoxDecoration(color: grey)),
            ]),
          ];
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printItemBarcode(m.BuildContext context, ItemResponse item) async {
    final doc = Document();
    final name = UserManager().galleryType == 0 ? "برنس" : "لي رويال";
    final type = UserManager().galleryType;
    num cost = (type == 1 ? ((item.maxPriceMen ?? 0) * 0.85) : item.maxPriceMen) ?? 0;
    cost += cost * 0.15;
    num? costAfterDiscount;
    if (item.discountrate != null && item.discountrate! > 0 && item.discountValue != null) {
      costAfterDiscount = item.discountValue! + (item.discountValue! * 0.15);
    }
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
    doc.addPage(Page(
        pageTheme: const PageTheme(pageFormat: PdfPageFormat(96, 70, marginAll: 1.0), textDirection: TextDirection.rtl),
        build: (Context context) {
          return Column(
            children: [
              Text(name, style: normalStyle, textAlign: TextAlign.center),
              BarcodeWidget(
                height: 10,
                width: 80,
                color: PdfColor.fromHex("#000000"),
                barcode: Barcode.fromType(BarcodeType.Codabar),
                drawText: false,
                data: item.code.toString(),
              ),
              Spacer(flex: 2),
              Text(item.name.toString(), style: boldStyle2),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(children: [
                  Text("${cost?.toStringAsFixed(3)} SR",
                      style: TextStyle(fontSize: 9, decoration: costAfterDiscount != null ? TextDecoration.lineThrough : null)),
                  if (costAfterDiscount != null) Text("${costAfterDiscount.toStringAsFixed(3)} SR", style: TextStyle(fontSize: 9)),
                ]),
                Text(item.code.toString(), style: TextStyle(fontSize: 9)),
              ]),
              Spacer(),
            ],
          );
        }));

    m.showDialog(
        context: context,
        builder: (context) {
          return m.LayoutBuilder(builder: (context, c) {
            return PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            );
          });
        });
  }

  void printSalesItemsByCompany(m.BuildContext context, List<SalesOfItemsByCompanyResponse> data,DateTime datefrom,DateTime dateto,List<DeliveryPlaceResposne> deliverysel) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(2),
      1:const FlexColumnWidth(2),
      2:const FlexColumnWidth(2),
      3:const FlexColumnWidth(2),


    };
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "المبيعات حسب الشركات لفتره",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(deliverysel[0].name??"",  style:boldStyle),
                    SizedBox(width: 15),
                    Text("المعرض", style:boldStyle),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),

                  ],
                ),
              ],
            ),

            SizedBox(height: 50.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اجمالي المبيعات",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم الشركه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("كود الشركه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("المعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),


              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].totalSales==null?"":  data[i].totalSales.toString() ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].companyName==null?"الاجمالي":  data[i].companyName! ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].companyCode==null?"":  data[i].companyCode!.toString() ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                  Center(
                      child: Text(
                        data[i].gallaryName ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),



                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printProfitSold(m.BuildContext context, List<ProfitOfItemsSoldResponse> data,DateTime datefrom,DateTime dateto,List<DeliveryPlaceResposne> deliverysel,String stat) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(1),
      5:const FlexColumnWidth(1),
      6:const FlexColumnWidth(1),


    };
    doc.addPage(MultiPage(
        maxPages: 1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "مبيعات الاصناف",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(deliverysel[0].name??"",  style:boldStyle),
                    SizedBox(width: 15),
                    Text("المعرض", style:boldStyle),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(stat,  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الحاله", style:boldStyle),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 20.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اجمالي سعرالبيع",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الخصم الكلي",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد المبيعات",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("كميه المبيعات",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("متوسط التكلفه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الاسم",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("الكود",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),




              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].totallSell?.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].totallDiscount?.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].totallNumber?.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].totallNet?.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].costAverage?.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].name! ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].code!.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),


                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printItemsBalance(m.BuildContext context, List<ItemsBalanceResponse> data,DateTime datefrom,DateTime dateto) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),

    };
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.portrait, margin: EdgeInsets.all(10)),
        maxPages: 1000,
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "ارصده الاصناف",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),

                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 10.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("متوسط التكلفه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("سعر البيع",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم الصنف",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم الصنف",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),


              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].costAverage?.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].sallary?.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].name! ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                  Center(
                      child: Text(
                        data[i].code!.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),


                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return PdfPreview(
            actions: [
              m.IconButton(
                onPressed: () => m.Navigator.pop(context),
                icon: const m.Icon(
                  m.Icons.close,
                  color: m.Colors.red,
                ),
              )
            ],
            build: (format) => doc.save(),
          );
        });
  }

  void printInvoicesWithoutSweing(m.BuildContext context, List<CompanyInvoicesWithoutSewingResponse> data,DateTime datefrom,DateTime dateto) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(2),
      2:const FlexColumnWidth(2),
      3:const FlexColumnWidth(2),
      4:const FlexColumnWidth(2),

    };
    doc.addPage(MultiPage(
        maxPages: 1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "فواتير الشركات بدون خياطه",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),

                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),

                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 10.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الاجمالي",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الكود",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الاسم",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم المعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم الفاتوره",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),



              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].total==null?"":data[i].total!.toString() ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].code==null?"": data[i].code!.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].name ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].galleryName ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                  Center(
                      child: Text(
          data[i].id==null?"": data[i].id!.toString() ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),


                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printCustomersNoMovement(m.BuildContext context, List<ClientsNoMovementResponse> data,List<DeliveryPlaceResposne> deliverysel,DateTime datefrom) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(2),
      2:const FlexColumnWidth(2),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(2),

    };
    doc.addPage(MultiPage(
        maxPages: 1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "عملاء ليس لديهم حركه من تاريخ",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(deliverysel[0].name??"",  style:boldStyle),
                    SizedBox(width: 15),
                    Text("المعرض", style:boldStyle),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 50.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اجمالي التعامل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("تاريخ اخر فاتوره",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الهاتف",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),



              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].totalInvoices!.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        DateFormat("yyyy-MM-dd").format(data[i].lastInvoiceDate!)??""
                        ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].phoneNumber ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].clientName ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].clientNumber ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),


                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printCustomersBalance(m.BuildContext context, List<FindCustomersBalanceResponse> data,DeliveryPlaceResposne? deliverysel) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(1),
      5:const FlexColumnWidth(1),
      6:const FlexColumnWidth(1),

    };
    doc.addPage(MultiPage(
        maxPages: 1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "ارصده العملاء",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(deliverysel!.name??"",  style:boldStyle),
                    SizedBox(width: 15),
                    Text("المعرض", style:boldStyle),
                    SizedBox(width: 100),

                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 10.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الفواتير",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الرصيد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الدائن",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("المدين",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الرصيد الافتتاحي",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),




              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].organizationsiteId.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].balance.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].creditor.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].debit.toString() ?? "",

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].openningBalance.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].clientName ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                  Center(
                      child: Text(
                        data[i].clientCode ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),


                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printStatementOfBondsByBranch(m.BuildContext context, List<FindStatementOfBondsByBranchReportResponse> data,DateTime datefrom,DateTime dateto) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(1),



    };
    doc.addPage(MultiPage(
        maxPages: 1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "بيان بالسندات الصادره حسب الفرع",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 50.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("القيمه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("نوع السداد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("النوع",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الكود",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم المعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),








              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].totalAmount.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].type.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].paymentType.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].galleryCode.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                  Center(
                      child: Text(
                        data[i].galleryName ?? "",

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),






                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printSalesValueAddedDetails(m.BuildContext context, List<FindSalesValueAddedDetailsResponse> data,DateTime datefrom,DateTime dateto,List<DeliveryPlaceResposne> deliverysel) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(1),
      5:const FlexColumnWidth(1),
      6:const FlexColumnWidth(1),
      7:const FlexColumnWidth(1),


    };
    doc.addPage(MultiPage(
        maxPages: 1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "بيان الفواتير حسب الضريبه تفصيلي",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(deliverysel[0].name??"",  style:boldStyle),
                    SizedBox(width: 15),
                    Text("المعرض", style:boldStyle),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 10.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الضريبه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الاجمالي بعد الضريبه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الاجمالي قبل الضريبه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الموظف",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم المعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("التاريخ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("نوع الفاتوره",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم الفاتوره",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),




              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].tax.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].totalAfterTax.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].totalBeforeTax.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].employeeName ?? "",

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].galleryName ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        DateFormat("yyyy-MM-dd").format(data[i].invoiceDate!)
                            ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].invoiceType.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].invoiceNumber.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),


                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printSalesValueAdded(m.BuildContext context, List<FindSalesValueAddedResponse> data,DateTime datefrom,DateTime dateto,List<DeliveryPlaceResposne> deliverysel) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),


    };
    doc.addPage(MultiPage(
        maxPages: 1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "بيان الفواتير حسب الضريبه",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(deliverysel[0].name??"",  style:boldStyle),
                    SizedBox(width: 15),
                    Text("المعرض", style:boldStyle),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 20.5),
            Directionality(textDirection: TextDirection.rtl, child:  Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الضريبه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الاجمالي بعد الضريبه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الاجمالي قبل الضريبه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم المعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),





              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].tax.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].totalAfterTax.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].totalBeforeTax.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].galleryName ?? "",

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),


                ]),

            ]),),

            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printBalanceGallary(m.BuildContext context, List<BalanceGalaryResponse> data,DateTime datefrom,DateTime dateto,List<DeliveryPlaceResposne> deliverysel) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),



    };
    doc.addPage(MultiPage(
        maxPages: 1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "تقرير العمولات",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(deliverysel[0].name??"",  style:boldStyle),
                    SizedBox(width: 15),
                    Text("المعرض", style:boldStyle),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 10.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("القيمه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم البنك",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("النوع",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم المعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),




              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [

                  Center(
                      child: Text(
                        data[i].value.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].bankName.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].transactionType ?? "",

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].gallaryName ?? "",

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printBalanceGallaryUnpaid(m.BuildContext context, List<BalanceGalaryUnpaidResponse> data,DateTime datefrom,DateTime dateto) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),


    };
    doc.addPage(MultiPage(
        maxPages: 1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "تقرير بالمبالغ الغير مسدده",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),

                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 30.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("القيمه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("المعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),





              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [

                  Center(
                      child: Text(
                        data[i].value.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                  Center(
                      child: Text(
                        data[i].gallaryName ?? "",

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),


                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printBalanceGallarypaid(m.BuildContext context, List<BalanceGalaryUnpaidResponse> data,DateTime datefrom,DateTime dateto) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),


    };
    doc.addPage(MultiPage(
        maxPages: 1000,

        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "تقرير بالمبالغ  المسدده",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),

                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 30.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("القيمه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("المعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),





              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [

                  Center(
                      child: Text(
                        data[i].value.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                  Center(
                      child: Text(
                        data[i].gallaryName ?? "",

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),


                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printInvItem(m.BuildContext context, List<InvItemDtoResponse> data) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(1),
      5:const FlexColumnWidth(1),
      6:const FlexColumnWidth(1),
      7:const FlexColumnWidth(1),
      8:const FlexColumnWidth(1),
      9:const FlexColumnWidth(1),
      10:const FlexColumnWidth(1),
      11:const FlexColumnWidth(2),
      12:const FlexColumnWidth(1),



    };
    doc.addPage(MultiPage(
        maxPages: 1000,

        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "الاصناف حسب  الفئات",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),

              ],
            ),

            SizedBox(height: 50.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("المتاح",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("طبيعه الصنف",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد الامتار للشباب",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد الامتار للرجال",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد الامتار المجانيه للشباب",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد الامتار المجانيه للرجال",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اقل سعر للشباب",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اقل سعر للرجال",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اعلي سعر للشباب",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اعلي سعر للرجال",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("التكلفه",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم الصنف",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم الصنف",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),






              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [

                  Center(
                      child: Text(
                        data[i].quantity.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].itemNatural.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].numbermetersyoung.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].numbermetersmen.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].numbermetersfreeyoung.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].numbermetersfreemen.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].minpriceyoung.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].minpricemen.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].maxpriceyoung.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].maxpricemen.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].sellPrice.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].name ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].code ?? "",

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),



                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printInvoiceMovement(m.BuildContext context, List<InvoiceMovementResponse> data,DateTime datefrom,DateTime dateto,int frominvoice,int toinvoice,List<DeliveryPlaceResposne> deliverysel) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(1),
      5:const FlexColumnWidth(1),
      6:const FlexColumnWidth(1),
      7:const FlexColumnWidth(1),
      8:const FlexColumnWidth(1),
      9:const FlexColumnWidth(1),
      10:const FlexColumnWidth(1),




    };
    doc.addPage(MultiPage(
      maxPages: 1000,
        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "حركه الثياب",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),

                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(toinvoice.toString(),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي فاتوره:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(frominvoice.toString(),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من فاتوره", style:boldStyle),
                    SizedBox(width: 15),

                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(deliverysel[0].name??"",  style:boldStyle),
                    SizedBox(width: 15),
                    Text("المعرض:", style:boldStyle),
                    SizedBox(width: 15),


                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 10.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("تاريخ التسليم للعميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد الثياب بالمعرض ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("تاريخ التسليم بالمعرض ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد الثياب للطيار",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("تاريخ التسليم للطيار",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد الثياب بالمشغل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("تاريخ التسليم بالمشغل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("عدد الثياب بالفاتوره  ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اسم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("الفاتوره",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الفرع",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),


              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [


                  Center(
                      child: Text(
                        "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                  Center(
                      child: Text(
                        data[i].numberTobgallary==null?"":data[i].numberTobgallary.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].numberTobcustomer==null?"":data[i].numberTobcustomer.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].deliveryDate==null?"": DateFormat("yyyy-MM-dd").format(data[i].deliveryDate!),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].numberToFactory==null?"":data[i].numberToFactory.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].factoryDate==null?"": DateFormat("yyyy-MM-dd").format(data[i].factoryDate!),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].numberTobInvoice==null?"":  data[i].numberTobInvoice.toString() ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].clientName==null?"":  data[i].clientName! ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].inventoryName ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                  Center(
                      child: Text(
                        data[i].invoiceSerial.toString() ?? "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),




                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printSalesForPeriod(m.BuildContext context, List<CategoriesItemsResponse> data,DateTime datefrom,DateTime dateto) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(1),
      5:const FlexColumnWidth(1),
      6:const FlexColumnWidth(1),
      7:const FlexColumnWidth(2),
      8:const FlexColumnWidth(1),
      9:const FlexColumnWidth(1),
      10:const FlexColumnWidth(1),
      11:const FlexColumnWidth(2),





    };
    doc.addPage(MultiPage(
        maxPages: 1000,

        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "بيان المبيعات لفتره",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),

                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 10.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الحاله",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الباقي",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("المسدد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اشعار دائن",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("اشعار مدين",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("قيمه المرتجع",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("قيمه الفاتوره",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("التاريخ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("المعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),




              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Center(
                      child: Text(
                        data[i].invoiceStatus==null?"":data[i].invoiceStatus!,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].remain==null?"":data[i].remain.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].paid==null?"":data[i].paid.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].noticeCredit==null?"": data[i].noticeCredit.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].noticeDebit==null?"":data[i].noticeDebit.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].returnPurchaseValue==null?"":data[i].returnPurchaseValue.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].totalAfterTax==null?"":data[i].totalAfterTax.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].name==null?"": data[i].name!,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].code==null?"":  data[i].code.toString() ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        DateFormat("yyyy-MM-dd").format(data[i].invoiceDate!),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].serial.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),


                  Center(
                      child: Text(
                        data[i].galleryName!  ,

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),





                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printCategoriesItems(m.BuildContext context, List<CategoriesItemsResponse> data,DateTime datefrom) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(2),
      5:const FlexColumnWidth(1),
      6:const FlexColumnWidth(1),
      7:const FlexColumnWidth(1),
      8:const FlexColumnWidth(2),





    };
    doc.addPage(MultiPage(
        maxPages: 1000,

        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "الفواتير المسدده لفتره سابقه",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),

                  ],
                ),
                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 10.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("الباقي",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("المسدد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("صافي الفاتوره",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("قيمه الفاتوره",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("التاريخ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),

                Container(
                    color: grey,
                    child: Center(
                        child: Text("المعرض",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),



              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [

                  Center(
                      child: Text(
                        data[i].remain==null?"":data[i].remain.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].paid==null?"":data[i].paid.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].totalBeforeTax==null?"": data[i].totalNet.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].totalAfterTax==null?"":data[i].invoiceId.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].name==null?"": data[i].name!,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].code==null?"":  data[i].code.toString() ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        DateFormat("yyyy-MM-dd").format(data[i].invoiceDate!),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].serial.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),

                  Center(
                      child: Text(
                        data[i].galleryName!  ,

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),




                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }

  void printJournalDocument(m.BuildContext context, List<JournalDocumentDialyResponse> data,DateTime datefrom,DateTime dateto,int fromaccount,int toaccount,int fromkind,int tokind,GlAccountResponse fromglAccountResponse,GlAccountResponse toglAccountResponse,CostCenterResponse fromcost,CostCenterResponse tocost) async {
    final doc = Document();
    const PdfColor grey = PdfColors.grey400;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final ttfLight = Font.ttf(fontLight);
    final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
    final widths = {
      0:const FlexColumnWidth(1),
      1:const FlexColumnWidth(1),
      2:const FlexColumnWidth(1),
      3:const FlexColumnWidth(1),
      4:const FlexColumnWidth(1),
      5:const FlexColumnWidth(1),
      6:const FlexColumnWidth(1),




    };
    doc.addPage(MultiPage(
        maxPages: 1000,

        pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            Column(
              children: [
                Center(
                    child: Container(
                        decoration: const BoxDecoration(color: PdfColors.grey400),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text(
                          "قيد اليوميه تفصيلي",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(tokind.toString(),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي نوع القيد:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(fromkind.toString(),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من نوع القيد:", style:boldStyle),
                    SizedBox(width: 15),
                    Text(toaccount.toString(),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي رقم القيد:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(fromaccount.toString(),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من رقم القيد:", style:boldStyle),
                    SizedBox(width: 15),
                    Text(DateFormat("dd-MM-yyyy").format(dateto),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي تاريخ:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(DateFormat("dd-MM-yyyy").format(datefrom),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من تاريخ:", style:boldStyle),
                    SizedBox(width: 15),


                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(tokind.toString(),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي وحده اداريه:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(fromkind.toString(),  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من وحده اداريه:", style:boldStyle),
                    SizedBox(width: 15),
                    Text(tocost.name!,  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي مركز تكلفه:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(fromcost.name!,  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من مركز تكلفه:", style:boldStyle),
                    SizedBox(width: 15),
                    Text(toglAccountResponse.name!,  style:boldStyle),
                    SizedBox(width: 15),
                    Text("الي الحساب:", style:boldStyle),
                    SizedBox(width: 15),
                    SizedBox(width: 100),
                    Text(fromglAccountResponse.name!,  style:boldStyle),
                    SizedBox(width: 15),
                    Text("من الحساب :", style:boldStyle),
                    SizedBox(width: 15),


                  ],
                ),

                SizedBox(height: 15),
              ],
            ),

            SizedBox(height: 10.5),
            Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
              TableRow(decoration: BoxDecoration(color: grey),children: [
                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم القيد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("رقم السند",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("التاريخ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("مراجعه الفاتوره ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("وزن القيد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("مدخل القيد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    child: Center(
                        child: Text("بيان القيد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),







              ],),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [

                  Center(
                      child: Text(
                        data[i].serial==null?"":  data[i].serial.toString(),
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].generalDocument==null?"": data[i].generalDocument.toString() ,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].generalDate==null?"":DateFormat("yyyy-MM-dd").format(data[i].generalDate! ),

                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        "",
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),
                  Center(
                      child: Text(
                        data[i].generalStatement==null?"": data[i].generalStatement!,
                        style: normalStyle,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      )),




                ]),
            ]),
            SizedBox(height: 5),
          ];
        }));
    m.showDialog(
        context: context,
        builder: (context) {
          return m.RotatedBox(
            quarterTurns: 3,
            child: PdfPreview(
              actions: [
                m.IconButton(
                  onPressed: () => m.Navigator.pop(context),
                  icon: const m.Icon(
                    m.Icons.close,
                    color: m.Colors.red,
                  ),
                )
              ],
              build: (format) => doc.save(),
            ),
          );
        });
  }


}
