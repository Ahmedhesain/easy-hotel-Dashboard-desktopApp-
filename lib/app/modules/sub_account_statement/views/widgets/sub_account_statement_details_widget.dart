import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toby_bills/app/components/colors.dart';
import 'package:toby_bills/app/data/model/general_journal/dto/response/account_summary_response.dart';
import 'package:toby_bills/app/modules/sub_account_statement/controllers/sub_account_statement_controller.dart';

class SubAccountStatementDetailsWidget extends GetView<SubAccountStatementController> {
  const SubAccountStatementDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          foregroundDecoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.grey),
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              Table(
                children: [
                  const TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('التاريخ', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('رقم القيد', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('رقم السند', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('نوع اليومية', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('بيان القيد', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('مدين', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('دائن', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('الرصيد', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                      ),
                    ],
                    decoration: BoxDecoration(color: appGreyDark, border: Border(bottom: BorderSide())),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(() {
                    return Table(
                      // border: TableBorder.all(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey, style: BorderStyle.solid, width: 1),
                      children: [
                        for (AccountSummaryResponse row in controller.statements)
                          TableRow(
                            children: [
                              SizedBox(height: 40, child: Center(child: Text(row.date == null ? "--" : DateFormat("dd-MM-yyyy").format(row.date!)))),
                              SizedBox(height: 40, child: Center(child: Text(row.serial ?? "--"))),
                              SizedBox(height: 40, child: Center(child: Text(row.generalDecument?.toString() ?? "--"))),
                              SizedBox(height: 40, child: Center(child: Text(row.symbolName ?? "--"))),
                              SizedBox(height: 40, child: Center(child: Text(row.glAccountName ?? "--"))),
                              SizedBox(height: 40, child: Center(child: Text(row.debitAmount?.toString() ?? "--"))),
                              SizedBox(height: 40, child: Center(child: Text(row.creditAmount?.toString() ?? "--"))),
                              SizedBox(height: 40, child: Center(child: Text(row.balance?.toString() ?? "--"))),
                            ],
                            decoration: const BoxDecoration(color: appGreyLight, border: Border(bottom: BorderSide())),
                          )
                      ],
                    );
                  }),
                ),
              ),
              Obx(() {
                return Table(
                  children: [
                    TableRow(
                      children: [
                        const SizedBox(),
                        const SizedBox(),
                        const SizedBox(),
                        const SizedBox(),
                        const SizedBox(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.statements.fold<num>(0, (p, e) => p + (e.debitAmount ?? 0)).toStringAsFixed(2), style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(controller.statements.fold<num>(0, (p, e) => p + (e.creditAmount ?? 0)).toStringAsFixed(2), style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ),
                        const SizedBox(),
                      ],
                      decoration: const BoxDecoration(color: appGreyDark, border: Border(bottom: BorderSide())),
                    ),
                  ],
                );
              }),
            ],
          )),
    );
  }
}
