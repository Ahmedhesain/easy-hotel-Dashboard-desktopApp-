class FindInvoicesQueryRequest{

  FindInvoicesQueryRequest({required this.gallaryId,required this.searchNumber});

  final int gallaryId;
  final String searchNumber;

  Map<String, dynamic> toJson(){
    return {
      "gallaryId": gallaryId,
      "searchNumber": searchNumber
    };
  }


}