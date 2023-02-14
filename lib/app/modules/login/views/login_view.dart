import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotel_manger/app/components/image_widget.dart';
import 'package:hotel_manger/app/components/text_widget.dart';
import 'package:hotel_manger/app/core/utils/validator.dart';
import 'package:hotel_manger/app/core/values/app_assets.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/core/values/app_strings.dart';
import 'package:hotel_manger/app/routes/app_pages.dart';
import '../../../components/app_loading_overlay.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appHallsRedDark,
        title: const Text(
          "Easy Hotel",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Form(
                  key: controller.form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        margin: EdgeInsets.only(top: 40),
                        child: ImageWidget(
                          path: AppAssets.logoImg, width: 100, height: 110,),),
                      Padding(
                        padding: EdgeInsets.only(top:0),
                        child: TextWidget(
                            'Login', textColor: AppColors.appHallsRedDark,
                          weight: FontWeight.bold,
                          size: 40),
                      ),

                      const SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'User Name',
                            prefixIcon: const Icon(
                              Icons.email,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: AppValidator.forceValue,
                          onChanged: (value) => controller.requestDto.userName = value,
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            suffixIcon: Icon(
                              Icons.remove_red_eye,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: AppValidator.forceValue,
                          // onFieldSubmitted: (_) => controller.login(),
                          onChanged: (value) => controller.requestDto.password = value,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: 300,
                        height: 40,
                        color: AppColors.appHallsRed,
                        child: MaterialButton(
                          onPressed: () {
                            Get.toNamed(Routes.HOME);
                            // controller.login();
                          },
                          child: const Text(
                            'LOGIN',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
