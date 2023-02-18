import 'package:get/get.dart';
import 'package:hotel_manger/app/routes/app_pages.dart';

import '../../data/model/login/dto/response/login_response.dart';
import 'app_storage.dart';

class UserManager{
  static final _manager = UserManager._();
  UserManager._();
  factory UserManager() => _manager;

  bool get isLoggedIn => AppStorage.read(AppStorage.IS_LOGGED_IN) ?? false;
  int get id => user.id;

  int get companyId => user.companyId??159;

  int get branchId => user.branchId??232;

  List <BranchApplicationsDtoList> get list => user.branchApplicationsDtoList??[];





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

  Future logout() async{
    await AppStorage.removeAll();
    Get.toNamed(Routes.LOGIN);
  }

}