class DeletePaymentRequest{
  final int id;

  DeletePaymentRequest({required this.id});

  Map<String, dynamic> toJson(){
    return {
      "id": id
    };
  }
}