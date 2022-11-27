import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_styles.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/modules/notifications/controllers/notifications_controller.dart';

class NotificationsButtonsWidget extends GetView<NotificationsController> {
  const NotificationsButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    final permission = UserManager().user.userScreens["customeraddnotice"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 15.0),
      child: Row(
        children: [
          Text('المعرض  ',style: smallTextStyleNormal(size)),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Container(
              width: size.width * .2,
              height: size.height * .045,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(5)),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey)),
              child:
              Obx(() {
                return DropdownSearch<DeliveryPlaceResposne>(
                  // showSearchBox: true,
                  items: controller.deliveryPlaces,
                  itemAsString: (DeliveryPlaceResposne e) => e.name??"",
                  onChanged: controller.selectedDeliveryPlace,
                  selectedItem: controller.selectedDeliveryPlace.value,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                      isDense: true,
                    ),
                  ),
                );
              }),                                              ),
          ),
          // TypeAheadFormField<FindCustomerResponse>(
          //   key: UniqueKey(),
          //   itemBuilder: (context, client) {
          //     return Center(
          //       child: Text(client.name.toString(), textAlign: TextAlign.center),
          //     );
          //   },
          //   onSuggestionSelected: (FindCustomerResponse client) => controller.getInvoiceListForCustomer(client),
          //   suggestionsCallback: (filter) =>
          //       controller.customers.where((element) => element.name.toString().contains(filter) || element.code.toString().contains(filter)),
          //   textFieldConfiguration: TextFieldConfiguration(
          //       focusNode: controller.findSideCustomerFieldFocusNode,
          //       controller: controller.findSideCustomerController,
          //       onSubmitted: (value) => controller.getCustomersByCode(),
          //       decoration: InputDecoration(border: OutlineInputBorder(), hintText: "ابحث عن عميل", isDense: true)),
          //   noItemFoundText: "لايوجد بيانات",
          // ),

          SizedBox(
            width: 250,
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  hintText: "ابحث عن سند اشعار",
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white70,
                  suffixIcon: IconButtonWidget(
                    icon: Icons.search,
                    onPressed: () => controller.searchByNotification(),
                  )
              ),
              onFieldSubmitted: (_) => controller.searchByNotification(),
              controller: controller.notificationNumberController,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
            padding: const EdgeInsets.all(5),
            child: Obx(() {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ButtonWidget(text: "إضافة", onPressed: () => controller.addNotification()),
                  const SizedBox(width: 5),
                  if((permission?.edit ?? false) || controller.invoice.value?.id == null)
                    ButtonWidget(text: "حفظ", onPressed: () => controller.saveNotification()),
                  if((permission?.add ?? false))
                    const SizedBox(width: 5),
                  if((permission?.add ?? false))
                    ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice()),
                  if(controller.notification.value?.id != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 5),
                        ButtonWidget(text: "طباعة قيد", onPressed: () => controller.printGeneralJournal(context)),
                        if((permission?.delete ?? false) && controller.invoice.value?.id != null)
                          const SizedBox(width: 5),
                        if((permission?.delete ?? false) && controller.invoice.value?.id != null)
                          ButtonWidget(text: "حذف", onPressed: () => controller.deleteNotification()),
                      ],
                    ),
                  const SizedBox(width: 5),
                  ButtonWidget(text: "رجوع", onPressed: () => Get.back()),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

}
