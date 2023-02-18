import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hotel_manger/app/core/utils/show_popup_text.dart';
import 'package:hotel_manger/app/core/utils/user_manager.dart';
import 'package:hotel_manger/app/data/repository/auth/auth_repository.dart';
import 'package:hotel_manger/app/routes/app_pages.dart';

import '../../../data/model/login/dto/request/login_request.dart';

class LoginController extends GetxController {

  final isLoading = false.obs;
  final requestDto = LoginRequest();
  final form = GlobalKey<FormState>();

  // Future login() async {
  //   if(!form.currentState!.validate()) return;
  //   isLoading(true);
  //   AuthRepository().login(requestDto,
  //     onSuccess: (data){
  //       UserManager().login(data);
  //       Get.offNamed(Routes.HOME);
  //     },
  //     onError: (error)=> showPopupText(text: error.toString()),
  //     onComplete: () => isLoading(false)
  //   );
  // }
  Future login() async {
    if(!form.currentState!.validate()) return;
    isLoading(true);
    AuthRepository().login(requestDto,
        onSuccess: (data){
          UserManager().login(data.data);
          Get.offNamed(Routes.HOME);
        },
        onError: (error)=> showPopupText( text: error.toString()),
        onComplete: () => isLoading(false)
    );

  }

}
