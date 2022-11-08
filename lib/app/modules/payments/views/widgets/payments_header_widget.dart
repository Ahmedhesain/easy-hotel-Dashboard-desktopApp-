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
import 'package:toby_bills/app/data/model/cost_center/dto/response/cost_center_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/modules/notifications/controllers/notifications_controller.dart';

import '../../../../data/model/customer/dto/response/find_customer_balance_response.dart';
import '../../controllers/payments_controller.dart';

class PaymentsHeaderWidget extends GetView<PaymentsController> {
  const PaymentsHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: context.width * .05),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: Text("مسلسل")),
                    Expanded(
                      child: Obx(() {
                        return Text(controller.payment.value?.id.toString() ?? "");
                      }),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(child: Text("البيان")),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {},
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        SizedBox(width: context.width * .1),
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
                            initialDate: controller.date.value ?? DateTime.now(),
                            firstDate: DateTime(2016),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
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
                    const Expanded(child: Text("مناولة")),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                        controller: controller.monawlaController,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(child: Text("رقم الحساب الدائن")),
                    Expanded(
                      child: Obx(() {
                        return TypeAheadFormField<GlAccountResponse>(
                            key: UniqueKey(),
                            initialValue: controller.selectedAccount.value?.name,
                            itemBuilder: (context, account) {
                              return SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text("${account.name}"),
                                ),
                              );
                            },
                            suggestionsCallback: (filter) {
                              return controller.accounts.where((element) => (element.name??"").contains(filter) || (element.accNumber?.toString()??"").contains(filter)).toList();
                            },
                            onSuggestionSelected: (value) {
                              controller.selectedAccount(value);
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                                onSubmitted: (filter){
                                  final list = controller.accounts.where((element) => (element.name??"").contains(filter) || (element.accNumber?.toString()??"").contains(filter)).toList();
                                  if(list.isEmpty) return;
                                  controller.selectedAccount(list.first);
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13.5),
                                ),
                            )
                        );
                      }),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(child: Text("مركز التكلفة")),
                    Expanded(
                      child: Obx(() {
                        return TypeAheadFormField<CostCenterResponse>(
                            key: UniqueKey(),
                            initialValue: controller.selectedCenter.value?.name,
                            itemBuilder: (context, center) {
                              return SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text("${center.name}"),
                                ),
                              );
                            },
                            suggestionsCallback: (filter) {
                              return controller.costCenters.where((element) => (element.name??"").contains(filter) || (element.code?.toString()??"").contains(filter)).toList();
                            },
                            onSuggestionSelected: (value) {
                              controller.selectedCenter(value);
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                              onSubmitted: (filter){
                                final list = controller.costCenters.where((element) => (element.name??"").contains(filter) || (element.code?.toString()??"").contains(filter)).toList();
                                if(list.isEmpty) return;
                                controller.selectedCenter(list.first);
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13.5),
                              ),
                            )
                        );
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: context.width * .05),
      ],
    );
  }

}
