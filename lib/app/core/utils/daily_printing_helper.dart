import 'package:flutter/material.dart' as m;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import '../../data/model/gallery_expenses/dto/GalleryExpensesDTO.dart';
import '../../data/model/reports/dto/response/safe_account_statement_response.dart';

class DailyPrintingHelper {
  final PdfColor grey = PdfColors.grey400;

  void dailyReport({
    required m.BuildContext context,
    DateTime? date,
    required List<TreasuryModel> treasuries,
    double? totalTreasuries,
    required List<GalleryExpensesDTO> expenses,
    double? totalExpenses,
    double? totalTreasuriesPreviousDay,
    double? actualNet,
    double? transfers,
    double? netBank,
    double? tamara,
  }) async {
    m.Size size = m.MediaQuery.of(context).size;
    final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
    final fontLight = await rootBundle.load("assets/fonts/Cairo-Light.ttf");
    final ttfBold = Font.ttf(font);
    final boldStyle = TextStyle(font: ttfBold, fontSize: 11, fontBold: ttfBold);
    final doc = Document();
    doc.addPage(MultiPage(
        pageTheme: const PageTheme(
            pageFormat: PdfPageFormat.a4,
            textDirection: TextDirection.rtl,
            margin: EdgeInsets.all(10)),
        build: (Context context) {
          return [
            SizedBox(height: 30.5),
            Center(
                child: Text("برنس للخياطة الرجالية",
                    textAlign: TextAlign.center, style: boldStyle)),
            Center(
                child: Text("حركة يومية الصندوق",
                    textAlign: TextAlign.center, style: boldStyle)),
            Center(
                child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(style: boldStyle, children: [
                      TextSpan(text: 'بتاريخ', style: boldStyle),
                      TextSpan(
                          text: date == null
                              ? ""
                              : intl.DateFormat("yyyy/MM/dd").format(date),
                          style: boldStyle),
                    ]))),
            SizedBox(height: 10),
            Table(
                border: TableBorder.all(width: 1),
                tableWidth: TableWidth.max,
                children: [
                  headRowDaily(
                      style: boldStyle,
                      value: "منصرف",
                      index: "م",
                      docs: "سندات",
                      statement: "بيان"),
                  for (int i = 0; i < treasuries.length; i++)
                    detailRowDaily(
                        style: boldStyle,
                        index: (i + 1).toString(),
                        statement: treasuries[i].bankName,
                        value: treasuries[i]
                                .statements
                                .first
                                .totalDebit
                                ?.toString() ??
                            ""),
                  headRowDaily(
                      style: boldStyle,
                      value: totalTreasuries?.toString() ?? "",
                      index: "",
                      docs: "",
                      statement: "الاجمالي"),
                  for (int i = 0; i < expenses.length; i++)
                    detailRowDaily(
                        style: boldStyle,
                        index: (i + 1).toString(),
                        statement: expenses[i].remarks,
                        value: expenses[i].value?.toString() ?? ""),
                  headRowDaily(
                      style: boldStyle,
                      value: totalExpenses?.toString() ?? "",
                      statement: "الاجمالي"),
                  headRowDaily(
                      style: boldStyle,
                      value: totalTreasuriesPreviousDay?.toString() ?? "",
                      statement: "رصيد الصندوق باليوم السابق"),
                  headRowDaily(
                      style: boldStyle,
                      value: totalTreasuries?.toString() ?? "",
                      statement: "يضاف ايرادات اليوم الحالي"),
                  headRowDaily(
                      style: boldStyle,
                      value: totalExpenses?.toString() ?? "",
                      statement: "يخصم اجمالي المصروفات"),
                  headRowDaily(
                      style: boldStyle,
                      value: actualNet?.toString() ?? "",
                      statement: "الرصيد الفعلي"),
                  headRowDaily(style: boldStyle, statement: "ايداع البنك"),
                  headRowDaily(
                      style: boldStyle,
                      value: transfers?.toString() ?? "",
                      statement: "حوالات البنك"),
                  headRowDaily(
                      style: boldStyle,
                      value: netBank?.toString() ?? "",
                      statement: "ايداع الشبكة"),
                  headRowDaily(
                      style: boldStyle,
                      value: tamara?.toString() ?? "",
                      statement: "اجمالي فواتير تمارا"),
                  headRowDaily(
                      style: boldStyle, statement: "رصيد اليوم التالي"),
                ]),
            SizedBox(height: 50),
            SizedBox(
                child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
              Container(
                  width: 100,
                  child: Center(
                      child: Text("امين الصندوق",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center))),
              Container(
                  width: 100,
                  child: Center(
                      child: Text("مدير الفرع",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center))),
                  Container(
                  width: 100,
                  child: Center(
                      child: Text("المحاسب",
                          style: boldStyle.copyWith(fontSize: 10),
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center))),
            ]))
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

  TableRow headRowDaily(
          {required TextStyle style,
          String? index,
          String? statement,
          String? value,
          String? docs}) =>
      TableRow(children: [
        Container(
            color: grey,
            width: 20,
            child: Center(
                child: Text(index ?? "",
                    style: style.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center))),
        Container(
            color: grey,
            width: 100,
            child: Center(
                child: Text(statement ?? "",
                    style: style.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center))),
        Container(
            color: grey,
            width: 60,
            child: Center(
                child: Text(value ?? "",
                    style: style.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center))),
        Container(
            color: grey,
            width: 40,
            child: Center(
                child: Text(docs ?? "",
                    style: style.copyWith(fontSize: 10),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center))),
      ]);

  TableRow detailRowDaily(
          {required TextStyle style,
          String? index,
          String? statement,
          String? value,
          String? docs}) =>
      TableRow(children: [
        Container(
            width: 20,
            child: Center(
                child: Text(
              index ?? "",
              style: style,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ))),
        Container(
            width: 100,
            child: Center(
                child: Text(
              statement ?? "",
              style: style,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ))),
        Container(
            width: 60,
            child: Center(
                child: Text(
              value ?? "",
              style: style,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ))),
        Container(
            width: 40,
            child: Center(
                child: Text(
              docs ?? "",
              style: style,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ))),
      ]);
}
