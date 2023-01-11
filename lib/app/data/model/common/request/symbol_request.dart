


class SymbolRequest {

 final int? companyId ;

  SymbolRequest({this.companyId});


  Map<String , dynamic>  toJson() => {
    'companyId' : companyId
  };
}