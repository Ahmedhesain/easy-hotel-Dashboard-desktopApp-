import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/data/model/crm_reports/dto/response/branch_report_response.dart';
import 'package:toby_bills/app/modules/crm_reports/branches_report/views/widgets/gallery_info_widget.dart';
import 'package:toby_bills/app/modules/crm_reports/branches_report/views/widgets/search_widget.dart';

import '../../../../components/text_widget.dart';
import '../../../../core/values/app_colors.dart';
import '../controllers/branches_report_controller.dart';

class BranchesReportView extends GetView<BranchesReportController> {
  const BranchesReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            title: const TextWidget(
              " تقرير الفروع حسب الفترة", textColor: Colors.black,),
            centerTitle: true,
            elevation: 2,
            backgroundColor: AppColors.backGround,
          ),
          backgroundColor: AppColors.appGreyLight,
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children:  [
                  const BranchesReportSearchWidget(),
                  Column(
                    children: [
                      for(BranchReportResponse reportResponse in controller.reportResponse)
                        GalleryInfoWidget(reportResponse: reportResponse)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
