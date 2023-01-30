import 'dart:async';
import 'package:dio/dio.dart';
import 'package:hotel_manger/app/core/values/app_strings.dart';
import 'package:hotel_manger/app/data/model/generic/response/generic_response.dart';
import 'package:hotel_manger/app/services/crashlytics.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

typedef ResponseConvertor<T> = T Function(dynamic json);
typedef SuccessFunc<T> = Function(GenericResponse<T> data)?;

class ApiProvider {
  static final _instance = ApiProvider._();

  factory ApiProvider() => _instance;

  ApiProvider._() {
    _dio = Dio(
      BaseOptions(
        followRedirects: false,
        validateStatus: (status) => true,
        baseUrl: apiUrl,
        // headers: {
        //   "Connection":"keep-alive",
        //   "Accept-Encoding":"gzip, deflate, br",
        // },
        receiveTimeout: 60 * 10000,
        connectTimeout: 100 * 10000,
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true, responseHeader: true, requestHeader: true, request: true, error: true),
    );
  }

  // static const String _domainUrl = "http://192.168.1.22:8050/";
  static const String _domainUrl = "http://192.168.1.13:8005/";
  // static const String _domainUrl = "http://192.168.1.59:8070/hotelApp";
  static const String apiUrl = "$_domainUrl/";
  static const String imageUrl = "$_domainUrl/restaurantItem/itemImage/";
  final InternetConnectionChecker _checker = InternetConnectionChecker();
  late Dio _dio;

  _requestApi<T,F>(String url,
      String method,
      String token,
      dynamic data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      ResponseConvertor<T> convertor,
      Function()? onComplete,
      SuccessFunc<T> onSuccess,
      Function(dynamic error)? onError,
      Function(int progress)? onSendProgress,
      bool ignoreToken) async {
    (headers ?? {}).forEach((key, value) => _dio.options.headers[key] = value);
    _dio.options.headers["Authorization"] = token.isEmpty ? "" : "Bearer $token";
    try {
      if(!(await _checker.hasConnection)){
        throw NetworkException(ErrorCode.noInternetConnection, AppStrings.noInternetConnection);
      }
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
      }
      if (handleRemoteError(response)) {
        if (onSuccess != null) {
          final data = GenericResponse.fromJson<T>(response.data, convertor);
          await onSuccess(data);
        }
      }
    } on DioError catch (e, s) {
      if (onError != null) onError(NetworkException(ErrorCode.connection, AppStrings.connectionError, null));
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

  Future post<T>(String url, {
    String token = '',
    dynamic data,
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    required ResponseConvertor<T> convertor,
    Function()? onComplete,
    SuccessFunc<T> onSuccess,
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

  Future get<T>(String url, {
    String token = '',
    Map<String, dynamic>? header,
    Map<String, dynamic>? queryParameters,
    required ResponseConvertor<T> convertor,
    Function()? onComplete,
    SuccessFunc<T> onSuccess,
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


}

class NetworkException implements Exception {
  final ErrorCode errorCode;
  final String error;
  final int? code;

  NetworkException(this.errorCode, this.error, [this.code]);

  @override
  String toString() => error;
}

enum ErrorCode {
  serverError,
  badRequest,
  unauthenticated,
  timeOut,
  noInternetConnection,
  unProcessableEntity,
  wrongInput,
  forbidden,
  conflict,
  connection,
  notFound,
  frozenAccount,
}

bool handleRemoteError(Response response) {
  final statusCode = response.statusCode ?? 0;
  final data = response.data;
  String? errorMessage;
  if (statusCode >= 200 && statusCode < 300 && data["success"] == true) {
    return true;
  }
  if (data is Map && data["msg"] != null && data["msg"] is String) {
    errorMessage = data["msg"];
  }
  if (statusCode == 401) {
    throw NetworkException(ErrorCode.unauthenticated, errorMessage ?? AppStrings.unauthenticated,statusCode);
  } else if (statusCode == 403) {
    throw NetworkException(ErrorCode.forbidden, errorMessage ?? AppStrings.forbidden,statusCode);
  } else if (statusCode == 404) {
    throw NetworkException(ErrorCode.notFound, errorMessage ?? AppStrings.notFound,statusCode);
  } else if (statusCode == 400) {
    throw NetworkException(ErrorCode.badRequest, errorMessage ?? AppStrings.serverError,statusCode);
  }
  throw NetworkException(ErrorCode.serverError, errorMessage ?? AppStrings.serverError,statusCode);
}
