import 'package:get/get.dart';

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

  LoginResponse get user => LoginResponse.fromJson(AppStorage.read(AppStorage.USER));

  // void changeGallery(GalleryResponse? galleryResponse){
  //   LoginResponse newUser = LoginResponse(
  //       accountIdApi: user.accountIdApi,
  //       branchSelected: user.branchSelected,
  //       companySelected: user.companySelected,
  //       galleryId:  galleryResponse?.id ?? user.galleryId,
  //       galleryName: galleryResponse?.name?? user.galleryName,
  //       galleryType: galleryResponse?.invName ?? user.galleryType,
  //       id: user.id,
  //       name: user.name,
  //       userScreens: user.userScreens
  //   );
  //   final userData = newUser.toJson();
  //   AppStorage.write(AppStorage.USER, userData);
  // }

  login(LoginResponse data) {
    AppStorage.write(AppStorage.IS_LOGGED_IN, true);
    AppStorage.write(AppStorage.USER, data.toJson());
  }

  logout(){
    AppStorage.removeAll();
    Get.forceAppUpdate();
  }

}