

class GetGalleryExpensesListRequest {
  final int galleryId ;

  final DateTime dateFrom ;

  final DateTime dateto ;

  GetGalleryExpensesListRequest({required this.galleryId, required this.dateFrom, required this.dateto});


  Map<String , dynamic> toJson() => {
    "galleryId" : galleryId,
    "dateFrom" : dateFrom.toIso8601String(),
    "dateto" : dateto.toIso8601String(),
  };
}