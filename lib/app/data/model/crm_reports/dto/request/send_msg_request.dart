


class SendMsgRequest {

  final int? gallaryId ;
  final String? customerPhone ;
  final String? msg ;

  SendMsgRequest({this.gallaryId, this.customerPhone, this.msg});

  Map<String , dynamic> toJson() => {
    "gallaryId" : gallaryId,
    "customerPhone" : customerPhone,
    "msg" : msg,
  };
}