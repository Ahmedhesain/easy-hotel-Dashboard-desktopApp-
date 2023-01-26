import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/crm_reports/offers/views/widgets/add_offer_buttons_widget.dart';
import 'package:toby_bills/app/modules/crm_reports/offers/views/widgets/add_offer_head_widget.dart';
import 'package:toby_bills/app/modules/crm_reports/offers/views/widgets/added_items_table.dart';
import 'package:toby_bills/app/modules/crm_reports/offers/views/widgets/excluded_items_table.dart';
import '../../../../components/text_widget.dart';
import '../controllers/offers_controller.dart';

class OffersView extends GetView<OffersController> {
  const OffersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          backgroundColor: AppColors.appGreyLight,
          appBar: AppBar(
            backgroundColor:Colors.white ,
            title: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: TextWidget("انشاء عرض", size: 17, weight: FontWeight.bold, textColor: Colors.black,),
              ),
            ),
            actions: const [
              AddOffersButtonWidget()
            ],
          ),
          body: SizedBox(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    children: const [
                      AddOfferHeadWidget(),
                      SizedBox(height: 20,),
                      AddedItemsTable(),
                      ExcludedItemsTable(),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
