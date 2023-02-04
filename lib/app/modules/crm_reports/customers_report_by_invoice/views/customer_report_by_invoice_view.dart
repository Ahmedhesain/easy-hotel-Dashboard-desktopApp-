import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/modules/crm_reports/customers_report_by_invoice/views/widgets/customers_report_by_invoice_head_widget.dart';
import 'package:toby_bills/app/modules/crm_reports/customers_report_by_invoice/views/widgets/report_table.dart';

import '../../../../components/text_widget.dart';
import '../../../../core/values/app_colors.dart';
import '../controllers/customer_report_by_invoice_controller.dart';

class CustomersReportByInvoiceView extends GetView<CustomersReportByInvoiceController> {
  const CustomersReportByInvoiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            title: const TextWidget("تقرير العملاء حسب الفواتير", textColor: Colors.black,),
            centerTitle: true,
            elevation: 2,
            backgroundColor: AppColors.backGround,
          ),
          backgroundColor: AppColors.appGreyLight ,
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: const [
                   CustomersReportByInvoiceHeadWidget(),
                   SizedBox(height: 10,),
                   CustomersReportByInvoiceTable()
                ],
              ),
            ),
          ),
        ),

      );
    });
  }
}
