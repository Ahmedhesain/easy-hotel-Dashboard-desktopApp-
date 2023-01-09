import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:toby_bills/app/services/crashlytics.dart';

typedef ResponseConvertor<T,F> = T Function(F json);

class ApiProvider {
  static final _instance = ApiProvider._();

  factory ApiProvider() => _instance;

  ApiProvider._(){
    _dio = Dio(
      BaseOptions(
        followRedirects: false,
        validateStatus: (status) => true,
        baseUrl: apiUrl,
        receiveTimeout: 1000 * 1000,
        connectTimeout: 1000 * 1000,
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
          responseBody: true,
          requestBody: true,
          responseHeader: true,
          requestHeader: true,
          request: true,
          error: true),
    );
  }

  static String get apiUrl {
    if (kDebugMode) {
      return  "http://192.168.0.100:9090/toby/rest/";
      return "http://134.122.57.181:8080/debug/rest/";
      // return "http://134.122.57.181:8080/test19/rest/";
      return  "http://192.168.1.13:9090/toby/rest/";
    } else {
      return "http://localhost:9090/toby/rest/";
      // return "http://192.168.1.22:9090/toby/rest/";
      // return "http://134.122.57.181:8080/debug/rest/";
     // return "http://134.122.57.181:8080/test19/rest/";
    }
  }

  late Dio _dio;

  _requestApi<T,F>(String url,
      String method,
      String token,
      dynamic data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      ResponseConvertor<T,F> convertor,
      Function()? onComplete,
      Function(T data)? onSuccess,
      Function(dynamic error)? onError,
      Function(int progress)? onSendProgress,
      bool ignoreToken) async {
    (headers ?? {}).forEach((key, value) => _dio.options.headers[key] = value);
    if(token.isNotEmpty) {
      _dio.options.headers["Authorization"] = token.isEmpty ? "" : "Bearer $token";
    }
    try {
      late Response response;
      if (method == 'get') {
        response = await _dio.get(url, queryParameters: queryParameters);
      } else if (method == 'post') {
        response = await _dio.post(url, data: data, queryParameters: queryParameters, onSendProgress: (send, total) {
          if (onSendProgress != null) {
            final pr = (send / total) * 100;
            onSendProgress(pr.toInt());
          }
        });
      } else if (method == 'patch') {
        response = await _dio.patch(url, data: data, queryParameters: queryParameters);
      } else if (method == 'put') {
        response = await _dio.put(url, data: data, queryParameters: queryParameters);
      }
      if (handleRemoteError(response)) {
        if (onSuccess != null) {
          final data = convertor(response.data);
          await onSuccess(data);
        }
      }
    } on DioError catch (e, s) {
      if (onError != null) onError(NetworkException(ErrorCode.connection, "Connection error", null));
      reportCrash(e, s);
    } on NetworkException catch (e, s) {
      if (onError != null) onError(e);
      reportCrash(e, s);
    } catch (e, s) {
      if (onError != null) onError(e);
      reportCrash(e, s);
    } finally {
      if (onComplete != null) {
        onComplete();
      }
    }
  }

  Future post<T,F>(String url, {
    String token = '',
    dynamic data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    required ResponseConvertor<T,F> convertor,
    Function()? onComplete,
    Function(T data)? onSuccess,
    Function(dynamic error)? onError,
    Function(int progress)? onSendProgress,
    bool ignoreToken = false,
  }) =>
      _requestApi(
          url,
          'post',
          token,
          data,
          header,
          queryParameters,
          convertor,
          onComplete,
          onSuccess,
          onError,
          onSendProgress,
          ignoreToken);

  Future get<T,F>(String url, {
    String token = '',
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    required ResponseConvertor<T,F> convertor,
    Function()? onComplete,
    Function(T data)? onSuccess,
    Function(dynamic error)? onError,
    Function(int progress)? onSendProgress,
    bool ignoreToken = false,
  }) =>
      _requestApi(
          url,
          'get',
          token,
          null,
          header,
          queryParameters,
          convertor,
          onComplete,
          onSuccess,
          onError,
          onSendProgress,
          ignoreToken);

  Future patch<T,F>(String url, {
    String token = '',
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    required ResponseConvertor<T,F> convertor,
    Function()? onComplete,
    Function(T data)? onSuccess,
    Function(dynamic error)? onError,
    Function(int progress)? onSendProgress,
    bool ignoreToken = false,
  }) =>
      _requestApi(
          url,
          'patch',
          token,
          data,
          header,
          queryParameters,
          convertor,
          onComplete,
          onSuccess,
          onError,
          onSendProgress,
          ignoreToken);

  Future put<T,F>(String url, {
    String token = '',
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    required ResponseConvertor<T,F> convertor,
    Function()? onComplete,
    Function(T data)? onSuccess,
    Function(dynamic error)? onError,
    Function(int progress)? onSendProgress,
    bool ignoreToken = false,
  }) =>
      _requestApi(
          url,
          'put',
          token,
          data,
          header,
          queryParameters,
          convertor,
          onComplete,
          onSuccess,
          onError,
          onSendProgress,
          ignoreToken);

}

class NetworkException implements Exception {
  final ErrorCode errorCode;
  final String error;
  final int? code;

  NetworkException(this.errorCode, this.error, this.code);

  @override
  String toString() => error;
}

enum ErrorCode { serverError, badRequest, unauthenticated, timeOut, noInternetConnection, unProcessableEntity, wrongInput, forbidden, conflict, connection, notFound }

bool handleRemoteError(Response response) {
  final statusCode = response.statusCode ?? 0;
  if(statusCode == 204){
    throw NetworkException(ErrorCode.notFound, "لايوجد", statusCode);
  }
  if (statusCode >= 200 && statusCode < 300) {
    if(response.data is List) return true;
    if((response.data as Map<String,dynamic>).containsKey("success")){
      if((response.data as Map<String,dynamic>)["success"]) {
        return true;
      } else {
        String msg = "يوجد خطأ";
        if((response.data as Map<String,dynamic>).containsKey("msg")){
          msg = (response.data as Map<String,dynamic>)["msg"];
        }
        throw NetworkException(ErrorCode.wrongInput, msg, statusCode);
      }
    }
    return true;
  }
  if (statusCode == 401) {
    throw NetworkException(ErrorCode.unauthenticated, "يرجى تسجيل الدخول", statusCode);
  } else if (statusCode == 403) {
    throw NetworkException(ErrorCode.forbidden, "لايمكنك الوصول", statusCode);
  } else if (statusCode == 404) {
    throw NetworkException(ErrorCode.notFound, "الرابط غير موجود", statusCode);
  } else if (statusCode == 409) {
    throw NetworkException(ErrorCode.conflict, "conflict", statusCode);
  } else if (statusCode == 400) {
    throw NetworkException(ErrorCode.badRequest, "يوجد مشكلة في المخدم", statusCode);
  }
  throw NetworkException(ErrorCode.serverError, "يوجد مشكلة في المخدم", statusCode);
}
