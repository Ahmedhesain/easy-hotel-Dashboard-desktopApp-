import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:path_provider/path_provider.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/account_statement_response.dart';
import 'package:toby_bills/app/data/model/general_journal/dto/response/account_summary_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_status_response.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/balance_galary_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/balance_galary_unpaid_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_items_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_totals_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/client_no_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_sales_value_added_details_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_sales_value_added_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_statement_of_bonds_by_branch_report_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/inv_item_dto_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_statement_by_case_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoices_without_sewing_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/item_balances_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/journal_document_dialy_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/production_stages_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/sales_of_items_by_company_response.dart';

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
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i), report.balance);
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


  static Future<Excel> subAccountStatements(List<AccountSummaryResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "الرصيد");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "دائن");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "مدين");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "بيان القيد");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "نوع اليومية");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "رقم السند");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "رقم القيد");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "التاريخ");
    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.balance);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.creditAmount);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.debitAmount);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.glAccountName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.symbolName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.generalDecument);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.serial);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.date?.toIso8601String());
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

  static Future<Excel> invoicesQueryExcel(List<InvoiceModel> reports, BuildContext context) async {
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
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0), "عدد الثوب");
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

  static Future<Excel> SalesItemsByCompanyExcel(List<SalesOfItemsByCompanyResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "المعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "الكود");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "اسم الشركه");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "اجمالي المبيعات");

    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.gallaryName);

      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.companyCode);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.companyName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.totalSales);

    }
    List<int>? x = excel.save(fileName: "المبيعات حسب الشركات لفتره.xlsx");
    await saveFile("المبيعات حسب الشركات لفتره.xlsx", x!, context);
    return excel;
  }

  static Future<Excel> ProfitSoldExcel(List<ProfitOfItemsSoldResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "الكود");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "الاسم");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "متوسط التكلفه");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "كميه المبيعات");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "عددالمبيعات");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "الخصم الكلي");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "اجمالي سعر البيع");


    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.code);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.name);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.costAverage);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.totallNet);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.totallNumber);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.totallDiscount);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.totallSell);


    }
    List<int>? x = excel.save(fileName: "مبيعات الاصناف.xlsx");
    await saveFile("مبيعات الاصناف.xlsx", x!, context);
    return excel;
  }

  static Future<Excel> ItemsBalanceExcel(List<ItemsBalanceResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "رقم الصنف");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "اسم الصنف");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "سعر البيع");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "متوسط التكلفه");


    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.name);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.code);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.sallary);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.costAverage);


    }
    List<int>? x = excel.save(fileName: "رصيد الاصناف.xlsx");
    await saveFile("رصيد الاصناف.xlsx", x!, context);
    return excel;
  }

  static Future<Excel> InvoicesWithoutSweingExcel(List<CompanyInvoicesWithoutSewingResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "رقم الفاتوره");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "اسم المعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "الاسم");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "الكود");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "الاجمالي");



    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.id);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.galleryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.name);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.code);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.total);



    }
    List<int>? x = excel.save(fileName: "فواتير الشركات بدون خياطه .xlsx");
    await saveFile("فواتير الشركات بدون خياطه.xlsx", x!, context);
    return excel;
  }

  static Future<Excel> CustomersNoMovementExcel(List<ClientsNoMovementResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "رقم العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "اسم العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "الهاتف");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "تاريخ اخر فاتوره");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "الاجمالي");



    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.clientNumber);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.clientName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.phoneNumber);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.lastInvoiceDate);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.totalInvoices);



    }
    List<int>? x = excel.save(fileName: "عملاء ليس عليهم حركه.xlsx");
    await saveFile("عملاء ليس عليهم حركه.xlsx", x!, context);
    return excel;
  }

  static Future<Excel> CustomersBalanceExcel(List<FindCustomersBalanceResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "رقم العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "اسم العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "الرصيد الافتتاحي");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "المدين");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "الدائن");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "الرصيد");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "الفواتير");




    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.clientCode);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.clientName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.openningBalance);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.creditor);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.debit);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.balance);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.organizationsiteId);




    }
    List<int>? x = excel.save(fileName: "ارصده العملاء.xlsx");
    await saveFile("ارصده العملاء.xlsx", x!, context);
    return excel;
  }

  static Future<Excel> StatementOfBondsByBranchExcel(List<FindStatementOfBondsByBranchReportResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "الفرع");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "كود الفرع");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "النوع");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "نوع السداد");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "المبلغ");





    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.galleryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.galleryCode);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.type);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.paymentType);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.totalAmount);




    }
    List<int>? x = excel.save(fileName: "بيان بالسندات الصادره حسب الفرع .xlsx");
    await saveFile("بيان بالسندات الصادره حسب الفرع .xlsx", x!, context);
    return excel;
  }


  static Future<Excel> SalesValueAddedDetailsExcel(List<FindSalesValueAddedDetailsResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "رقم الفاتوره");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "نوع الفاتوره");

    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "التاريخ");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "اسم المعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "الموظف");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "الاجمالي قبل الضريبه");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "الاجمالي بعد الضريبه");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "الضريبه");




    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.invoiceNumber);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.invoiceType);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.invoiceDate);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.galleryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.employeeName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.totalBeforeTax);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report..totalAfterTax);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.tax);




    }
    List<int>? x = excel.save(fileName: "بيان بالسندات الصادره حسب الضريبه تفصيلي.xlsx");
    await saveFile("بيان بالسندات الصادره حسب الضريبه تفصيلي.xlsx", x!, context);
    return excel;
  }

  static Future<Excel> SalesValueAddedExcel(List<FindSalesValueAddedResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "اسم المعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "الاجمالي قبل الضريبه");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "الاجمالي بعد الضريبه");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "الضريبه");




    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.galleryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.totalBeforeTax);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report..totalAfterTax);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.tax);




    }
    List<int>? x = excel.save(fileName: "بيان بالسندات الصادره حسب الضريبه .xlsx");
    await saveFile("بيان بالسندات الصادره حسب الضريبه .xlsx", x!, context);
    return excel;
  }

  static Future<Excel> BalanceGallaryExcel(List<BalanceGalaryResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "اسم المعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "النوع");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "اسم البنك");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "القيمه");




    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.gallaryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.transactionType);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.bankName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.value);




    }
    List<int>? x = excel.save(fileName: "تقرير العمولات .xlsx");
    await saveFile("تقرير العمولات .xlsx", x!, context);
    return excel;
  }

  static Future<Excel> BalanceGallaryUnpaidExcel(List<BalanceGalaryUnpaidResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "المعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "القيمه");




    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.gallaryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.value);




    }
    List<int>? x = excel.save(fileName: "تقرير المبالغ الغير مسدده .xlsx");
    await saveFile("تقرير المبالغ الغير مسدده .xlsx", x!, context);
    return excel;
  }

  static Future<Excel> BalanceGallarypaidExcel(List<BalanceGalaryUnpaidResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "المعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "القيمه");




    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.gallaryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.value);




    }
    List<int>? x = excel.save(fileName: "تقرير المبالغ  المسدده .xlsx");
    await saveFile("تقرير المبالغ المسدده .xlsx", x!, context);
    return excel;
  }

  static Future<Excel>InvtemExcel(List<InvItemDtoResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "رقم الصنف");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "اسم الصنف");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), " التكلفه");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "اعلي سعر للرجال");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "اعلي سعر للشباب");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "اقل سعر للرجال");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "اقل سعر للشباب");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "عدد الامتار المجانيه للرجال");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0), "عدد الامتار المجانيه للشباب");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0), "عدد الامتار للرجال");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0), "عدد الامتار للشباب");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0), "طبيعه الصنف");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0), "المتاح");





    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.code);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.name);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.sellPrice);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.maxpricemen);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.maxpriceyoung);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.minpricemen);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.minpriceyoung);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.numbermetersfreemen);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i), report.numbermetersfreeyoung);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i), report.numbermetersmen);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i), report.numbermetersyoung);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i), report.itemNatural);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i), report.quantity);





    }
    List<int>? x = excel.save(fileName: "تقرير المبالغ  المسدده .xlsx");
    await saveFile("تقرير المبالغ المسدده .xlsx", x!, context);
    return excel;
  }

  static Future<Excel> JournalDocument(List<JournalDocumentDialyResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "بيان القيد");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "مدخل القيد");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "وزن القيد");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "مراجعه الفاتوره");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "التاريخ");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "رقم السند");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "رقم القيد");




    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.generalStatement);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), "");
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), "");
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i),"");
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), DateFormat("yyyy-MM-dd").format(report.generalDate!));
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.generalNumber);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.serial);




    }
    List<int>? x = excel.save(fileName: "قيد اليوميه تفصيلي.xlsx");
    await saveFile("قيد اليوميه تفصيلي.xlsx", x!, context);
    return excel;
  }

  static Future<Excel>InvoiceMovementExcel(List<InvoiceMovementResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "الفاتوره");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "الفرع");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), " اسم العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "عدد الثياب بالفاتوره");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "تاريخ التسليم بالمشغل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "عدد الثياب بالمشغل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "تاريخ التسليم للطيار");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "عدد الثياب للطيار");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0), "تاريخ التسليم بالمعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0), "عدد الثياب بالمعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0), "تاريخ التسليم للعميل");




    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.invoiceSerial);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.inventoryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.clientName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.numberTobInvoice);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), DateFormat("yyyy-MM-dd").format(report.factoryDate!));
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.numberTobInvoice);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i),report.deliveryDate==null?"": DateFormat("yyyy-MM-dd").format(report.deliveryDate!));
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.numberTobExitFactory);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), "");
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i), report.numberTobgallary);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i), "");





    }
    List<int>? x = excel.save(fileName: "تقرير حركه  الثياب .xlsx");
    await saveFile("تقرير حركه الثياب .xlsx", x!, context);
    return excel;
  }

  static Future<Excel>SalesForPeriodExcel(List<CategoriesItemsResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "المعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "رقم");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), " التاريخ");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "رقم العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "قيمه الفاتوره");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "صافي الفاتوره");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "الباقي");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0), "المسدد");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0), "الحاله");




    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.galleryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.serial);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), DateFormat("yyyy-MM-dd").format(report.invoiceDate!));
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.code);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.name);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.totalAfterTax);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i),report.totalBeforeTax);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.paid);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.remain);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i), "");





    }
    List<int>? x = excel.save(fileName: "تقرير المبيعات لفتره .xlsx");
    await saveFile("تقرير المبيعات لفتره.xlsx", x!, context);
    return excel;
  }

  static Future<Excel>CategoriesItemsExcel(List<CategoriesItemsResponse> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "المعرض");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "رقم");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), " التاريخ");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "رقم العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "العميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "رقم الفاتوره");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "صافي الفاتوره");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "الباقي");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0), "المسدد");




    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.galleryName);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.serial);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), DateFormat("yyyy-MM-dd").format(report.invoiceDate!));
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.code);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.name);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.invoiceId);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i),report.totalNet);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.paid);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.remain);





    }
    List<int>? x = excel.save(fileName: "الفواتير المسدده لفتره سابقه .xlsx");
    await saveFile("الفواتير المسدده لفتره سابقه.xlsx", x!, context);
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
  static Future<Excel> fashExcel(List<InvoiceDetailsModel> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "البند");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "العدد");
    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), "${report.name} ${report.code}");
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.quantity);
    }
    List<int>? x = excel.save(fileName: "تفاصيل الفسح.xlsx");
    await saveFile("تفاصيل الفسح.xlsx", x!, context);
    return excel;
  }

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
