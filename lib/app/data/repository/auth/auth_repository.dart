

import 'package:hotel_manger/app/data/model/login/dto/response/login_response.dart';
import 'package:hotel_manger/app/data/provider/api_provider.dart';

import '../../model/login/dto/request/login_request.dart';

class AuthRepository {

  login(
      LoginRequest request, {
        SuccessFunc<LoginResponse> onSuccess,
        Function(dynamic error)? onError,
        Function()? onComplete,
        // Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<LoginResponse>(
      'auth/loginUserForDashBoard',
      onSuccess: onSuccess,
      data: request.toJson(),
      onComplete: onComplete,
      queryParameters: request.toJson(),
      onError: onError,
      convertor: LoginResponse.fromJson,
      // onComplete: onComplete
    );}


}
