import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/account_statement_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_status_response.dart';

import '../../data/model/reports/dto/response/categories_totals_response.dart';

class PrintingHelper {

  // void printInvoice(m.BuildContext context, InvoiceModel invoiceModel, {num? value, num? dariba, num? total, num? discount, num? net, num? payed, num? remain}) async {
  //   // LoginData? user = context.read<AuthProvider>().user ;
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
  //       pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl),
  //       build: (Context context) {
  //         return [
  //
  //           SizedBox(height: 50.5),
  //           SizedBox(
  //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //                 Padding(
  //                   padding: EdgeInsets.all(2),
  //                   child: Text(
  //                     invoiceModel.serial.toString(),
  //                     style: boldStyle,
  //                     textDirection: TextDirection.rtl,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(2),
  //                   child: Text(
  //                     "فاتورة ضريبيه مبسطة",
  //                     style: boldStyle,
  //                     textDirection: TextDirection.rtl,
  //                   ),
  //                 )
  //               ])),
  //
  //           SizedBox(height: 20.5),
  //           SizedBox(
  //               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                 //customer data and date
  //                 SizedBox(
  //                     width: 120,
  //                     child: Column(children: [
  //                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                         Text(
  //                           DateFormat("dd/MM/yyyy hh:mm aa").format(invoiceModel.date!),
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                         Text(
  //                           "التاريخ",
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ]),
  //                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                         Text(
  //                           invoiceModel.customerName.toString(),
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                         Text(
  //                           "العميل",
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ]),
  //                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                         Text(
  //                           invoiceModel.customerCode.toString(),
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ]),
  //                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                         Text(
  //                           invoiceModel.customerMobile.toString(),
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ]),
  //                     ])),
  //                 //barcode widget
  //                 SizedBox(
  //                     width: 130,
  //                     height: 50,
  //                     child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center, children: [
  //                       Container(
  //                           width: 80,
  //                           height: 25,
  //                           child: BarcodeWidget(
  //                             height: 25,
  //                             width: 80,
  //                             color: PdfColor.fromHex("#000000"),
  //                             barcode: Barcode.fromType(BarcodeType.Codabar),
  //                             drawText: false,
  //                             data: invoiceModel.serial.toString(),
  //                           ))
  //                     ])),
  //                 // seller data
  //                 SizedBox(
  //                     width: 180,
  //                     child: Column(children: [
  //                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                         Text(
  //                           invoiceModel.daribaValue.toString(),
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                         Spacer(),
  //                         Text(
  //                           "الرقم الضريبي",
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ]),
  //                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                         Text(
  //                           invoiceModel.segilValue.toString(),
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                         Spacer(),
  //                         Text(
  //                           "رقم السجل",
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ]),
  //                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                         Text(
  //                           invoiceModel.gallaryName.toString(),
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                         Spacer(),
  //                         Text(
  //                           "المعرض",
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ]),
  //                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                         Text(
  //                           DateFormat("dd/MM/yyyy").format(invoiceModel.dueDate!),
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                         Spacer(),
  //                         Text(
  //                           "تاريخ التسليم",
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ]),
  //                     ])),
  //               ])),
  //           SizedBox(height: 15),
  //           // m.LayoutBuilder(
  //           //   builder: (context, c){
  //           //     return Text(c?.maxWidth.toString()??"");
  //           //   }
  //           // ),
  //           //table headers
  //           Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
  //             TableRow(children: [
  //               Container(
  //                   color: grey,
  //                   width: 55,
  //                   child: Center(
  //                       child: Text(
  //                         "القيمة",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ))),
  //               Container(
  //                   color: grey,
  //                   width: 45,
  //                   child: Center(
  //                       child: Text(
  //                         "الخصم",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ))),
  //               Container(
  //                   color: grey,
  //                   width: 55,
  //                   child: Center(
  //                       child: Text(
  //                         "السعر",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ))),
  //               Container(
  //                   color: grey,
  //                   width: 60,
  //                   child: Center(
  //                       child: Text(
  //                         "مستودع",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ))),
  //               Container(
  //                   color: grey,
  //                   width: 40,
  //                   child: Center(
  //                       child: Text(
  //                         "كمية",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ))),
  //               Container(
  //                   color: grey,
  //                   width: 40,
  //                   child: Center(
  //                       child: Text(
  //                         "العدد",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ))),
  //               Container(
  //                   color: grey,
  //                   width: 50,
  //                   child: Center(
  //                       child: Text(
  //                         "الوحدة",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ))),
  //               Container(
  //                   color: grey,
  //                   width: 160,
  //                   child: Center(
  //                       child: Text(
  //                         "اسم الصنف",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ))),
  //               Container(
  //                   color: grey,
  //                   width: 70,
  //                   child: Center(
  //                       child: Text(
  //                         "رقم الصنف",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ))),
  //               Container(
  //                   color: grey,
  //                   width: 30,
  //                   child: Center(
  //                       child: Text(
  //                         "م",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ))),
  //             ]),
  //             //table content
  //             for (int i = 0; i < invoiceModel.invoiceDetailApiList!.length; i++)
  //               TableRow(children: [
  //                 Container(
  //                     width: 55,
  //                     child: Center(
  //                         child: Text(
  //                           (invoiceModel.invoiceDetailApiList![i].net ?? 0).toStringAsFixed(2),
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 45,
  //                     child: Center(
  //                         child: Text(
  //                           (invoiceModel.invoiceDetailApiList![i].discount ?? 0).toStringAsFixed(2),
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 55,
  //                     child: Center(
  //                         child: Text(
  //                           (invoiceModel.invoiceDetailApiList![i].price ?? 0).toStringAsFixed(2),
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 60,
  //                     child: Center(
  //                         child: Text(
  //                           invoiceModel.invoiceDetailApiList![i].inventoryCode.toString(),
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 40,
  //                     child: Center(
  //                         child: Text(
  //                           invoiceModel.invoiceDetailApiList![i].quantity?.toStringAsFixed(2) ?? '',
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 40,
  //                     child: Center(
  //                         child: Text(
  //                           invoiceModel.invoiceDetailApiList![i].number.toString(),
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 50,
  //                     child: Center(
  //                         child: Text(
  //                           invoiceModel.invoiceDetailApiList![i].unitName.toString(),
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 160,
  //                     child: Center(
  //                         child: Text(
  //                           invoiceModel.invoiceDetailApiList![i].name.toString(),
  //                           style: boldStyle2,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 70,
  //                     child: Center(
  //                         child: Text(
  //                           invoiceModel.invoiceDetailApiList![i].code.toString(),
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 30,
  //                     child: Center(
  //                         child: Text(
  //                           "${i + 1}",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //               ]),
  //           ]),
  //           SizedBox(height: 5),
  //           SizedBox(
  //               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
  //                 SizedBox(
  //                     width: 120,
  //                     child: Table(tableWidth: TableWidth.max, border: TableBorder.all(width: 0.5), children: [
  //                       TableRow(children: [
  //                         SizedBox(
  //                             width: 30,
  //                             child: Center(
  //                                 child: Text(
  //                                   value!.toStringAsFixed(2),
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                         SizedBox(
  //                             width: 30,
  //                             child: Center(
  //                                 child: Text(
  //                                   "القيمه",
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                       ]),
  //                       TableRow(children: [
  //                         SizedBox(
  //                             width: 30,
  //                             child: Center(
  //                                 child: Text(
  //                                   dariba!.toStringAsFixed(2),
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                         SizedBox(
  //                             width: 30,
  //                             child: Center(
  //                                 child: Text(
  //                                   "الضريبة",
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                       ]),
  //                       TableRow(children: [
  //                         SizedBox(
  //                             width: 30,
  //                             child: Center(
  //                                 child: Text(
  //                                   total!.toStringAsFixed(2),
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                         SizedBox(
  //                             width: 30,
  //                             child: Center(
  //                                 child: Text(
  //                                   "الاجمالي",
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                       ]),
  //                       TableRow(children: [
  //                         SizedBox(
  //                             width: 30,
  //                             child: Center(
  //                                 child: Text(
  //                                   discount!.toStringAsFixed(2),
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                         SizedBox(
  //                             width: 30,
  //                             child: Center(
  //                                 child: Text(
  //                                   "الخصم",
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                       ]),
  //                       TableRow(children: [
  //                         SizedBox(
  //                             width: 30,
  //                             child: Center(
  //                                 child: Text(
  //                                   net!.toStringAsFixed(2),
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                         SizedBox(
  //                             width: 30,
  //                             child: Center(
  //                                 child: Text(
  //                                   "الصافي",
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                       ]),
  //                     ])),
  //                 SizedBox(
  //                     width: 145,
  //                     child: Table(tableWidth: TableWidth.max, border: TableBorder.all(width: 0.5), children: [
  //                       TableRow(children: [
  //                         SizedBox(
  //                             width: 60,
  //                             child: Center(
  //                                 child: Text(
  //                                   payed!.toStringAsFixed(2),
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                         SizedBox(
  //                             width: 80,
  //                             child: Center(
  //                                 child: Text(
  //                                   "المبلغ المدفوع",
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                       ]),
  //                       TableRow(children: [
  //                         SizedBox(
  //                             width: 60,
  //                             child: Center(
  //                                 child: Text(
  //                                   remain!.toStringAsFixed(2),
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                         SizedBox(
  //                             width: 80,
  //                             child: Center(
  //                                 child: Text(
  //                                   "المبلغ المتبقي",
  //                                   style: boldStyle,
  //                                   textDirection: TextDirection.rtl,
  //                                 ))),
  //                       ]),
  //                     ])),
  //                 SizedBox(
  //                     width: 120,
  //                     child: Container(
  //                         width: 80,
  //                         height: 80,
  //                         child: BarcodeWidget(
  //                           color: PdfColor.fromHex("#000000"),
  //                           barcode: Barcode.fromType(BarcodeType.QrCode),
  //                           drawText: false,
  //                           data: invoiceModel.qrCode.toString(),
  //                         )))
  //               ]))
  //         ];
  //       }));
  //
  //   m.showDialog(
  //       context: context,
  //       builder: (context) {
  //         return m.LayoutBuilder(builder: (context, c) {
  //           return PdfPreview(
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
  //           );
  //         });
  //       });
  // }

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
            Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
              TableRow(children: [
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("رقم الفاتورة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 45,
                    child: Center(
                        child: Text("التاريخ",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 55,
                    child: Center(
                        child: Text("عميل",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 60,
                    child: Center(
                        child: Text("نوع الحركة",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
                Container(
                    color: grey,
                    width: 40,
                    child: Center(
                        child: Text("رقم فاتورة المبيعات",
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
                        child: Text("مدين",
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
                        child: Text("الرصيد",
                            style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
              ]),
              //table content
              for (int i = 0; i < data.length; i++)
                TableRow(children: [
                  Container(
                      width: 55,
                      child: Center(
                          child: Text(
                            data[i].serial.toString(),
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
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
                            data[i].organizationName,
                            style: boldStyle,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ))),
                  Container(
                      width: 60,
                      child: Center(
                          child: Text(
                            data[i].screenName,
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
                      width: 40,
                      child: Center(
                          child: Text(
                            data[i].openningBalance.toStringAsFixed(2),
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
                            data[i].remarks ?? "",
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
  //
  // void products(m.BuildContext context, List<Product> data, InvoiceModel invoiceModel) async {
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
  //       pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, margin: EdgeInsets.all(10)),
  //       build: (Context context) {
  //         return [
  //           SizedBox(height: 50),
  //           SizedBox(
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.all(2),
  //                   child: Text(
  //                     invoiceModel.serial.toString(),
  //                     style: boldStyle,
  //                     textDirection: TextDirection.rtl,
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(2),
  //                   child: Text(
  //                     "مراحل الانتاج لفاتورة ذات رقم",
  //                     style: boldStyle,
  //                     textDirection: TextDirection.rtl,
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 20.5),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               //customer data and date
  //               SizedBox(
  //                 width: 200,
  //                 child: Column(
  //                   children: [
  //                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                       Text(
  //                         invoiceModel.customerName ?? "",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ),
  //                       Spacer(),
  //                       Text(
  //                         "اسم العميل",
  //                         style: boldStyle,
  //                         textDirection: TextDirection.rtl,
  //                       ),
  //                     ],),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           invoiceModel.customerCode ?? "",
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                         Spacer(),
  //                         Text(
  //                           "كود العميل",
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               // seller data
  //               SizedBox(
  //                 width: 180,
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           invoiceModel.date == null ? "" : DateFormat("dd/MM/yyyy").format(invoiceModel.date!),
  //                           style: boldStyle.copyWith(fontSize: 10),
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                         Spacer(),
  //                         Text(
  //                           "تاريخ الفاتورة",
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ],
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           invoiceModel.dueDate == null ? "" : DateFormat("dd/MM/yyyy").format(invoiceModel.dueDate!),
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                         Spacer(),
  //                         Text(
  //                           "تاريخ التسليم",
  //                           style: boldStyle,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ),
  //           SizedBox(height: 15),
  //           SizedBox(height: 50.5),
  //           Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
  //             TableRow(children: [
  //               Container(
  //                   color: grey,
  //                   width: 45,
  //                   child: Center(
  //                       child: Text("الموظف",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   width: 45,
  //                   child: Center(
  //                       child: Text("المرحلة",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   width: 55,
  //                   child: Center(
  //                       child: Text("الكمية",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   width: 60,
  //                   child: Center(
  //                       child: Text("اسم الصنف",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   width: 40,
  //                   child: Center(
  //                       child: Text("التاريخ",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   width: 40,
  //                   child: Center(
  //                       child:
  //                       Text("#", style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //             ]),
  //             //table content
  //             for (int i = 0; i < data.length; i++)
  //               TableRow(children: [
  //                 Container(
  //                     width: 55,
  //                     child: Center(
  //                         child: Text(
  //                           data[i].empName ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 45,
  //                     child: Center(
  //                         child: Text(
  //                           data[i].stage ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 55,
  //                     child: Center(
  //                         child: Text(
  //                           data[i].quantity?.toStringAsFixed(2) ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 60,
  //                     child: Center(
  //                         child: Text(
  //                           data[i].productName ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 40,
  //                     child: Center(
  //                         child: Text(
  //                           data[i].date == null ? "" : DateFormat("MM-dd-yyyy").format(data[i].date!),
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 40,
  //                     child: Center(
  //                         child: Text(
  //                           data[i].number?.toStringAsFixed(2) ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //               ]),
  //           ]),
  //           SizedBox(height: 5),
  //         ];
  //       }));
  //
  //   m.showDialog(
  //       context: context,
  //       builder: (context) {
  //         return PdfPreview(
  //           actions: [
  //             m.IconButton(
  //               onPressed: () => m.Navigator.pop(context),
  //               icon: const m.Icon(
  //                 m.Icons.close,
  //                 color: m.Colors.red,
  //               ),
  //             )
  //           ],
  //           build: (format) => doc.save(),
  //         );
  //       });
  // }
  //
  // void treasuryStatement(m.BuildContext context, List<TreasuryModel> data, DateTime fromDate, DateTime toDate) async {
  //   final doc = Document();
  //   const PdfColor grey = PdfColors.grey400;
  //   final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
  //   final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  //   final ttfBold = Font.ttf(font);
  //   final ttfLight = Font.ttf(fontLight);
  //   final style = TextStyle(font: ttfLight, fontBold: ttfBold);
  //   final normalStyle = TextStyle(font: ttfLight, fontSize: 11);
  //   final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
  //   final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
  //   Text text(String text, {double? size, FontWeight? weight}) => Text(text, style: style.copyWith(fontSize: size, fontWeight: weight));
  //
  //   for (var i = 0; i < data.length; i++) {
  //     final bank = data[i];
  //     doc.addPage(MultiPage(
  //         pageTheme: const PageTheme(
  //           pageFormat: PdfPageFormat.a4,
  //           textDirection: TextDirection.rtl,
  //           margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
  //           orientation: PageOrientation.landscape,
  //         ),
  //         build: (Context context) {
  //           return [
  //             if (data.indexOf(bank) == 0)
  //               Column(
  //                 children: [
  //                   Center(
  //                       child: Container(
  //                           decoration: const BoxDecoration(color: PdfColors.grey400),
  //                           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
  //                           child: Text(
  //                             "كشف حساب خزينة - بنك",
  //                             style: boldStyle.copyWith(fontSize: 10),
  //                             textDirection: TextDirection.rtl,
  //                             textAlign: TextAlign.center,
  //                           ))),
  //                   SizedBox(height: 15),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       text(DateFormat("MM-dd-yyyy").format(fromDate), weight: FontWeight.bold),
  //                       SizedBox(width: 15),
  //                       text("من تاريخ:", weight: FontWeight.bold),
  //                       SizedBox(width: 15),
  //                     ],
  //                   ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       text(DateFormat("MM-dd-yyyy").format(toDate), weight: FontWeight.bold),
  //                       SizedBox(width: 15),
  //                       text("الى تاريخ:", weight: FontWeight.bold),
  //                       SizedBox(width: 15),
  //                     ],
  //                   ),
  //                   SizedBox(height: 15),
  //                 ],
  //               ),
  //             Container(
  //               foregroundDecoration: BoxDecoration(border: Border.all()),
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     flex: 12,
  //                     child: text(bank.bankName ?? "", size: 10),
  //                   ),
  //                   Expanded(
  //                     flex: 3,
  //                     child: Container(
  //                         decoration: const BoxDecoration(
  //                           color: PdfColors.grey400,
  //                           border: Border(left: BorderSide()),
  //                         ),
  //                         margin: const EdgeInsets.only(left: 15),
  //                         alignment: Alignment.center,
  //                         child: text("اسم البنك", weight: FontWeight.bold)),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Container(
  //                     decoration: BoxDecoration(border: Border.all(), color: grey),
  //                     child: Center(
  //                       child: Text(
  //                         "الرصيد",
  //                         style: boldStyle.copyWith(fontSize: 10),
  //                         textDirection: TextDirection.rtl,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     decoration: BoxDecoration(border: Border.all(), color: grey),
  //                     child: Center(
  //                       child: Text(
  //                         "مدين",
  //                         style: boldStyle.copyWith(fontSize: 10),
  //                         textDirection: TextDirection.rtl,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     decoration: BoxDecoration(border: Border.all(), color: grey),
  //                     child: Center(
  //                       child: Text(
  //                         "البيان",
  //                         style: boldStyle.copyWith(fontSize: 10),
  //                         textDirection: TextDirection.rtl,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Container(
  //                     decoration: BoxDecoration(border: Border.all(), color: grey),
  //                     child: Center(
  //                       child: Text(
  //                         "مناولة",
  //                         style: boldStyle.copyWith(fontSize: 10),
  //                         textDirection: TextDirection.rtl,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   flex: 2,
  //                   child: Container(
  //                     decoration: BoxDecoration(border: Border.all(), color: grey),
  //                     child: Center(
  //                       child: Text(
  //                         "اسم العميل",
  //                         style: boldStyle.copyWith(fontSize: 10),
  //                         textDirection: TextDirection.rtl,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                     child: Container(
  //                   decoration: BoxDecoration(border: Border.all(), color: grey),
  //                   child: Center(
  //                     child: Text(
  //                       "كود العميل",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 )),
  //                 Expanded(
  //                     child: Container(
  //                   decoration: BoxDecoration(border: Border.all(), color: grey),
  //                   child: Center(
  //                     child: Text(
  //                       "رقم الفاتورة",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 )),
  //                 Expanded(
  //                     child: Container(
  //                   decoration: BoxDecoration(border: Border.all(), color: grey),
  //                   child: Center(
  //                     child: Text(
  //                       "نوع الحركة",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 )),
  //                 Expanded(
  //                     child: Container(
  //                   decoration: BoxDecoration(border: Border.all(), color: grey),
  //                   child: Center(
  //                     child: Text(
  //                       "رقم",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 )),
  //                 Expanded(
  //                     child: Container(
  //                   decoration: BoxDecoration(border: Border.all(), color: grey),
  //                   child: Center(
  //                     child: Text(
  //                       "التاريخ",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 )),
  //               ],
  //             ),
  //             for (final statement in bank.statements)
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(border: Border.all()),
  //                         height: 40,
  //                         child: Center(
  //                           child: Text(
  //                             statement.balance?.toStringAsFixed(2) ?? " ",
  //                             style: normalStyle,
  //                             textAlign: TextAlign.center,
  //                             textDirection: TextDirection.rtl,
  //                           ),
  //                         ),
  //                       )),
  //                   Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(border: Border.all()),
  //                         height: 40,
  //                         child: Center(
  //                           child: Text(
  //                             statement.debitAmount?.toStringAsFixed(2) ?? " ",
  //                             style: normalStyle,
  //                             textAlign: TextAlign.center,
  //                             textDirection: TextDirection.rtl,
  //                           ),
  //                         ),
  //                       )),
  //                   Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(border: Border.all()),
  //                         height: 40,
  //                         child: Center(
  //                           child: Text(
  //                             statement.remark ?? " ",
  //                             style: normalStyle,
  //                             textAlign: TextAlign.center,
  //                             textDirection: TextDirection.rtl,
  //                           ),
  //                         ),
  //                       )),
  //                   Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(border: Border.all()),
  //                         height: 40,
  //                         child: Center(
  //                           child: Text(
  //                             statement.remark2 ?? " ",
  //                             style: normalStyle,
  //                             textAlign: TextAlign.center,
  //                             textDirection: TextDirection.rtl,
  //                           ),
  //                         ),
  //                       )),
  //                   Expanded(
  //                     flex: 2,
  //                     child: Container(
  //                       decoration: BoxDecoration(border: Border.all()),
  //                       height: 40,
  //                       child: Center(
  //                         child: Text(
  //                           statement.customerName ?? " ",
  //                           style: normalStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(border: Border.all()),
  //                         height: 40,
  //                         child: Center(
  //                           child: Text(
  //                             statement.customerCode ?? " ",
  //                             style: normalStyle,
  //                             textAlign: TextAlign.center,
  //                             textDirection: TextDirection.rtl,
  //                           ),
  //                         ),
  //                       )),
  //                   Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(border: Border.all()),
  //                         height: 40,
  //                         child: Center(
  //                           child: Text(
  //                             statement.invoiceNumber?.toString() ?? "",
  //                             style: normalStyle,
  //                             textAlign: TextAlign.center,
  //                             textDirection: TextDirection.rtl,
  //                           ),
  //                         ),
  //                       )),
  //                   Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(border: Border.all()),
  //                         height: 40,
  //                         child: Center(
  //                           child: Text(
  //                             statement.transactionType ?? " ",
  //                             style: normalStyle,
  //                             textAlign: TextAlign.center,
  //                             textDirection: TextDirection.rtl,
  //                           ),
  //                         ),
  //                       )),
  //                   Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(border: Border.all()),
  //                         height: 40,
  //                         child: Center(
  //                           child: Text(
  //                             statement.serial?.toString() ?? " ",
  //                             style: normalStyle,
  //                             textAlign: TextAlign.center,
  //                             textDirection: TextDirection.rtl,
  //                           ),
  //                         ),
  //                       )),
  //                   Expanded(
  //                       child: Container(
  //                         decoration: BoxDecoration(border: Border.all()),
  //                         height: 40,
  //                         child: Center(
  //                           child: Text(
  //                             statement.date == null ? "" : DateFormat("MM-dd-yyyy").format(statement.date!),
  //                             style: normalStyle,
  //                             textAlign: TextAlign.center,
  //                             textDirection: TextDirection.rtl,
  //                           ),
  //                         ),
  //                       )),
  //                 ],
  //               ),
  //             Container(
  //               foregroundDecoration: BoxDecoration(border: Border.all()),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   Spacer(flex: 1),
  //                   Expanded(
  //                     child: Container(
  //                       decoration: const BoxDecoration(
  //                         border: Border(left: BorderSide(width: 1.1)),
  //                       ),
  //                       child: text(
  //                         bank.statements.first.totalDebit?.toStringAsFixed(2) ?? "",
  //                       ),
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 9,
  //                     child: Container(
  //                       decoration: const BoxDecoration(
  //                         color: PdfColors.grey400,
  //                         border: Border(left: BorderSide()),
  //                       ),
  //                       padding: const EdgeInsets.only(right: 15),
  //                       child: text("الاجمالي", weight: FontWeight.bold),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ];
  //         }));
  //   }
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
  // void invoicesByStatus(m.BuildContext context, List<InvoiceModel> data) async {
  //   final doc = Document();
  //   const PdfColor grey = PdfColors.grey400;
  //   final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
  //   final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  //   final ttfBold = Font.ttf(font);
  //   final ttfLight = Font.ttf(fontLight);
  //   final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
  //   final boldStyle = TextStyle(font: ttfBold, fontSize: 10, fontBold: ttfBold);
  //   final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
  //   final widths = {
  //     0:const FlexColumnWidth(1),
  //     1:const FlexColumnWidth(1),
  //     2:const FlexColumnWidth(1),
  //     3:const FlexColumnWidth(1),
  //     4:const FlexColumnWidth(2),
  //     5:const FlexColumnWidth(2),
  //     6:const FlexColumnWidth(1),
  //     7:const FlexColumnWidth(1),
  //     8:const FlexColumnWidth(2),
  //     9:const FlexColumnWidth(2),
  //     10:const FlexColumnWidth(1),
  //     11:const FlexColumnWidth(1),
  //   };
  //
  //   doc.addPage(MultiPage(
  //       pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, orientation: PageOrientation.landscape, margin: EdgeInsets.all(10)),
  //       build: (Context context) {
  //         return [
  //           SizedBox(height: 50.5),
  //           Table(border: TableBorder.all(width: 1),columnWidths: widths, tableWidth: TableWidth.max, children: [
  //             TableRow(decoration: BoxDecoration(color: grey),children: [
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("اخر مرحلة",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("عدد الثواب",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("عدد الايام المتبقية",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("تاريخ الاستحقاق",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("رقم العميل",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("اسم العميل",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("كود العميل",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("تاريخ الفاتورة",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child:
  //                       Text("الفرع", style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("الملاحظات",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("الفاتورة",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   child: Center(
  //                       child: Text("#",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //             ],),
  //             //table content
  //             for (int i = 0; i < data.length; i++)
  //               TableRow(children: [
  //                 Center(
  //                     child: Text(
  //                       data[i].invoiceLastStatus ?? "",
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       data[i].numberOfToob?.toString() ?? "",
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       data[i].remainDueDayesNumber?.toString() ?? "",
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       data[i].dueDate == null ? "" : DateFormat("MM-dd-yyyy").format(data[i].dueDate!),
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       data[i].customerMobile ?? "",
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       data[i].customerName ?? "",
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       data[i].customerCode ?? "",
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       data[i].date == null ?"":DateFormat("MM/dd/yyyy").format(data[i].date!),
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       data[i].gallaryName ?? "",
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       data[i].remarks??'',
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       data[i].serial?.toStringAsFixed(2) ?? "",
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //                 Center(
  //                     child: Text(
  //                       "${i+1}",
  //                       style: normalStyle,
  //                       textAlign: TextAlign.center,
  //                       textDirection: TextDirection.rtl,
  //                     )),
  //
  //               ]),
  //           ]),
  //           SizedBox(height: 5),
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
  // void fash(m.BuildContext context, List<InvoiceDetailsModel> data, InvoiceModel invoiceModel) async {
  //   final doc = Document();
  //   const PdfColor grey = PdfColors.grey400;
  //   final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
  //   final ttfBold = Font.ttf(font);
  //   final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
  //   doc.addPage(MultiPage(
  //       pageTheme: const PageTheme(pageFormat: PdfPageFormat.a4, textDirection: TextDirection.rtl, margin: EdgeInsets.all(10)),
  //       build: (Context context) {
  //         return [
  //           SizedBox(height: 50),
  //           SizedBox(
  //               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
  //             Padding(
  //               padding: EdgeInsets.all(2),
  //               child: Text(
  //                 invoiceModel.serial.toString(),
  //                 style: boldStyle,
  //                 textDirection: TextDirection.rtl,
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(2),
  //               child: Text(
  //                 "تفاصيل الفسح لفاتورة برقم",
  //                 style: boldStyle,
  //                 textDirection: TextDirection.rtl,
  //               ),
  //             )
  //           ])),
  //           SizedBox(height: 20.5),
  //           SizedBox(
  //               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //             //customer data and date
  //             SizedBox(
  //                 width: 200,
  //                 child: Column(children: [
  //                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                     Text(
  //                       DateFormat("dd/MM/yyyy hh:mm aa").format(invoiceModel.supplierDate!),
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                     Spacer(),
  //                     Text(
  //                       "تاريخ فاتورة العميل",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                   ]),
  //                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                     Text(
  //                       invoiceModel.customerName ?? "",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                     Spacer(),
  //                     Text(
  //                       "العميل",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                   ]),
  //                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                     Text(
  //                       invoiceModel.customerMobile ?? "",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                     Spacer(),
  //                     Text(
  //                       "رقم العميل",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                   ]),
  //                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                     Text(
  //                       invoiceModel.customerCode ?? "",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                     Spacer(),
  //                     Text(
  //                       "كود العميل",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                   ]),
  //                 ])),
  //             // seller data
  //             SizedBox(
  //                 width: 180,
  //                 child: Column(children: [
  //                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                     Text(
  //                       invoiceModel.invDelegatorId?.toString() ?? "",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                     Spacer(),
  //                     Text(
  //                       "رقم الفسح",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                   ]),
  //                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                     Text(
  //                       invoiceModel.date == null ? "" : DateFormat("dd/MM/yyyy").format(invoiceModel.date!),
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                     Spacer(),
  //                     Text(
  //                       "التاريخ",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                   ]),
  //                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //                     Text(
  //                       invoiceModel.remarks ?? "",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                     Spacer(),
  //                     Text(
  //                       "ملاحظات",
  //                       style: boldStyle,
  //                       textDirection: TextDirection.rtl,
  //                     ),
  //                   ]),
  //                 ])),
  //           ])),
  //           SizedBox(height: 15),
  //           SizedBox(height: 50.5),
  //           Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max, children: [
  //             TableRow(children: [
  //               Container(
  //                   color: grey,
  //                   width: 45,
  //                   child: Center(
  //                       child: Text("العدد",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //               Container(
  //                   color: grey,
  //                   width: 45,
  //                   child: Center(
  //                       child: Text("البند",
  //                           style: boldStyle.copyWith(fontSize: 10), textDirection: TextDirection.rtl, textAlign: TextAlign.center))),
  //             ]),
  //             //table content
  //             for (int i = 0; i < data.length; i++)
  //               TableRow(children: [
  //                 Container(
  //                     width: 45,
  //                     child: Center(
  //                         child: Text(
  //                           data[i].quantity?.toStringAsFixed(2) ?? "",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //                 Container(
  //                     width: 55,
  //                     child: Center(
  //                         child: Text(
  //                           "${data[i].name} ${data[i].code}",
  //                           style: boldStyle,
  //                           textAlign: TextAlign.center,
  //                           textDirection: TextDirection.rtl,
  //                         ))),
  //               ]),
  //           ]),
  //           SizedBox(height: 5),
  //         ];
  //       }));
  //
  //   m.showDialog(
  //       context: context,
  //       builder: (context) {
  //         return PdfPreview(
  //           actions: [
  //             m.IconButton(
  //               onPressed: () => m.Navigator.pop(context),
  //               icon: const m.Icon(
  //                 m.Icons.close,
  //                 color: m.Colors.red,
  //               ),
  //             )
  //           ],
  //           build: (format) => doc.save(),
  //         );
  //       });
  // }
  //
  // void itemSales(m.BuildContext context, List<PurchaseBySupplierGroup> data, DateTime fromDate, DateTime toDate) async {
  //   final doc = Document();
  //   const PdfColor grey = PdfColors.grey300;
  //   const PdfColor grey4 = PdfColors.grey400;
  //   final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
  //   final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  //   final ttfBold = Font.ttf(font);
  //   final ttfLight = Font.ttf(fontLight);
  //   final style = TextStyle(font: ttfLight, fontBold: ttfBold);
  //   final normalStyle = TextStyle(font: ttfLight, fontSize: 11);
  //   final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
  //   final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
  //   Text text(String text, {double? size, FontWeight? weight}) => Text(text, style: style.copyWith(fontSize: size, fontWeight: weight));
  //   final widths = <int, TableColumnWidth>{
  //     0: const FlexColumnWidth(1),
  //     1: const FlexColumnWidth(1),
  //     2: const FlexColumnWidth(1),
  //     3: const FlexColumnWidth(1),
  //     4: const FlexColumnWidth(1),
  //     5: const FlexColumnWidth(2),
  //     6: const FlexColumnWidth(1),
  //     7: const FlexColumnWidth(1),
  //     8: const FlexColumnWidth(1),
  //     9: const FlexColumnWidth(1),
  //     10: const  FlexColumnWidth(2),
  //   };
  //   doc.addPage(MultiPage(
  //       pageTheme: const PageTheme(
  //         pageFormat: PdfPageFormat.a4,
  //         textDirection: TextDirection.rtl,
  //         margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
  //         orientation: PageOrientation.landscape,
  //       ),
  //       build: (Context context) {
  //         return [
  //           Center(
  //               child: Container(
  //                   decoration: const BoxDecoration(color: PdfColors.grey400),
  //                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
  //                   child: Text(
  //                     "مبيعات الاصناف حسب العملاء",
  //                     style: boldStyle.copyWith(fontSize: 10),
  //                     textDirection: TextDirection.rtl,
  //                     textAlign: TextAlign.center,
  //                   ))),
  //           SizedBox(height: 15),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   text(DateFormat("MM-dd-yyyy").format(toDate), weight: FontWeight.bold),
  //                   SizedBox(width: 15),
  //                   text("الى الفترة:", weight: FontWeight.bold),
  //                   SizedBox(width: 15),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   text(DateFormat("MM-dd-yyyy").format(fromDate), weight: FontWeight.bold),
  //                   SizedBox(width: 15),
  //                   text("من الفترة:", weight: FontWeight.bold),
  //                   SizedBox(width: 15),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 15),
  //           Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max,columnWidths: widths, children: [
  //             TableRow(children: [
  //               Center(
  //                 child: Text(
  //                   "قيمة",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   "الخصم",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   "تكلفة الشراء",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   "الكمية",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   "الوحدة",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   "البيان",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   "رقم الصنف",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   "تاريخ الفاتورة",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   "رقم الشغل",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   "رقم الفاتورة",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               Center(
  //                 child: Text(
  //                   "اسم العميل",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ],decoration: const BoxDecoration(color: grey)),
  //           ]),
  //           for (final supplier in data)
  //             Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max,columnWidths: widths, children: [
  //               TableRow(children: [
  //                 Container(
  //                   color: grey4,
  //                   child: Center(
  //                     child: Text(
  //                       supplier.purchases.fold<num>(0, (p, e) => p+(e.cost??0)).toStringAsFixed(2),
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: grey4,
  //                   child: Center(
  //                     child: Text(
  //                       "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: grey4,
  //                   child: Center(
  //                     child: Text(
  //                       "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: grey4,
  //                   child: Center(
  //                     child: Text(
  //                       "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: grey4,
  //                   child: Center(
  //                     child: Text(
  //                       "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: grey4,
  //                   child: Center(
  //                     child: Text(
  //                       "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: grey4,
  //                   child: Center(
  //                     child: Text(
  //                       "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: grey4,
  //                   child: Center(
  //                     child: Text(
  //                       "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: grey4,
  //                   child: Center(
  //                     child: Text(
  //                       "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: grey4,
  //                   child: Center(
  //                     child: Text(
  //                       "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   color: grey4,
  //                   width: 100,
  //                   child: Center(
  //                     child: Text(
  //                       supplier.name,
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ),
  //               ],decoration: const BoxDecoration(color: grey4)),
  //               for (final purchase in supplier.purchases)
  //                 TableRow(children: [
  //                   Center(
  //                     child: Text(
  //                       purchase.cost?.toStringAsFixed(2)??"",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       purchase.discount?.toStringAsFixed(2) ?? "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       purchase.costAvarage?.toStringAsFixed(2) ?? "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       purchase.quantityOfOne?.toStringAsFixed(2) ?? "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       purchase.itemUnitName ?? "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       purchase.itemName ?? '',
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       purchase.itemCode ??'',
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       purchase.date == null?"null":DateFormat("MM/dd/yyyy").format(purchase.date!),
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       purchase.number.toString(),
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       purchase.serial.toString(),
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   Center(
  //                     child: Text(
  //                       "",
  //                       style: boldStyle.copyWith(fontSize: 10),
  //                       textDirection: TextDirection.rtl,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                 ]),
  //             ]),
  //
  //           Table(border: TableBorder.all(width: 1), tableWidth: TableWidth.max,columnWidths: widths, children: [
  //             TableRow(children: [
  //               Center(
  //                 child: Text(
  //                   data.fold<num>(0, (p, e) => p + (e.purchases.fold<num>(0, (p, e) => p + (e.cost ?? 0)))).toStringAsFixed(2),
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //               SizedBox(),
  //               SizedBox(),
  //               SizedBox(),
  //               SizedBox(),
  //               SizedBox(),
  //               SizedBox(),
  //               SizedBox(),
  //               SizedBox(),
  //               SizedBox(),
  //               Center(
  //                 child: Text(
  //                   "الاجمالي",
  //                   style: boldStyle.copyWith(fontSize: 10),
  //                   textDirection: TextDirection.rtl,
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ],decoration: const BoxDecoration(color: grey)),
  //           ]),
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
  // void printItemBarcode(m.BuildContext context, ItemsModel item) async {
  //   final doc = Document();
  //   final name = context.read<AuthProvider>().userModel?.data?.galleryType == 0 ? "برنس" : "لي رويال";
  //   final type = context.read<AuthProvider>().userModel?.data?.galleryType;
  //   num cost = (type == 1 ? ((item.maxPriceMen ?? 0) * 0.85) : item.maxPriceMen) ?? 0;
  //   cost += cost *0.15;
  //   num? costAfterDiscount;
  //   if (item.discountrate != null && item.discountrate! > 0 && item.discountValue != null) {
  //     costAfterDiscount = item.discountValue! + (item.discountValue! * 0.15);
  //   }
  //   const PdfColor grey = PdfColors.grey400;
  //   final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
  //   final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
  //   final ttfBold = Font.ttf(font);
  //   final ttfLight = Font.ttf(fontLight);
  //   final normalStyle = TextStyle(font: ttfLight, fontSize: 9);
  //   final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
  //   final boldStyle2 = TextStyle(font: ttfBold, fontSize: 9, fontBold: ttfBold);
  //   doc.addPage(Page(
  //       pageTheme: const PageTheme(pageFormat: PdfPageFormat(96, 70, marginAll: 1.0), textDirection: TextDirection.rtl),
  //       build: (Context context) {
  //         return Column(
  //           children: [
  //             Text(name, style: normalStyle, textAlign: TextAlign.center),
  //             BarcodeWidget(
  //               height: 10,
  //               width: 80,
  //               color: PdfColor.fromHex("#000000"),
  //               barcode: Barcode.fromType(BarcodeType.Codabar),
  //               drawText: false,
  //               data: item.code.toString(),
  //             ),
  //             Spacer(flex: 2),
  //             Text(item.name.toString(), style: boldStyle2),
  //             Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
  //               Column(children: [
  //                 Text("${cost?.toStringAsFixed(3)} SR",
  //                     style: TextStyle(fontSize: 9, decoration: costAfterDiscount != null ? TextDecoration.lineThrough : null)),
  //                 if (costAfterDiscount != null) Text("${costAfterDiscount.toStringAsFixed(3)} SR", style: TextStyle(fontSize: 9)),
  //               ]),
  //               Text(item.code.toString(), style: TextStyle(fontSize: 9)),
  //             ]),
  //             Spacer(),
  //           ],
  //         );
  //       }));
  //
  //   m.showDialog(
  //       context: context,
  //       builder: (context) {
  //         return m.LayoutBuilder(builder: (context, c) {
  //           return PdfPreview(
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
  //           );
  //         });
  //       });
  // }
}
