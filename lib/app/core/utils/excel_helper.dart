import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:path_provider/path_provider.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/account_statement_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_status_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_totals_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_statement_by_case_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/production_stages_response.dart';

class ExcelHelper {

  static Future<Excel> salesReportsExcel(List<CategoriesTotalsResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "الكود");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "الفئة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "العدد");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "سعر البيع");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "التكلفة");
    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.code);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.name);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.number);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.allCost);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.allAvarageCost);
    }
    List<int>? x = excel.save(fileName: "اجمالي الفئات.xlsx");
    await saveFile("اجمالي الفئات.xlsx", x!, context);
    return excel;
  }

  static Future<Excel> movementSalesReportsExcel(List<InvoiceStatusResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "#");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "الفاتورة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "الفرع");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "اسم العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "عدد الثياب بالفاتورة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "تاريخ التسليم المشغل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "عدد الثياب بالمشغل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "تاريخ التسليم للطيار");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0), "عدد الثياب للطيار");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0), "تاريخ الاستعلام بالمعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0), "عدد الثياب بالمعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0), "تاريخ التسليم للعميل");
    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.id);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.invoiceSerial);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.inventoryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.clientName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.numberTobInvoice);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.factoryDate?.toIso8601String());
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.numberToFactory);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.deliveryDate?.toIso8601String());
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i), report.numberTobExitFactory);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i), report.galaryDate?.toIso8601String());
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i), report.numberTobgallary);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i), report.clientDate?.toIso8601String());
    }
    List<int>? x = excel.save(fileName: "حالة الفاتورة.xlsx");
    await saveFile("حالة الفاتورة.xlsx", x!, context);
    return excel;
  }

  static Future<Excel> statementsExcel(List<AccountStatementResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "رقم الفاتورة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "التاريخ");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "عميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "نوع الحركة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "رقم فاتورة المبيعات");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "الخزينة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "مدين");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "دائن");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0), "الرصيد");
    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.serial);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.date?.toIso8601String());
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.organizationName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.screenName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.invoiceSerial);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.openningBalance);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.adding);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.exitt);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i), report.remarks);
    }
    List<int>? x = excel.save(fileName: "كشف حساب.xlsx");
    await saveFile("كشف حساب.xlsx", x!, context);
    return excel;
  }

  static Future<Excel> productionStagesExcel(List<ProductionStagesResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "الموظف");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "المرحلة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "الكمية");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "اسم الصنف");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "التاريخ");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "#");
    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.empName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.stage);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.quantity);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.productName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.date?.toIso8601String());
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.number);
    }
    List<int>? x = excel.save(fileName: "مراحل الانتاج.xlsx");
    await saveFile("مراحل الانتاج.xlsx", x!, context);
    return excel;
  }

  // static Future<Excel> treasuryStatementExcel(List<BankStatement> reports, BuildContext context) async {
  //   var excel = Excel.createExcel();
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "التاريخ");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0),"رقم");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "نوع الحركة");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "رقم الفاتورة");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "كود العميل");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "اسم العميل");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "مناولة");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "البيان");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0), "مدين");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0), "رصيد");
  //   for (var i = 1; i <= reports.length; i++) {
  //     final report = reports[i - 1];
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.date?.toIso8601String());
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.createdBy);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.transactionType);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.invoiceNumber);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.customerCode);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.customerName);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.remark2);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.remark);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i), report.debitAmount);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i), report.balance);
  //   }
  //   List<int>? x = excel.save(fileName: "كشف خزينة.xlsx");
  //   await saveFile("كشف خزينة.xlsx", x!, context);
  //   return excel;
  // }

  static Future<Excel> galleryInvoicesExcel(List<InvoiceStatementByCaseResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "رقم الفاتورة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "رقم امر الشغل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "التاريخ");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "كود");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "الهاتف");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "الحالة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "المرحلة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0), "الاستلام");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0), "المتبقي");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0), "شركات");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "عدد الثوب");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0), "مدخل الفاتورة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: 0), "ملاحظات");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: 0), "check");
    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.serialTax);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.serial);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.date?.toIso8601String());
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.customerCode);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.customerName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.customerMobile);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.status);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.invoiceLastStatus);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i), report.dueDate?.toIso8601String());
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i), report.remain);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i), report.customerNotice);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i), report.numberOfToob);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i), report.createdByName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i), report.remarks);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: i), "");
    }
    List<int>? x = excel.save(fileName: "فواتير المعرض.xlsx");
    await saveFile("فواتير المعرض.xlsx", x!, context);
    return excel;
  }

  // static Future<Excel> invoicesByStatusExcel(List<InvoiceModel> reports, BuildContext context) async {
  //   var excel = Excel.createExcel();
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "#");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "الفاتورة");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "الملاحظات");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "الفرع");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "تاريخ الفاتورة");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "كود العميل");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "اسم العميل");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "رقم العميل");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0), "تاريخ الاستحقاق");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0), "عدد الايام المتبقية");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0), "عدد الثوب");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0), "اخر مرحلة");
  //   for (var i = 1; i <= reports.length; i++) {
  //     final report = reports[i - 1];
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), i);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.serial);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.remarks);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.gallaryName);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.date?.toIso8601String());
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.customerCode);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.customerName);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.customerMobile);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i), report.dueDate?.toIso8601String());
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i), report.remainDueDayesNumber);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i), report.numberOfToob);
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i), report.invoiceLastStatus);
  //   }
  //   List<int>? x = excel.save(fileName: "فواتير المعرض.xlsx");
  //   await saveFile("فواتير المعرض.xlsx", x!, context);
  //   return excel;
  // }
  //
  // static Future<Excel> fashExcel(List<InvoiceDetailsModel> reports, BuildContext context) async {
  //   var excel = Excel.createExcel();
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "البند");
  //   excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "العدد");
  //   for (var i = 1; i <= reports.length; i++) {
  //     final report = reports[i - 1];
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), "${report.name} ${report.code}");
  //     excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.quantity);
  //   }
  //   List<int>? x = excel.save(fileName: "تفاصيل الفسح.xlsx");
  //   await saveFile("تفاصيل الفسح.xlsx", x!, context);
  //   return excel;
  // }

  static saveFile(String fullName, List<int> bytes, BuildContext context) async {
    final directory = await getApplicationDocumentsDirectory();
    List<String> name = fullName.split(".");
    final path = "${directory.path}\\Topy\\${name.first}_${DateFormat("yyyy-MM-dd-HH-mm-ss").format(DateTime.now())}.${name.last}";
    File file = File(path);
    await file.create(recursive: true);
    await file.writeAsBytes(bytes);
    if(await file.exists()){
      showPopupText(text: "تم التصدير الى المسار \n${file.path}",type: MsgType.success);
    } else {
      showPopupText(text: "عذراً حصل خطأ");
    }
  }

}
