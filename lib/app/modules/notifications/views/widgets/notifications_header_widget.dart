import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_widget.dart';
import 'package:toby_bills/app/core/utils/double_filter.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/modules/notifications/controllers/notifications_controller.dart';

import '../../../../data/model/customer/dto/response/find_customer_balance_response.dart';

class NotificationsHeaderWidget extends GetView<NotificationsController> {
  const NotificationsHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.width * .05,
        ),
        Expanded(
          child: Column(
            children: [
              Obx(() {
                return Material(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          value: 0,
                          groupValue: controller.notificationType.value,
                          title: const Text("اشعار مدين"),
                          onChanged: controller.notificationType,
                          activeColor: AppColors.colorYellow,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: 1,
                          groupValue: controller.notificationType.value,
                          title: const Text("اشعار خصم"),
                          onChanged: controller.notificationType,
                          activeColor: AppColors.colorYellow,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          value: 2,
                          groupValue: controller.notificationType.value,
                          title: const Text("اشعار دائن"),
                          onChanged: controller.notificationType,
                          activeColor: AppColors.colorYellow,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    const Expanded(child: Text("ابحث عن فاتورة لعميل معين")),
                    Expanded(
                      child: TypeAheadFormField<FindCustomerResponse>(
                          itemBuilder: (context, client) {
                            return SizedBox(
                              height: 50,
                              child: Center(
                                child: Text("${client.name} ${client.code}"),
                              ),
                            );
                          },
                          suggestionsCallback: (filter) => controller.customers,
                          onSuggestionSelected: controller.getInvoiceListForCustomer,
                          textFieldConfiguration: TextFieldConfiguration(
                            textInputAction: TextInputAction.next,
                            controller: controller.findSideCustomerController,
                            focusNode: controller.findSideCustomerFieldFocusNode,
                            onEditingComplete: () => controller.getCustomersByCode(),
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                isDense: true,
                                hintMaxLines: 2,
                                contentPadding: const EdgeInsets.all(5),
                                suffixIconConstraints: const BoxConstraints(maxWidth: 50),
                                suffixIcon: IconButtonWidget(
                                  icon: Icons.search,
                                  onPressed: () {
                                    controller.getCustomersByCode();
                                  },
                                )),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    const Expanded(child: Text("ابحث عن رقم الفاتورة")),
                    Expanded(
                      child: TypeAheadFormField<InvoiceList>(
                          itemBuilder: (context, inv) {
                            return SizedBox(
                              height: 50,
                              child: Center(
                                child: Text((inv.serial).toString()),
                              ),
                            );
                          },
                          suggestionsCallback: (filter) {
                            return (controller.findCustomerBalanceResponse != null)
                                ? controller.findCustomerBalanceResponse!.invoicesList.where((element) => element.serial != null).toList()
                                : [];
                          },
                          onSuggestionSelected: (value) {
                            controller.searchForInvoiceById(value.serial.toString());
                          },
                          textFieldConfiguration: TextFieldConfiguration(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                // contentPadding: EdgeInsets.symmetric(horizontal: 5)
                              ),
                              controller: controller.searchedInvoiceController)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        SizedBox(
          width: context.width * .1,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: Text("التاريخ")),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final date = await showDatePicker(
                              context: context,
                              initialDate: controller.date.value??DateTime.now(),
                              firstDate: DateTime(2016),
                              lastDate: DateTime.now(),
                          );
                          if(date != null){
                            controller.date(date);
                          }
                        },
                        child: Obx(
                          () {
                            return Text(
                              controller.date.value == null ? "dd/mm/yyyy" : DateFormat("dd/MM/yyyy").format(controller.date.value!),
                              style: const TextStyle(decoration: TextDecoration.underline),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(child: Text("المبلغ")),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                        inputFormatters: [doubleInputFilter],
                        controller: controller.priceController,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(child: Text("ملحوظات")),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                        controller: controller.remarksController,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(child: Text("المعرض")),
                    Expanded(
                      child: Obx(() {
                        return DropdownSearch<GalleryResponse>(
                          items: controller.galleries,
                          selectedItem: controller.selectedGallery.value,
                          onChanged: controller.selectedGallery,
                          itemAsString: (gallery) => gallery.name ?? "",
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: context.width * .05,
        ),
      ],
    );
  }
}
