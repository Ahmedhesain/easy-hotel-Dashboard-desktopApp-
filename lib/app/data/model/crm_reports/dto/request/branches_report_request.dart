


import 'package:toby_bills/app/data/model/reports/dto/request/categories_totals_request.dart';

class BranchesReportRequest {
  final int? invoiceStatus;
  final int? gallaryFrom;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? dayNumbers;
  final int? branchId;
  final List<SymbolDtoapiList>? selectedGroups;



  BranchesReportRequest(
      {this.invoiceStatus,
      this.gallaryFrom,
      this.fromDate,
      this.toDate,
      this.dayNumbers,
      this.branchId,
        this.selectedGroups,
      });

  Map<String,dynamic> toJson () => {
    "invoiceStatus" : invoiceStatus,
    "gallaryFrom" : gallaryFrom,
    "fromDate" : fromDate?.toIso8601String(),
    "toDate" : toDate?.toIso8601String(),
    "dayNumbers" : dayNumbers,
    "branchId" : branchId,
    "selectedGroups" :List<dynamic>.from(selectedGroups!.map((e) => e.toJson()))
  };
}