import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';

class SafeAccountStatementRequest {
  SafeAccountStatementRequest({
    required this.glYearSelected,
    required this.glBankDTOListSelected,
    required this.branchId,
    required this.dateFrom,
    required this.dateTo,
    required this.invoiceType,
    required this.dataType,

  });
  final  Map<String, int> glYearSelected;
  final List<GlPayDTO> glBankDTOListSelected;
  final int branchId;
  final DateTime dateFrom;
  final DateTime dateTo;
  final int invoiceType;
  final int dataType;


  Map<String, dynamic> toJson(){
    return {
      "glYearSelected" : {"id": 73},
      "glBankDTOListSelected" :glBankDTOListSelected.map((e) => {"id" : e.bankId}).toList(),
      "branchId": branchId,
      "dateFrom": dateFrom.toIso8601String(),
      "dateTo": dateTo.toIso8601String(),
      "invoiceType": invoiceType,
      "dataType": dataType,
    };
  }

}
