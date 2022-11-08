import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/modules/payments/views/widgets/payments_header_widget.dart';

import '../controllers/payments_controller.dart';
import 'widgets/payments_buttons_widget.dart';
import 'widgets/payments_details_header.dart';
import 'widgets/payments_details_widget.dart';

class PaymentsView extends GetView<PaymentsController> {
  const PaymentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
            body: Column(
              children: [
                const PaymentsButtonsWidget(),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: Colors.grey)),
                  margin: const EdgeInsets.all(20),
                  clipBehavior: Clip.antiAlias,
                  child: const PaymentsHeaderWidget(),
                ),
                const PaymentsDetailsHeaderWidget(),
                const Expanded(child: PaymentsDetailsWidget())
              ],
            )
        ),
      );
    });
  }
}
