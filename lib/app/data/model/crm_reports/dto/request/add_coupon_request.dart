


import '../../../customer/dto/response/find_customer_response.dart';

class AddCouponRequest {

  final String code ;
  final DateTime? startDate;
  final DateTime?  endDate;
  final int discountType;
  final int createdBy;
  final int branchId;
  final int companyId;
  final double discountValue;
  final FindCustomerResponse? customerId;

  const AddCouponRequest({required this.createdBy ,required this.companyId ,required this.branchId , required this.code, this.startDate, this.endDate,required this.discountType,required this.discountValue, this.customerId});


  Map<String , dynamic> toJson() => {
    "code" : code ,
    "startDate" :  startDate?.toIso8601String() ,
    "endDate" :endDate?.toIso8601String() ,
    "discountType" : discountType ,
    "discountValue" : discountValue ,
    "customerId" : customerId?.toJson() ,
    "createdBy" : createdBy ,
    "branchId" : branchId ,
    "companyId" : companyId ,
  };
}