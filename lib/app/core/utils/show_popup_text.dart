import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';

import 'common.dart';

showPopupText({BuildContext? context, required String text, MsgType type = MsgType.error}){
  Common.showToast(context ?? Get.overlayContext!,text, type);
}