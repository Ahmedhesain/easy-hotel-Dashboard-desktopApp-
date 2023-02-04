


class UploadCustomerPhotoRequest {

  final String? source ;
  final String name ;

  UploadCustomerPhotoRequest({this.source,required this.name});
  factory UploadCustomerPhotoRequest.fromJson(Map<String, dynamic> json) => UploadCustomerPhotoRequest(
      name: json['name']
  );

  Map<String , dynamic> toJson() => {
      'source' : source  ,
    'name' : name  ,
  };
}