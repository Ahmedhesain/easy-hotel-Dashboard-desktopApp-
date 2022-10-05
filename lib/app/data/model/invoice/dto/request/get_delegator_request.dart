class DelegatorRequest {
  DelegatorRequest({this.gallaryId});

  int? gallaryId;

  Map<String, dynamic> toJson() => {"gallaryId": gallaryId};
}
