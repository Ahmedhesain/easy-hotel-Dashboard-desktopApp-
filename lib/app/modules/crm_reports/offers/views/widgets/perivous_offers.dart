import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/dropdown_widget.dart';
import 'package:toby_bills/app/modules/crm_reports/offers/controllers/offers_controller.dart';
import 'package:get/get.dart';

import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../data/model/offers/offer_dto.dart';

class PreviousOffers extends GetView<OffersController> {
  const PreviousOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Card(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const TextWidget(
                          "العروض السابقة",
                          size: 15,
                          weight: FontWeight.w600,
                        ),
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(
                                20.0, 0, 20.0, 0),
                            child: Container(
                              width: size.width * 0.16,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(
                                  color: AppColors.appGreyLight,
                                  borderRadius: BorderRadius.circular(15)),
                              child: DropDownWidget<OfferDTO>(
                                items: controller.offersList.map((offer) =>
                                    DropdownMenuItem<OfferDTO>(value: offer,
                                      child: Text(offer.name ?? ""),)).toList(),
                                onChanged: controller.onSelectOffer,
                                hideBorder: true,
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
