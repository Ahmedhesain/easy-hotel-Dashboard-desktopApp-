import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';

class CategoriesTotalsRequest {
  CategoriesTotalsRequest({
    this.gallaryList,
    this.branchId,
    this.dateFrom,
    this.tobAndKhiata,
    this.dateTo,
    this.invoiceType,
    this.symbolDtoapiList,
  });

  List<DtoList>? gallaryList;
  int? branchId;
  DateTime? dateFrom;
  int? tobAndKhiata;
  DateTime? dateTo;
  List<SymbolDtoapiList>? symbolDtoapiList;
  int? invoiceType;

  Map<String, dynamic> toJson() => {
    "branchId": branchId,
    "dateFrom": dateFrom?.toIso8601String(),
    "tobAndKhiata": tobAndKhiata,
    "dateTo": dateTo?.toIso8601String(),
    "symbolDTOAPIList": List<dynamic>.from((symbolDtoapiList??[]).map((x) => x.toJson())),
    "gallaryList": List<dynamic>.from((gallaryList??[]).map((x) => x.toJson())),
    "invoiceType": invoiceType,
  };
}

class SymbolDtoapiList {

  SymbolDtoapiList(this.id);
   int id;

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
