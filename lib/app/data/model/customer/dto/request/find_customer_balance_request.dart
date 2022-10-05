class FindCustomerBalanceRequest {
  FindCustomerBalanceRequest({
    this.id,
  });

  int? id;

  Map<String, dynamic> toJson() => {
    "id" : id
  };

}
