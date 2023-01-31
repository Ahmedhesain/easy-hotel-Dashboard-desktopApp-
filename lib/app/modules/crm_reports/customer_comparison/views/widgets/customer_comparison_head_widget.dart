



import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/dropdown_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';

import '../../../../../components/button_widget.dart';
import '../../../../../components/date_field_widget.dart';
import '../../../../../components/flutter_typeahead.dart';
import '../../../../../components/icon_button_widget.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../data/model/customer/dto/response/find_customer_response.dart';
import '../../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../controllers/customer_comparison_controller.dart';

class CustomerComparisonHeadWidget extends GetView<CustomerComparisonController> {
  const CustomerComparisonHeadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    const space = SizedBox(width: 20,);
    const spaceV = SizedBox(height: 20,);
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        color: AppColors.backGround,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
           children: [
             SizedBox(
               width: size.width,
               child: Row(
                 children: [
                   Row(
                     children: [
                        Padding(
                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                         child: SizedBox(
                           width: size.width * 0.06,
                           child: const TextWidget(
                             'المعرض', size: 15 , weight: FontWeight.bold,
                           ),
                         ),
                       ),
                       Container(
                         width: size.width * .18,
                         height: size.height * 0.06,
                         decoration: const BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(5)),
                           color: AppColors.appGreyLight,
                           // border: Border.all(color: Colors.grey)
                         ),
                         child: Obx(() {
                           return DropDownWidget<GalleryResponse>(
                             items: controller.galleries.map((e) =>
                                 DropdownMenuItem<GalleryResponse>(value: e,child: TextWidget(e.name!) ,)).toList(),
                             value : controller.selectedGallery.value,
                             hideBorder: true ,
                             onChanged: (val) => controller.selectedGallery.value = val,
                           );
                         }),
                       ),

                     ],
                   ),
                 ],
               ),
             ),
             spaceV,
             SizedBox(
               width: size.width,
               child: Row(
                 children: [
                   Row(
                     children: [
                       Padding(
                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                         child: SizedBox(
                           width: size.width * 0.06,
                           child: const TextWidget(
                             'العميل الاول', size: 15 , weight: FontWeight.bold,
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                         child: Container(
                           width: size.width * 0.1,
                           height: size.height * 0.06,
                           decoration: const BoxDecoration(
                               borderRadius: BorderRadius.all(Radius.circular(5)),
                               color:  AppColors.appGreyLight,
                              ),
                           child: TypeAheadFormField<FindCustomerResponse>(
                             itemBuilder: (context, client) {
                               return SizedBox(
                                 height: size.height * 0.06,
                                 child: Center(
                                   child: Text(client.name.toString()),
                                 ),
                               );
                             },
                             onSuggestionSelected: (value) {
                               controller.customerController.text = value.name ?? "";
                               controller.selectedCustomer(value);
                             },
                             textFieldConfiguration: TextFieldConfiguration(
                               controller: controller.customerController,
                               focusNode: controller.customerFocusNode,
                               onSubmitted: (search) => controller.getCustomers(search , 0),
                               decoration: InputDecoration(
                                   suffixIcon: IconButtonWidget(
                                     icon: Icons.search,
                                     onPressed: (){
                                       controller.getCustomers(controller.customerController.text , 0);
                                     },
                                   ),
                                 border: InputBorder.none
                               ),
                             ),
                             suggestionsCallback: (filter) => controller.customers,
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                         child: SizedBox(
                           width: size.width * 0.06,
                           child: const TextWidget(
                             'العميل الثاني', size: 15 , weight: FontWeight.bold,
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                         child: Container(
                           width: size.width * 0.1,
                           height: size.height * 0.06,
                           decoration: const BoxDecoration(
                               borderRadius: BorderRadius.all(Radius.circular(5)),
                               color:  AppColors.appGreyLight,
                              ),
                           child: TypeAheadFormField<FindCustomerResponse>(
                             itemBuilder: (context, client) {
                               return SizedBox(
                                 height: size.height * 0.06,
                                 child: Center(
                                   child: Text(client.name.toString()),
                                 ),
                               );
                             },
                             onSuggestionSelected: (value) {
                               controller.customer2Controller.text = value.name ?? "";
                               controller.selectedCustomer2(value);
                             },
                             textFieldConfiguration: TextFieldConfiguration(
                               controller: controller.customer2Controller,
                               focusNode: controller.customer2FocusNode,
                               onSubmitted: (search) => controller.getCustomers(search , 1),
                               decoration: InputDecoration(
                                   suffixIcon: IconButtonWidget(
                                     icon: Icons.search,
                                     onPressed: (){
                                       controller.getCustomers(controller.customer2Controller.text , 1);
                                     },
                                   ),
                                 border: InputBorder.none
                               ),
                             ),
                             suggestionsCallback: (filter) => controller.customers,
                           ),
                         ),
                       ),
                     ],
                   )
                 ],
               ),
             ),
             spaceV,
             SizedBox(
               width: size.width,
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10),
                     child: SizedBox(
                       width: size.width * 0.06,
                       child: const TextWidget(
                         "فترة اولي",
                         size: 15,
                         weight: FontWeight.bold,
                       ),
                     ),
                   ),
                   space,
                   Container(
                     width: size.width * 0.1,
                     height: size.height * 0.06,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: AppColors.appGreyLight,
                     ),
                     child: DateFieldWidget(
                       date: controller.period1From.value,
                       label: "من",
                       hideBorder: true,
                       onComplete: (DateTime date) {
                         controller.period1From.value = date;
                       },
                     ),
                   ),
                   space,
                   Container(
                     width: size.width * 0.1,
                     height: size.height * 0.06,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: AppColors.appGreyLight,
                     ),
                     child: DateFieldWidget(
                       date: controller.period1TO.value,
                       label: "الي",
                       hideBorder: true,
                       onComplete: (DateTime date) {
                         controller.period1TO.value = date;
                       },
                     ),
                   )
                 ],
               ),
             ),
             spaceV,
             SizedBox(
               width: size.width,
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10),
                     child: SizedBox(
                       width: size.width * 0.06,
                       child: const TextWidget(
                         "فترة ثانية",
                         size: 15,
                         weight: FontWeight.bold,
                       ),
                     ),
                   ),
                   space,
                   Container(
                     width: size.width * 0.1,
                     height: size.height * 0.06,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: AppColors.appGreyLight,
                     ),
                     child: DateFieldWidget(
                       date: controller.period2From.value,
                       label: "من",
                       hideBorder: true,
                       onComplete: (DateTime date) {
                         controller.period2From.value = date;
                       },
                     ),
                   ),
                   space,
                   Container(
                     width: size.width * 0.1,
                     height: size.height * 0.06,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(15),
                       color: AppColors.appGreyLight,
                     ),
                     child: DateFieldWidget(
                       date: controller.period2TO.value,
                       label: "الي",
                       hideBorder: true,
                       onComplete: (DateTime date) {
                         controller.period2TO.value = date;
                       },
                     ),
                   )
                 ],
               ),
             ),
             spaceV,
             SizedBox(
               width: size.width,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   ButtonWidget(
                     text: "بحث", onPressed: () => controller.search(), buttonColor: Colors.green, contentPadding: const EdgeInsets.all(15),),
                   space,
                   ButtonWidget(text: "طباعة",
                     onPressed: (){},
                     contentPadding: const EdgeInsets.all(15),),
                   space,
                   ButtonWidget(
                     text: "رجوع", onPressed: () => Get.back(), buttonColor: Colors.redAccent, contentPadding: const EdgeInsets.all(15),)

                 ],
               ),
             )
           ],
          ),
        ),
      ),
    );
  }
}
