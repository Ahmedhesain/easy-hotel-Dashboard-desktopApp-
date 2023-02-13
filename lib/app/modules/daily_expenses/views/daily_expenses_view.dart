

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/modules/daily_expenses/controllers/daily_expenses_controller.dart';
import 'package:toby_bills/app/modules/daily_expenses/views/widgets/add_widget.dart';

import '../../../components/app_loading_overlay.dart';
import '../../../components/text_widget.dart';
import '../../../core/values/app_colors.dart';

class DailyExpensesView extends GetView<DailyExpensesController> {
  const DailyExpensesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            appBar: AppBar(
              title: const TextWidget(
                " مصروفات اليوميه", textColor: Colors.black,),
              centerTitle: true,
              elevation: 2,
              backgroundColor: AppColors.backGround,
            ),
            backgroundColor: AppColors.appGreyLight,
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: const [
                  DailyExpensesAddWidget(),
                ],
              ),
            ),
          ));
    });
  }
}
