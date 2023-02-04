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
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/notifications/dto/response/find_notification_response.dart';
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
          // SizedBox(
          //   width: 250,
          //   child: TextFormField(
          //     keyboardType: TextInputType.number,
          //     onChanged: (value) {},
          //     decoration: InputDecoration(
          //         border: const OutlineInputBorder(),
          //         contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          //         hintText: "ابحث عن سند اشعار",
          //         isDense: true,
          //         filled: true,
          //         fillColor: Colors.white70,
          //         suffixIcon: IconButtonWidget(
          //           icon: Icons.search,
          //           onPressed: () => controller.searchByNotification(),
          //         )
          //     ),
          //     onFieldSubmitted: (_) => controller.searchByNotification(),
          //     controller: controller.notificationNumberController,
          //   ),
          // ),
          SizedBox(
            width: 250,
            child: Obx(() {
              return DropdownSearch<GalleryResponse>(
                items: controller.galleries,
                selectedItem: controller.searchedSelectedGallery.value,
                onChanged: controller.searchedSelectedGallery,
                itemAsString: (gallery) => gallery.name ?? "",
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "اختر معرض",
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: 250,
            child: TypeAheadFormField<FindCustomerResponse>(
                itemBuilder: (context, client) {
                  return SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("${client.name} ${client.code}"),
                    ),
                  );
                },
                suggestionsCallback: (filter) => controller.searchedCustomers,
                onSuggestionSelected: (customer){
                  controller.searchHeaderCustomerFieldFocusNode.unfocus();
                  controller.searchSelectedCustomer(customer);
                  controller.getCustomerInvoices();
                },
                textFieldConfiguration: TextFieldConfiguration(
                  textInputAction: TextInputAction.next,
                  controller: controller.searchHeaderCustomerController,
                  focusNode: controller.searchHeaderCustomerFieldFocusNode,
                  onSubmitted: (_) => controller.getCustomersByCodeForSearch(),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: "ابحث عن عميل",
                      isDense: true,
                      hintMaxLines: 2,
                      contentPadding: const EdgeInsets.all(5),
                      suffixIconConstraints: const BoxConstraints(maxWidth: 50),
                      suffixIcon: IconButtonWidget(
                        icon: Icons.search,
                        onPressed: () {
                          controller.getCustomersByCodeForSearch();
                        },
                      )),
                )),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: 250,
            child: TypeAheadFormField<FindNotificationResponse>(
                itemBuilder: (context, inv) {
                  return SizedBox(
                    height: 50,
                    child: Center(
                      child: Text("${inv.serial}"),
                    ),
                  );
                },
                suggestionsCallback: (filter) => controller.customerInvoices.where((element) => element.serial.toString().contains(filter)),
                onSuggestionSelected: (inv){
                  controller.customerInvoiceController.text = inv.serial?.toString()??"";
                  controller.customerInvoiceFieldFocusNode.unfocus();
                  controller.searchByNotification();
                },
                textFieldConfiguration: TextFieldConfiguration(
                  textInputAction: TextInputAction.next,
                  controller: controller.customerInvoiceController,
                  focusNode: controller.customerInvoiceFieldFocusNode,
                  onSubmitted: (_) => controller.searchByNotification(),
                  decoration: InputDecoration(
                    hintText: "ابحث عن اشعار",
                      border: const OutlineInputBorder(),
                      isDense: true,
                      hintMaxLines: 2,
                      contentPadding: const EdgeInsets.all(5),
                      suffixIconConstraints: const BoxConstraints(maxWidth: 50),
                      suffixIcon: IconButtonWidget(
                        icon: Icons.search,
                        onPressed: () {
                          controller.searchByNotification();
                        },
                      )),
                )),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
            child: Obx(() {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(permission?.edit ?? false)
                  ButtonWidget(text: "إضافة", onPressed: () => controller.addNotification(),margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                  if((permission?.edit ?? false) || controller.invoice.value?.id == null)
                    ButtonWidget(text: "حفظ", onPressed: () => controller.saveNotification(),margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                  if((permission?.add ?? false))
                    ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice(),margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                  if(controller.notification.value?.id != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(permission?.edit ?? false)
                          ButtonWidget(text: "طباعة قيد", onPressed: () => controller.printGeneralJournal(context),margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                        if((permission?.delete ?? false) && controller.invoice.value?.id != null)
                          ButtonWidget(text: "حذف", onPressed: () => controller.deleteNotification(),margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                      ],
                    ),
                  ButtonWidget(text: "رجوع", onPressed: () => Get.back(),margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

}
