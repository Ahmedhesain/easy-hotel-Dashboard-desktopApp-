class FindNotificationRequest{
  final int branchId;
  final int typeNotice;
  final int serial;

  FindNotificationRequest({required this.branchId,required this.typeNotice,required this.serial});

  Map<String,dynamic> toJson(){
    return {
      "branchId":branchId,
      "typeNotice":typeNotice,
      "serial":serial,
    };
  }

}