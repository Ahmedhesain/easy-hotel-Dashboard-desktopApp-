import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';

class EditBillsRequest {
  EditBillsRequest({
    required this.serial,
    required this.branchId,
    required this.dateFrom,
    required this.dateTo,


  });
  final int serial;
  final int branchId;
  final DateTime dateFrom;
  final DateTime dateTo;



  Map<String, dynamic> toJson(){
    return {

      "serial": serial,
      "branchId": branchId,
      "dateFrom": dateFrom.toIso8601String(),
      "dateTo": dateTo.toIso8601String(),
    };
  }

}
