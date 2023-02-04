import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/modules/sub_account_statement/views/widgets/sub_account_statement_buttons_widget.dart';
import 'package:toby_bills/app/modules/sub_account_statement/views/widgets/sub_account_statement_header_widget.dart';

import '../controllers/sub_account_statement_controller.dart';
import 'widgets/sub_account_statement_details_widget.dart';

class SubAccountStatementView extends GetView<SubAccountStatementController> {
  const SubAccountStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
            body: Column(
              children: [
                const SubAccountStatementButtonsWidget(),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: Colors.grey)),
                  margin: const EdgeInsets.all(20),
                  clipBehavior: Clip.antiAlias,
                  child: const SubAccountStatementHeaderWidget(),
                ),
                const SubAccountStatementDetailsWidget()
              ],
            )
        ),
      );
    });
  }
}
