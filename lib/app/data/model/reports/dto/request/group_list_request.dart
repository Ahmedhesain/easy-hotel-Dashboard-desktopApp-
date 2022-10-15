class GroupListRequest {
  GroupListRequest({
    this.id,
    this.branchId,
  });

  int? id;
  int? branchId;

  Map<String, dynamic> toJson() => {
    "id": id,
    "branchId": branchId,
  };
}
