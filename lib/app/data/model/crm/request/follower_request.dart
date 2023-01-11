



class FollowerRequest {

  final int? branchId ;

  FollowerRequest({this.branchId});


  Map<String , dynamic>  toJson() => {
    'branchId' : branchId
  };
}