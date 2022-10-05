import 'package:get/get.dart';

import '../../data/model/customer/dto/response/find_customer_response.dart';
import '../../data/model/login/dto/response/login_response.dart';
import 'app_storage.dart';

class UserManager{
  static final _manager = UserManager._();
  UserManager._();
  factory UserManager() => _manager;

  bool get isLoggedIn => AppStorage.read(AppStorage.IS_LOGGED_IN) ?? false;
  int get id => user.id;

  int get companyId => user.companySelected;

  int get branchId => user.branchSelected;

  int get galleryId => user.galleryId;

  String get galleryName => user.galleryName;

  int get galleryType => user.galleryType;

  int get accountIdAPI  => user.accountIdApi;

  // String get token => AppStorage.read(AppStorage.TOKEN_KEY) ?? '';
  // String get rToken => AppStorage.read(AppStorage.REFRESH_TOKEN_KEY) ?? '';
  // bool get isTokenExpired => DateTime.tryParse(AppStorage.read(AppStorage.TOKEN_EXPIRE_TIME_KEY)??'')?.isBefore(DateTime.now()) ?? false;

  // String? get userId => user?.id;
  LoginResponse get user => LoginResponse.fromJson(AppStorage.read(AppStorage.USER));


  login(LoginResponse data) {
    AppStorage.write(AppStorage.IS_LOGGED_IN, true);
    AppStorage.write(AppStorage.USER, data.toJson());
    // AppStorage.write(AppStorage.TOKEN_KEY, data);
    // AppStorage.write(AppStorage.REFRESH_TOKEN_KEY, data.tokenInfo!.refreshToken);
    // AppStorage.write(AppStorage.TOKEN_EXPIRE_TIME_KEY, data.tokenInfo!.expireDate.toIso8601String());
  }

  logout(){
    AppStorage.removeAll();
    Get.forceAppUpdate();
  }

}