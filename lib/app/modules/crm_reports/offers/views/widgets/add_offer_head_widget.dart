import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/dropdown_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';

import '../../../../../components/date_field_widget.dart';
import '../../../../../components/flutter_typeahead.dart';
import '../../../../../components/icon_button_widget.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/utils/show_popup_text.dart';
import '../../../../../data/model/customer/dto/response/find_customer_response.dart';
import '../../../../../data/model/item/dto/response/item_response.dart';
import '../../../../../data/model/reports/dto/response/group_list_response.dart';
import '../../controllers/offers_controller.dart';
import 'add_offer_buttons_widget.dart';

class AddOfferHeadWidget extends GetView<OffersController> {
  const AddOfferHeadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    const space = SizedBox(height: 15,);
    final spaceVertical = SizedBox(width: size.width * 0.05,);
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
                        const TextWidget("الفروع", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.16,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: DropDownMultiSelect(
                              key: UniqueKey(),
                              options: controller.galleries.map((e) => e.name ?? "").toList(),
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
                    spaceVertical,
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
                    spaceVertical,
                    Row(
                      children: [
                        const TextWidget("من تاريخ", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                              width: size.width * 0.1,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                              child: DateFieldWidget(
                                hideBorder: true,
                                onComplete: (date) {
                                  controller.startDate(date);
                                },
                                date: controller.startDate.value,
                              )
                          ),
                        )
                      ],
                    ),
                    spaceVertical,
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
                                child: DateFieldWidget(
                                  hideBorder: true,
                                  onComplete: (date) {
                                    controller.endDate(date);
                                  },
                                  date: controller.endDate.value,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const TextWidget("الفئة", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.18,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: Obx(() {
                              return DropDownWidget<GroupListResponse>(
                                key: UniqueKey(),
                                hideBorder: true,
                                items: controller.groups.map((e) => DropdownMenuItem<GroupListResponse>(value: e,child: Text(e.name!) ,)).toList(),
                                onChanged: (val) => controller.selectedGroup.value = val,

                              );
                            }),
                          ),
                        )
                      ],
                    ),
                    spaceVertical,
                    Row(
                      children: [
                        const TextWidget("اقصي سعر للعرض", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.1,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              controller: controller.maxPrice,
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
                    spaceVertical,
                    Row(
                      children: [
                        const TextWidget("قيمة العرض", size: 15, weight: FontWeight.w600,),
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
                    spaceVertical,
                    Row(
                      children: [
                        const TextWidget("سعر البيع", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.1,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: TextFormField(
                              controller: controller.sellPrice,
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
                  ],
                ),
              ),
              space,
              SizedBox(
                height: size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const TextWidget("اسم العرض", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                              width: size.width * 0.1,
                              height: size.height * 0.06,
                              decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                              child: TextFormField(
                                controller: controller.offerNameController,
                                decoration:const InputDecoration(
                                  border: InputBorder.none
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              space,
              SizedBox(
                height: size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const TextWidget("الاصناف", size: 15, weight: FontWeight.w600,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: Container(
                            width: size.width * 0.16,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                            child: TypeAheadFormField<ItemResponse>(
                                suggestionsCallback: (filter) => controller.filterItems(filter),
                                onSuggestionSelected: (val){
                                  controller.selectedItem.value = val;
                                  controller.itemNameController.text = val.name! ;
                                },
                                itemBuilder: (context, item) {
                                  return Container(
                                    color: Colors.grey,
                                    child: Center(
                                      child: Text("${item.name}"),
                                    ),
                                  );
                                },
                                textFieldConfiguration: TextFieldConfiguration(
                                    textInputAction: TextInputAction.next,
                                    textAlignVertical: TextAlignVertical.center,
                                    focusNode: controller.itemNameFocusNode,
                                    controller: controller.itemNameController,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      border: OutlineInputBorder(),
                                      filled: true,
                                      fillColor: Colors.white70,
                                    ),
                                    onSubmitted: (value) {
                                      final items = controller.filterItems(value);
                                      if (controller.itemNameController.text.isNotEmpty) {
                                        controller.selectedItem(items.first);
                                        controller.itemNameController.text = items.first.name! ;
                                      }
                                    }),
                              ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                        //   child: Container(
                        //     width: size.width * 0.16,
                        //     height: size.height * 0.06,
                        //     decoration: BoxDecoration(color: AppColors.appGreyLight, borderRadius: BorderRadius.circular(15)),
                        //     child: TextField(
                        //       onChanged: controller.filterItems,
                        //       decoration: const InputDecoration(
                        //         hintText: "ابحث عن صنف معين"
                        //       ),
                        //     )
                        //   ),
                        // )
                      ],
                    ),
                    Obx(() {
                      return Row(
                        children: [
                          SizedBox(
                              width: size.width * 0.2,
                              child: RadioListTile(value: 0,
                                groupValue: controller.addedOrExcluded.value,
                                onChanged: (val) => controller.addedOrExcluded.value = val!,
                                title: const TextWidget("اضافة الي العرض"),)),
                          SizedBox(
                              width: size.width * 0.2,
                              child: RadioListTile(value: 1,
                                groupValue: controller.addedOrExcluded.value,
                                onChanged: (val) => controller.addedOrExcluded.value = val!,
                                title: const TextWidget("استثناء من العرض"),)),
                        ],
                      );
                    }),
                    spaceVertical,
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle
                      ),
                        child: IconButton(onPressed:() => controller.addItem(), icon: const Icon(Icons.add)))
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
