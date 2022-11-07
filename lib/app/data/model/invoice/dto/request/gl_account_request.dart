class GlAccountRequest{
  final int branchId;

  GlAccountRequest(this.branchId);

  Map<String, dynamic> toJson(){
    return {
      "branchId": branchId
    };
  }
}