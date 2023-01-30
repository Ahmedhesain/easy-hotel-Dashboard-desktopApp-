import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:hotel_manger/app/core/enums/toast_msg_type.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';



abstract class Common {

  static showSnackBar(String title, String message,
      {Color backgroundColor = AppColors.appHallsRedDark}) {
    Get.snackbar(
      title,
      message,
      borderRadius: 8.0,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(10),
      colorText: AppColors.appGreyLight,
    );
  }

  static showToast(BuildContext context , String title , MsgType msgType){
    showToastWidget(
      Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: msgType == MsgType.success ? Colors.green : Colors.red , width: 2),
            color: msgType == MsgType.success ? Colors.green.shade300 : Colors.red.shade300
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(title)),
        ),
      ),
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Widget getSpin({double size = 50.0,double? lineWidth}) {
    return const CircularProgressIndicator();
  }



  static TextDirection getFieldDirection(String value) {
    if (value.codeUnitAt(1) >= 1536 && value.codeUnitAt(1) <= 1791) {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }
}
