class DeleteInvoiceRequest{
  final int? id;

  DeleteInvoiceRequest(this.id);

  Map<String,dynamic> toJson(){
    return {
      "id": id
    };
  }
}