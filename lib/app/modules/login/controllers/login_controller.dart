import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_request.dart';
import 'package:toby_bills/app/data/repository/auth/auth_repository.dart';
import 'package:toby_bills/app/routes/app_pages.dart';

import '../../../data/model/login/dto/request/login_request.dart';

class LoginController extends GetxController {

  final isLoading = false.obs;
  final requestDto = LoginRequest();
  final form = GlobalKey<FormState>();

  Future login() async {
    if(!form.currentState!.validate()) return;
    isLoading(true);
    AuthRepository().login(requestDto,
      onSuccess: (data){
        UserManager().login(data);
        Get.offNamed(Routes.HOME);
      },
      onError: (error)=> showPopupText(text: error.toString()),
      onComplete: () => isLoading(false)
    );
  }

}
