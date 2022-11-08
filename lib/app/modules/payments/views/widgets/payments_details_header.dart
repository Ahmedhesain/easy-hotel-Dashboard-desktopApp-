import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/double_filter.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/response/cost_center_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/inventory/dto/response/inventory_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/modules/payments/controllers/payments_controller.dart';

import '../../../../data/model/customer/dto/response/find_customer_balance_response.dart';


class PaymentsDetailsHeaderWidget extends GetView<PaymentsController> {
  const PaymentsDetailsHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const separator = SizedBox(width: 5);
    return Container(
      color: Colors.grey[400],
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Text(
                        "اسم جهة التعامل",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TypeAheadFormField<FindCustomerResponse>(
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
                          onEditingComplete: () => controller.getCustomers(),
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              hintMaxLines: 2,
                              contentPadding: const EdgeInsets.all(5),
                              suffixIcon: IconButtonWidget(
                                icon: Icons.search,
                                onPressed: () {
                                  controller.getCustomers();
                                },
                              )),
                        )),
                  ],
                ),
              ),
              separator,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Text(
                        "الفواتير",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TypeAheadFormField<InvoiceList>(
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
                              ? controller.findCustomerBalanceResponse!.invoicesList.where((element) => element.serial != null && element.serial.toString().contains(filter)).toList()
                              : [];
                        },
                        onSuggestionSelected: (value) {
                          controller.selectInvoice(value.serial.toString());
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13.5),
                            ),
                            onSubmitted: (filter){
                              final invoices = controller.findCustomerBalanceResponse!.invoicesList.where((element) => element.serial != null && element.serial.toString().contains(filter)).toList();
                              if(invoices.isEmpty) return;
                              final inv = invoices.first;
                              controller.selectInvoice(inv.serial.toString());
                            },
                            focusNode: controller.searchedItemInvoiceFocusNode,
                            controller: controller.searchedItemInvoiceController))
                  ],
                ),
              ),
              separator,
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Text(
                        "المدين",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TypeAheadFormField<GlAccountResponse>(
                        itemBuilder: (context, account) {
                          return SizedBox(
                            height: 50,
                            child: Center(
                              child: Text("${account.name} ${account.shotCode}"),
                            ),
                          );
                        },
                        suggestionsCallback: (filter) {
                          return controller.accounts.where((element) => (element.name??"").contains(filter) || (element.shotCode??"").contains(filter)).toList();
                        },
                        onSuggestionSelected: (value) {
                          controller.selectAccount(value);
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                            onSubmitted: (filter){
                              final list = controller.accounts.where((element) => (element.name??"").contains(filter) || (element.shotCode??"").contains(filter)).toList();
                              if(list.isEmpty) return;
                              controller.selectAccount(list.first);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13.5),
                            ),
                            focusNode: controller.itemAccountFocusNode,
                            controller: controller.itemAccountController
                        )
                    )
                  ],
                ),
              ),
              separator,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Text(
                        "المبلغ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      inputFormatters: [doubleInputFilter],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                      ),
                      onChanged: (value) {
                      },
                      controller: controller.itemPriceController,
                      focusNode: controller.itemPriceFocusNode,
                      onEditingComplete: () {
                        controller.itemCommissionFocusNode.requestFocus();
                      },
                    ),
                  ],
                ),
              ),
              separator,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Text(
                        "العمولة",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      inputFormatters: [doubleInputFilter],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                      ),
                      onChanged: (value) {
                      },
                      controller: controller.itemCommissionController,
                      focusNode: controller.itemCommissionFocusNode,
                      onEditingComplete: () {
                        controller.itemCenterFocusNode.requestFocus();
                      },
                    ),
                  ],
                ),
              ),
              separator,
              Expanded(
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "كود التكلفة",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TypeAheadFormField<CostCenterResponse>(
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
                          controller.selectCenter(value);
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                            onSubmitted: (filter){
                              final list = controller.costCenters.where((element) => (element.name??"").contains(filter) || (element.code?.toString()??"").contains(filter)).toList();
                              if(list.isEmpty) return;
                              controller.selectCenter(list.first);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13.5),
                            ),
                            focusNode: controller.itemCenterFocusNode,
                            controller: controller.itemCenterController
                        )
                    )
                  ],
                ),
              ),
              separator,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Text(
                        "البيان",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                      ),
                      controller: controller.itemRemarksController,
                      focusNode: controller.itemRemarksFocusNode,
                      onEditingComplete: () {

                      },
                    ),
                  ],
                ),
              ),
              separator,
              Expanded(
                child: Obx(() {
                  controller.selectedAccount.value;
                  // if (controller.selectedItem.value == null) {
                  //   return const SizedBox.shrink();
                  // }
                  return IconButtonWidget(
                    onPressed: () {},
                    icon: Icons.done_rounded,
                  );
                }),
              ),
              separator,
            ],
          )),
    );
  }
}
