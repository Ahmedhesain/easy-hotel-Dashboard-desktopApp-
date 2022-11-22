import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/keys_widget.dart';
import 'package:toby_bills/app/modules/purchase_invoices/views/widgets/purchase_invoice_details_header.dart';
import 'package:toby_bills/app/modules/purchase_invoices/views/widgets/purchase_invoice_details_widget.dart';
import 'package:toby_bills/app/modules/purchase_invoices/controllers/purchase_invoices_controller.dart';
import 'widgets/purchase_invoice_info_widget.dart';
import 'widgets/purchase_invoice_header_widget.dart';
import 'widgets/purchase_side_widget.dart';

class PurchaseInvoicesView extends GetView<PurchaseInvoicesController> {
  const PurchaseInvoicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return KeysWidget(
        enabled: !controller.isLoading.value,
        newFunc: ()=>controller.newInvoice(),
        saveFunc: ()=>controller.saveInvoice(),
        printJournalFunc: ()=>controller.printGeneralJournal(context),
        printFunc: ()=>controller.printInvoice(context),
        child: AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            body: Row(
              children: [
                const PurchaseSideWidget(),
                Expanded(
                  child: Column(
                    children: [
                      const PurchaseInvoiceHeaderWidget(),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: Colors.grey)),
                            margin: const EdgeInsets.all(20).copyWith(top: 0),
                            child: Column(
                              children: const [
                                PurchaseInvoiceInfoWidget(),
                                SizedBox(height: 10),
                                // CustomerInfoWidget(),
                                PurchaseInvoiceDetailsHeaderWidget(),
                                Expanded(child: PurchaseInvoiceDetailsWidget()),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
