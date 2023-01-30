

import 'package:hotel_manger/app/data/provider/api_provider.dart';

class GenericResponse<T> {

  bool? success;
  String? msg;
  String? code;
  T data;
  Pagination? pagination;

  GenericResponse({required this.success,required this.msg,required this.code,required this.data,required this.pagination});

  static fromJson<T>(json, ResponseConvertor<T> converter) {
    dynamic map = {};
    if(json is List || (json is Map && !json.containsKey("data"))){
      map["data"] = json;
    } else {
      map = json;
    }
   return GenericResponse(
     success: map["success"],
     msg: map["msg"],
     code: map["code"],
     data: converter(map["data"] ?? <String,dynamic>{}),
     pagination: json["pagination"] == null ? null : Pagination.fromJson(map["pagination"]),
    );
  }

}

class Pagination {
  final int pageSize;
  final int pageNumber;
  final int totalPages;
  final int totalRecords;
  final bool withPaging;

  Pagination({
    required this.pageSize,
    required this.pageNumber,
    required this.totalRecords,
    required this.totalPages,
    required this.withPaging,
  });

  factory Pagination.fromJson(Map<String, dynamic> json){
    return Pagination(
      pageSize: json["pageSize"],
      pageNumber: json["pageNumber"],
      totalPages: json["totalPages"],
      totalRecords: json["totalRecords"],
      withPaging: json["withPaging"],
    );
  }
}