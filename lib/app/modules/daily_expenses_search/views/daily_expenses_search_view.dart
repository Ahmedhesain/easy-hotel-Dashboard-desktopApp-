

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/modules/daily_expenses_search/views/widgets/daily_expenses_table_widget.dart';
import 'package:toby_bills/app/modules/daily_expenses_search/views/widgets/search_widget.dart';
import '../../../components/app_loading_overlay.dart';
import '../../../components/text_widget.dart';
import '../../../core/values/app_colors.dart';
import '../controllers/daily_expenses_search_controller.dart';

class DailyExpensesSearchView extends GetView<DailyExpensesSearchController> {
  const DailyExpensesSearchView({Key? key}) : super(key: key);

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
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    DailyExpensesSearchWidget(),
                    SizedBox(height: 10,),
                    DailyExpensesTableWidget()
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
