

class SendMsgResponse {
  final String msg ;

  SendMsgResponse({required this.msg});


  factory SendMsgResponse.fromJson(Map<String , dynamic> json) => SendMsgResponse(
    msg : json["msg"]
  );
}