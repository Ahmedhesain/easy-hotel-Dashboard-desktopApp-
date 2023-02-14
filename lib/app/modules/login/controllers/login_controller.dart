import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

}
