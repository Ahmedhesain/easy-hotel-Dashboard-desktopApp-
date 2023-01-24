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

import '../../data/model/crm_reports/dto/response/crm_event_dto.dart';
import '../../data/model/reports/dto/response/safe_account_statement_response.dart';

class CRMExcelHelper {


  static Future<Excel> eventsExcel(List<EventDTO> reports, BuildContext context) async {
    var excel = Excel.createExcel();
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0), "رقم الشكوي");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0), "التاريخ");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0), "عميل");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0), "رقم الفاتورة");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0), "اسم المتابع");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0), "حالة الشكوي");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0), "اولوية الشكوي");
    excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0), "نوع الشكوي");
    for (var i = 1; i <= reports.length; i++) {
      final report = reports[i - 1];
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i), report.serial);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i), report.date?.toIso8601String());
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i), report.customerId);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i), report.invoiceId);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i), report.assignedTo);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i), report.status);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i), report.periority);
      excel.updateCell(excel.sheets.values.first.sheetName, CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i), report.crmType);
    }
    List<int>? x = excel.save(fileName: "شكاوي و اقتراحات العملاء.xlsx");
    await saveFile("شكاوي و اقتراحات العملاء.xlsx", x!, context);
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
