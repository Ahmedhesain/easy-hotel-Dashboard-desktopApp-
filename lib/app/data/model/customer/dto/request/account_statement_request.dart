class AccountStatementRequest{
  AccountStatementRequest({required this.id});
  final int id;

  Map<String,dynamic> toJson() => {"id": id};
}