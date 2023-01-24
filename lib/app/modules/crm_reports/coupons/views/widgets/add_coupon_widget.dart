import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/dropdown_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';

import '../../../../../components/date_field_widget.dart';
import '../../../../../components/flutter_typeahead.dart';
import '../../../../../components/icon_button_widget.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/utils/show_popup_text.dart';
import '../../../../../data/model/customer/dto/response/find_customer_response.dart';
import '../../controllers/coupons_controller.dart';
import 'add_cuopon_buttons_widget.dart';

class AddCouponWidget extends GetView<CouponsController> {
  const AddCouponWidget({Key? key}) : super(key: key);

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
                  child: TextWidget("انشاء كوبون خصم", size: 17, weight: FontWeight.bold,),
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const TextWidget("كود الكوبون", size: 15, weight: FontWeight.w600, ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.1,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              controller: controller.couponCodeController,
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
                        const TextWidget("العميل", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.1,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: TypeAheadFormField<FindCustomerResponse>(
                                itemBuilder: (context, client) {
                                  return SizedBox(
                                    child: Text("${client.name}"),
                                  );
                                },
                                suggestionsCallback: (filter) => controller.customers,
                                onSuggestionSelected: (value) async {
                                  if (value.blackList == true) {
                                    showPopupText(text: 'هذا العميل محظور');
                                    return;
                                  }
                                  controller.customerController.text = "${value.name}";
                                  controller.selectedCustomer(value);
                                },
                                textFieldConfiguration: TextFieldConfiguration(
                                  textInputAction: TextInputAction.next,
                                  controller: controller.customerController,
                                  focusNode: controller.customerFieldFocusNode,
                                  onSubmitted: (_) => controller.getCustomersByCode(),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      isDense: true,
                                      suffixIcon: IconButtonWidget(
                                        icon: Icons.search,
                                        onPressed: () {
                                          controller.getCustomersByCode();
                                        },
                                      )),
                                )),
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
                                    onChanged: (value) => controller.selectedCouponType.value = value!,
                                    value: controller.selectedCouponType.value,
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
                        const TextWidget("قيمة الخصم", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.1,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              controller: controller.couponValueController,
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
                        const TextWidget("تاريخ البدء", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.1,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: DateFieldWidget(
                              hideBorder: true,
                              onComplete: (date){
                                controller.startDate(date);
                              },
                              date: controller.startDate.value,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const TextWidget("تاريخ الانتهاء", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.1,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: DateFieldWidget(
                              hideBorder: true,
                              onComplete: (date){
                                controller.endDate(date);
                              },
                              date: controller.endDate.value,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              space,
              const AddCouponsButtonWidget()
            ],
          ),
        ),
      ),
    );
  }
}
