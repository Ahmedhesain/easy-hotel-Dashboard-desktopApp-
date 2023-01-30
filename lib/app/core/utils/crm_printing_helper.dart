
import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../data/model/crm_reports/dto/response/crm_event_dto.dart';
import '../../data/model/crm_reports/dto/response/customers_report_by_invoice_response.dart';
import '../../data/model/crm_reports/dto/response/customers_report_response.dart';


class CrmPrintingHelper {

  void crmEvents(m.BuildContext context, List<EventDTO> data , String? galleryName, DateTime? dateTo, DateTime? dateFrom) async {
    m.Size size = m.MediaQuery.of(context).size ;
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
            SizedBox(height: 30.5),
            Center(
                child:Text("تقرير شكاوي و اقترحات العملاء",
                    textAlign: TextAlign.center,
                    style: boldStyle
                )
            ),
            SizedBox(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text( galleryName!,
                        textAlign: TextAlign.center,
                        style: boldStyle
                    ),
                    SizedBox(width: 10),
                    Text( "المعرض",
                        textAlign: TextAlign.center,
                        style: boldStyle
                    ),

                  ]
              ),

            ),
            SizedBox(
              width: size.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text( dateFrom == null ? "" : intl.DateFormat("yyy-MM-dd").format(dateFrom),
                        textAlign: TextAlign.center,
                        style: boldStyle
                    ),
                    SizedBox(width: 10),
                    Text( "من تاريخ",
                        textAlign: TextAlign.center,
                        style: boldStyle
                    ),

                  ]
              ),
            ),
            SizedBox(
              width: size.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Text( dateTo == null ? "" : intl.DateFormat("yyy-MM-dd").format(dateTo),
                        textAlign: TextAlign.center,
                        style: boldStyle
                    ),
                    SizedBox(width: 10),
                    Text( "الي تاريخ",
                        textAlign: TextAlign.center,
                        style: boldStyle
                    ),

                  ]
              ),
            ),

            SizedBox(height: 10),
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("نوع الشكوي",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("اولوية الشكوي",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("حالة الشكوي",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("اسم المتابع",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("رقم الفاتورة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text("اسم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
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
                        child: Text("رقم الشكوي",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ]),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            data[i].crmType ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 45,
                      child: Center(
                          child: Text(
                            data[i].periority ?? "" ,
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            data[i].status ??"",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].assignedTo ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].invoiceId?.toString() ??"",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].customerId?.toString() ?? "",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].date == null ? "" : intl.DateFormat("yyy-MM-dd").format(data[i].date!),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].serial?.toString() ?? "",
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


  void crmCustomers(m.BuildContext context, List<CustomersReportResponse> data) async {
    m.Size size = m.MediaQuery.of(context).size ;
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
            SizedBox(height: 30.5),
            Center(
                child:Text("تقرير العملاء",
                    textAlign: TextAlign.center,
                    style: boldStyle
                )
            ),
            // SizedBox(
            //   width: size.width,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Text( galleryName!,
            //             textAlign: TextAlign.center,
            //             style: boldStyle
            //         ),
            //         SizedBox(width: 10),
            //         Text( "المعرض",
            //             textAlign: TextAlign.center,
            //             style: boldStyle
            //         ),
            //
            //       ]
            //   ),
            //
            // ),
            // SizedBox(
            //   width: size.width,
            //   child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Text( dateFrom == null ? "" : intl.DateFormat("yyy-MM-dd").format(dateFrom),
            //             textAlign: TextAlign.center,
            //             style: boldStyle
            //         ),
            //         SizedBox(width: 10),
            //         Text( "من تاريخ",
            //             textAlign: TextAlign.center,
            //             style: boldStyle
            //         ),
            //
            //       ]
            //   ),
            // ),
            // SizedBox(
            //   width: size.width,
            //   child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //
            //       children: [
            //         Text( dateTo == null ? "" : intl.DateFormat("yyy-MM-dd").format(dateTo),
            //             textAlign: TextAlign.center,
            //             style: boldStyle
            //         ),
            //         SizedBox(width: 10),
            //         Text( "الي تاريخ",
            //             textAlign: TextAlign.center,
            //             style: boldStyle
            //         ),
            //
            //       ]
            //   ),
            // ),

            SizedBox(height: 10),
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("حالة العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text("رقم الهاتف",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("كود العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("اسم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ]),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(
                    children: [
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            data[i].black == 1 ? "محظور" : "غير محظور",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            data[i].clientMobile ?? "" ,
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            data[i].clientCode ??"",
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].clientName ?? "",
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


  void crmCustomersReportByInvoice(m.BuildContext context, List<CustomersReportByInvoiceResponse> data) async {
    m.Size size = m.MediaQuery.of(context).size ;
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
            SizedBox(height: 30.5),
            Center(
                child:Text("تقرير العملاء حسب الفواتير",
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
                        child: Text("هاتف العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text("اسم العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("كود العميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("عدد الثياب",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("قيمة الفاتورة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("تاريخ الفاتورة",
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
                TableRow(
                    children: [
                      Container(
                          width: 55,
                          child: Center(
                              child: Text(
                                data[i].customerMobile ?? "",
                                style: boldStyle,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ))),
                      Container(
                          width: 60,
                          child: Center(
                              child: Text(
                                data[i].customerName ?? "" ,
                                style: boldStyle,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ))),
                      Container(
                          width: 60,
                          child: Center(
                              child: Text(
                                data[i].customerCode ??"",
                                style: boldStyle,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ))),
                      Container(
                          width: 40,
                          child: Center(
                              child: Text(
                                data[i].thobeNumber?.toString() ?? "",
                                style: boldStyle,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ))),
                      Container(
                          width: 40,
                          child: Center(
                              child: Text(
                                data[i].invoiceValue?.toString() ?? "",
                                style: boldStyle,
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ))),
                      Container(
                          width: 40,
                          child: Center(
                              child: Text(
                                data[i].invoiceDate != null ? intl.DateFormat("yyyy/MM/dd").format(data[i].invoiceDate!) : "",
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

}