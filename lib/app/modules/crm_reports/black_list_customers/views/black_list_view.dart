import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';

import '../controllers/black_list_controller.dart';

class BlackListView extends GetView<BlackListController> {
  const BlackListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(

        ),
      );
    });
  }
}
