class SendFcmRequest {
  SendFcmRequest({
    this.invoiceId,
    this.title,
    this.body,
  });

  num? invoiceId;
  String? title;
  String? body;

  Map<String, dynamic> toJson() => {
    "to": "/topics/notifications",
    "notification":{
      "body":body,
      "title":title
    },
    "data":{
      if(invoiceId != null)
        "invoiceId": invoiceId
    }
  };

}
