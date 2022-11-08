class DeleteNotificationRequest{
  final int id;

  DeleteNotificationRequest(this.id);

  Map<String, dynamic> toJson(){
    return {
      "id": id
    };
  }
}