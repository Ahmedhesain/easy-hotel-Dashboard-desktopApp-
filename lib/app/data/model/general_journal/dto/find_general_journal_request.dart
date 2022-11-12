class FindGeneralJournalRequest {
  final int? id;

  FindGeneralJournalRequest(this.id);

  Map<String,dynamic> toJson(){
    return {
      "id": id
    };
  }

}