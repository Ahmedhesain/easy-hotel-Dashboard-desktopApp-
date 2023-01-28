


class AddOfferResponse {
  final String? msg ;

  AddOfferResponse(this.msg);

  factory AddOfferResponse.fromJson(Map<String , dynamic> json) => AddOfferResponse(json['msg']);
}