import 'package:get/get.dart';

import '../../data/model/customer/dto/response/find_customer_response.dart';
import '../../data/model/invoice/dto/response/gallery_response.dart';
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

  void changeGallery(GalleryResponse? galleryResponse){
    user.galleryId = galleryResponse!.id!;
    user.galleryName = galleryResponse.name!;
    AppStorage.write(AppStorage.USER, user.toJson());
  }

  login(LoginResponse data) {
    AppStorage.write(AppStorage.IS_LOGGED_IN, true);
    AppStorage.write(AppStorage.USER, data.toJson());
  }

  logout(){
    AppStorage.removeAll();
    Get.forceAppUpdate();
  }

}