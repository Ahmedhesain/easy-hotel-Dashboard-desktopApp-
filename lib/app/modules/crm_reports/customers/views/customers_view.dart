import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/crm_reports/customers/views/widgets/report_filter_widget.dart';
import 'package:toby_bills/app/modules/crm_reports/customers/views/widgets/report_header.dart';
import 'package:toby_bills/app/modules/crm_reports/customers/views/widgets/report_table.dart';

import '../../../../components/text_widget.dart';
import '../controllers/customers_controller.dart';

class CustomersView extends GetView<CustomersController> {
  const CustomersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(height: 5,);
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
         appBar: AppBar(
           title: const TextWidget("تقرير عملاء الشركات"  , textColor: Colors.black ,),
           centerTitle: true,
           elevation: 2,
           backgroundColor: AppColors.backGround,
         ),
          backgroundColor:AppColors.appGreyLight ,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                CustomerReportHeader(),
                space,
                CustomersReportFilterWidget(),
                space,
                CustomersReportTable()
              ],
            ),
          ),
        ),
      );
    });
  }
}
