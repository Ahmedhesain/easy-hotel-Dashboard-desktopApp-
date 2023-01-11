

class CRMEventRequest {

 final int? assignedToId ;
 final int? crmTypeId ;
 final int? invoiceId ;
 final int? periorityId ;
 final String? subject ;
 final String? discription ;
 final String? msg ;
 final int? customer;
 final int? galleryId;
 final int? statusId;
 final int? branchId;
 final int? companyId;
 final int? createdBy;


 CRMEventRequest(
      {this.assignedToId,
      this.crmTypeId,
      this.invoiceId,
      this.periorityId,
      this.subject,
      this.discription,
      this.customer,
      this.galleryId,
      this.statusId,
      this.branchId,
      this.msg,
      this.companyId,
        this.createdBy
      });

 factory CRMEventRequest.fromJson(Map<String, dynamic> json) => CRMEventRequest(
     msg: json['msg']
 );

  Map<String,dynamic>  toJson() => {
  "assignedToId" : assignedToId ,
  "crmTypeId" : crmTypeId,
  "invoiceId" : invoiceId ,
  "periorityId" : periorityId ,
  "subject" : subject ,
  "discription":discription,
  "customer":customer,
  "gallaryId":galleryId,
  "statusId":statusId,
  "branchId":branchId,
  "companyId":companyId,
  "createdBy":createdBy
  };
}