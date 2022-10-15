class CategoriesTotalsRequest {
  CategoriesTotalsRequest({
    this.gallaryId,
    this.branchId,
    this.dateFrom,
    this.tobAndKhiata,
    this.dateTo,
    this.invoiceType,
    this.symbolDtoapiList,
  });

  int? gallaryId;
  int? branchId;
  DateTime? dateFrom;
  int? tobAndKhiata;
  DateTime? dateTo;
  List<SymbolDtoapiList>? symbolDtoapiList;
  int? invoiceType;

  Map<String, dynamic> toJson() => {
    "gallaryId": gallaryId,
    "branchId": branchId,
    "dateFrom": dateFrom?.toIso8601String(),
    "tobAndKhiata": tobAndKhiata,
    "dateTo": dateTo?.toIso8601String(),
    "symbolDTOAPIList": List<dynamic>.from((symbolDtoapiList??[]).map((x) => x.toJson())),
    "invoiceType": invoiceType,
  };
}

class SymbolDtoapiList {

  SymbolDtoapiList(this.id);
  final int id;

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
