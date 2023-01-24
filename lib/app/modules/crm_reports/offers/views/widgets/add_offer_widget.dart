import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:toby_bills/app/components/dropdown_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';

import '../../../../../components/date_field_widget.dart';
import '../../../../../components/flutter_typeahead.dart';
import '../../../../../components/icon_button_widget.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/utils/show_popup_text.dart';
import '../../../../../data/model/customer/dto/response/find_customer_response.dart';
import '../../controllers/offers_controller.dart';
import 'add_offer_buttons_widget.dart';

class AddOfferWidget extends GetView<OffersController> {
  const AddOfferWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    const space = SizedBox(height: 15,);
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
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: TextWidget("انشاء عرض", size: 17, weight: FontWeight.bold,),
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const TextWidget("الفروع", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.16,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: DropDownMultiSelect(
                              key: UniqueKey(),
                              options: controller.galleries.map((e) => e.name??"").toList(),
                              selectedValues: controller.selectedGalleries.map((e) => e.name ?? "").toList(),
                              onChanged: controller.selectNewDeliveryplace,
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                                border: InputBorder.none,
                              ),

                              childBuilder: (List<String> values) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      values.isEmpty ? "يرجى تحديد معرض على الاقل" : values.where((element) => element != "تحديد الكل").join(', '),
                                      maxLines: 1,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const TextWidget("نوع الخصم", size: 15, weight: FontWeight.w600,),
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: Container(
                                width: size.width * 0.1,
                                decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    items: [0, 1].map((e) => DropdownMenuItem<int>(value: e, child: Text(e == 0 ? "قيمة" : "نسبة"),)).toList(),
                                    onChanged: (value) => controller.selectedOfferType.value = value!,
                                    value: controller.selectedOfferType.value,
                                  ),
                                )
                            ),
                          );
                        })
                      ],
                    ),
                  ],
                ),
              ),
              space,
              SizedBox(
                height: size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const TextWidget("من تاريخ", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.1,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child:DateFieldWidget(
                              hideBorder: true,
                              onComplete: (date){
                                controller.endDate(date);
                              },
                              date: controller.endDate.value,
                            )
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const TextWidget("الي تاريخ", size: 15, weight: FontWeight.w600,),
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: Container(
                                width: size.width * 0.1,
                                height: size.height * 0.06,

                                decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                                child:DateFieldWidget(
                                  hideBorder: true,
                                  onComplete: (date){
                                    controller.startDate(date);
                                  },
                                  date: controller.startDate.value,
                                )
                            ),
                          );
                        })
                      ],
                    ),
                  ],
                ),
              ),
              space,
              SizedBox(
                height: size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const TextWidget("قيمة العرض", size: 15, weight: FontWeight.w600, ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.1,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              controller: controller.offerValue,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const TextWidget("الاصناف", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.16,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: DropDownMultiSelect(
                              key: UniqueKey(),
                              options: controller.items.map((e) => e.name??"").toList(),
                              selectedValues: controller.selectedItems.map((e) => e.name ?? "").toList(),
                              onChanged: controller.selectNewItems,
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                                border: InputBorder.none,
                              ),

                              childBuilder: (List<String> values) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      values.isEmpty ? "يرجى تحديد صنف على الاقل" : values.where((element) => element != "تحديد الكل").join(', '),
                                      maxLines: 1,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

              space,
              const AddOffersButtonWidget()
            ],
          ),
        ),
      ),
    );
  }
}
