class DeliveryPlaceResposne {
  DeliveryPlaceResposne({
    required this.type,
    required this.markEdit,
    required this.name,
    required this.branchId,
    required this.companyId,
    required this.createdBy,
    required this.createdDate,
    required this.id,
    required this.index,
    required this.code,
    required this.costAccount,
    required this.costCenterId,
    required this.daribaValue,
    required this.invName,
    required this.invType,
    required this.runningAccount,
    required this.segilValue,
    required this.sellerName,
    required this.accountId,
    required this.customerAccount,
    required this.phone,
  });

  final String type;
  final bool markEdit;
  final String name;
  final int? branchId;
  final int? companyId;
  final int? createdBy;
  final DateTime? createdDate;
  final int? id;
  final int? index;
  final String? code;
  final AccountId? costAccount;
  final AccountId? costCenterId;
  final String? daribaValue;
  final int? invName;
  final int? invType;
  final AccountId? runningAccount;
  final String? segilValue;
  final String? sellerName;
  final AccountId? accountId;
  final AccountId? customerAccount;
  final String? phone;

  static List<DeliveryPlaceResposne> getList(List<dynamic> json) => List<DeliveryPlaceResposne>.from(json.map((x) => DeliveryPlaceResposne.fromJson(x)));

  factory DeliveryPlaceResposne.fromJson(Map<String, dynamic> json) => DeliveryPlaceResposne(
    type: json["type"],
    markEdit: json["markEdit"],
    name: json["name"],
    branchId: json["branchId"],
    companyId: json["companyId"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    id: json["id"],
    index: json["index"],
    code: json["code"],
    costAccount: json["costAccount"] == null ? null : AccountId.fromJson(json["costAccount"]),
    costCenterId: json["costCenterId"] == null ? null : AccountId.fromJson(json["costCenterId"]),
    daribaValue: json["daribaValue"],
    invName: json["invName"],
    invType: json["invType"],
    runningAccount: json["runningAccount"] == null ? null : AccountId.fromJson(json["runningAccount"]),
    segilValue: json["segilValue"],
    sellerName: json["sellerName"],
    accountId: json["accountId"] == null?null:AccountId.fromJson(json["accountId"]),
    customerAccount: json["customerAccount"] == null?null:AccountId.fromJson(json["customerAccount"]),
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "markEdit": markEdit,
    "name": name,
    "branchId": branchId,
    "companyId": companyId,
    "createdBy": createdBy,
    "createdDate": createdDate?.toIso8601String(),
    "id": id,
    "index": index,
    "code": code,
    "costAccount": costAccount?.toJson(),
    "costCenterId": costCenterId?.toJson(),
    "daribaValue": daribaValue,
    "invName": invName,
    "invType": invType,
    "runningAccount": runningAccount?.toJson(),
    "segilValue": segilValue,
    "sellerName": sellerName,
    "accountId": accountId?.toJson(),
    "customerAccount": customerAccount?.toJson(),
    "phone": phone,
  };
}

class AccountId {
  AccountId({
    required this.id,
    required this.markEdit,
    required this.accNumber,
    required this.name,
    required this.status,
  });

  final int id;
  final bool markEdit;
  final int? accNumber;
  final String name;
  final bool? status;

  factory AccountId.fromJson(Map<String, dynamic> json) => AccountId(
    id: json["id"],
    markEdit: json["markEdit"],
    accNumber: json["accNumber"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "markEdit": markEdit,
    "accNumber": accNumber,
    "name": name,
    "status": status,
  };
}

