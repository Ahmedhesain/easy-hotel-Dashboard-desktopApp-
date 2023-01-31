import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/modules/crm_reports/customer_comparison/views/widgets/customer_comparison_head_widget.dart';

import '../../../../components/text_widget.dart';
import '../../../../core/values/app_colors.dart';
import '../controllers/customer_comparison_controller.dart';

class CustomerComparisonView extends GetView<CustomerComparisonController> {
  const CustomerComparisonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            title: const TextWidget("مقارنة العميل حسب الفترة", textColor: Colors.black,),
            centerTitle: true,
            elevation: 2,
            backgroundColor: AppColors.backGround,
          ),
          backgroundColor: AppColors.appGreyLight,
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: const [
                CustomerComparisonHeadWidget()
              ],
            ),
          ),
        ),
      );
    });
  }
}
