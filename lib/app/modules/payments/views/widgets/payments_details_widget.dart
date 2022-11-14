import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/response/cost_center_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/modules/payments/controllers/payments_controller.dart';
import '../../../../components/icon_button_widget.dart';
import '../../../../core/utils/double_filter.dart';
import '../../../../data/model/inventory/dto/response/inventory_response.dart';

class PaymentsDetailsWidget extends GetView<PaymentsController> {
  const PaymentsDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const separator = SizedBox(width: 5);
    return Obx(() {
      final details = controller.details;
      return ListView.separated(
        itemCount: details.length,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final detail = details[index];
          return GetBuilder<PaymentsController>(
            id: index.toString(),
            builder: (_){
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: TypeAheadFormField<FindCustomerResponse>(
                        itemBuilder: (context, client) {
                          return SizedBox(
                            height: 50,
                            child: Center(
                              child: Text("${client.name} ${client.code}"),
                            ),
                          );
                        },
                        suggestionsCallback: (filter) => controller.customers.where((element) => (element.name??"").contains(filter) || (element.code??"").contains(filter)),
                        onSuggestionSelected: (value){
                          detail.textFieldController1.text = "${value.name} ${value.code}";
                          detail.textFieldController2.clear();
                          detail.focusNode1.unfocus();
                          controller.getInvoiceListForCustomer(value,(){
                            detail.focusNode2.requestFocus();
                          });
                        },
                        validator: (value){
                          if((value??"").isEmpty){
                            return "مطلوب";
                          }
                          return null;
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          textInputAction: TextInputAction.next,
                          controller: detail.textFieldController1,
                          focusNode: detail.focusNode1,
                          onEditingComplete: () {
                            detail.focusNode1.unfocus();
                            controller.getCustomers(detail.textFieldController1.text).whenComplete(() => detail.focusNode1.requestFocus());
                          },
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              isDense: true,
                              hintMaxLines: 2,
                              contentPadding: const EdgeInsets.all(5),
                              suffixIcon: IconButtonWidget(
                                icon: Icons.search,
                                onPressed: () {
                                  detail.focusNode1.unfocus();
                                  controller.getCustomers(detail.textFieldController1.text).whenComplete(() => detail.focusNode1.requestFocus());
                                },
                              )),
                        )),
                  ),
                  separator,
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
                          return (controller.findCustomerBalanceResponse[detail.invOrganizationSiteId] != null)
                              ? controller.findCustomerBalanceResponse[detail.invOrganizationSiteId]!.invoicesList.where((element) => element.serial != null && element.serial.toString().contains(filter)).toList()
                              : [];
                        },
                        onSuggestionSelected: (value) {
                          detail.invoiceId = value.id;
                          detail.invoiceSerial = value.serial;
                          detail.textFieldController2.text = "${value.serial}";
                        },
                        validator: (value){
                          if((value??"").isEmpty){
                            return "مطلوب";
                          }
                          return null;
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13.5),
                          ),
                          onSubmitted: (filter){
                            if(controller.findCustomerBalanceResponse[detail.invOrganizationSiteId] == null) return;
                            final invoices = controller.findCustomerBalanceResponse[detail.invOrganizationSiteId]!.invoicesList.where((element) => element.serial != null && element.serial.toString().contains(filter)).toList();
                            if(invoices.isEmpty) return;
                            final inv = invoices.first;
                            detail.invoiceId = inv.id;
                            detail.invoiceSerial = inv.serial;
                            detail.textFieldController2.text = "${inv.serial}";
                          },
                          controller: detail.textFieldController2,
                          focusNode: detail.focusNode2,
                        )),
                  ),
                  separator,
                  Expanded(
                    flex: 2,
                    child: TypeAheadFormField<GlAccountResponse>(
                        itemBuilder: (context, account) {
                          return SizedBox(
                            height: 50,
                            child: Center(
                              child: Text("${account.name} ${account.accNumber}"),
                            ),
                          );
                        },
                        suggestionsCallback: (filter) {
                          return controller.accounts.where((element) => (element.name??"").contains(filter) || (element.shotCode??"").contains(filter)).toList();
                        },
                        onSuggestionSelected: (account) {
                          detail.glAccountDebitCode = account.accNumber;
                          detail.glAccountDebitId = account.id;
                          detail.glAccountDebitName = account.name;
                          detail.textFieldController3.text = "${account.name} ${account.accNumber}";
                        },
                        validator: (value){
                          if((value??"").isEmpty){
                            return "مطلوب";
                          }
                          return null;
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          onSubmitted: (filter){
                            final list = controller.accounts.where((element) => (element.name??"").contains(filter) || (element.shotCode??"").contains(filter)).toList();
                            if(list.isEmpty) return;
                            final account = list.first;
                            detail.glAccountDebitCode = account.accNumber;
                            detail.glAccountDebitId = account.id;
                            detail.glAccountDebitName = account.name;
                            detail.textFieldController3.text = "${account.name} ${account.accNumber}";
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13.5),
                          ),
                          controller: detail.textFieldController3,
                          focusNode: detail.focusNode3,
                        )
                    ),
                  ),
                  separator,
                  Expanded(
                    flex: 2,
                    child: TypeAheadFormField<GlAccountResponse>(
                        itemBuilder: (context, account) {
                          return SizedBox(
                            height: 50,
                            child: Center(
                              child: Text("${account.name} ${account.accNumber}"),
                            ),
                          );
                        },
                        suggestionsCallback: (filter) {
                          return controller.accounts.where((element) => (element.name??"").contains(filter) || (element.shotCode??"").contains(filter)).toList();
                        },
                        onSuggestionSelected: (account) {
                          detail.glAccountCreditCode = account.accNumber;
                          detail.glAccountCreditId = account.id;
                          detail.glAccountCreditName = account.name;
                          detail.textFieldController4.text = "${account.name} ${account.accNumber}";
                        },
                        validator: (value){
                          if((value??"").isEmpty){
                            return "مطلوب";
                          }
                          return null;
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          onSubmitted: (filter){
                            final list = controller.accounts.where((element) => (element.name??"").contains(filter) || (element.shotCode??"").contains(filter)).toList();
                            if(list.isEmpty) return;
                            final account = list.first;
                            detail.glAccountCreditCode = account.accNumber;
                            detail.glAccountCreditId = account.id;
                            detail.glAccountCreditName = account.name;
                            detail.textFieldController4.text = "${account.name} ${account.accNumber}";
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13.5),
                          ),
                          controller: detail.textFieldController4,
                          focusNode: detail.focusNode4,
                        )
                    ),
                  ),
                  separator,
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      inputFormatters: [doubleInputFilter],
                      validator: (value){
                        if((value??"").isEmpty){
                          return "مطلوب";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                      ),
                      onChanged: (v) => detail.value = v.tryToParseToNum??0,
                      controller: detail.textFieldController5,
                      focusNode: detail.focusNode5,
                    ),
                  ),
                  separator,
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      inputFormatters: [doubleInputFilter],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                      ),
                      onChanged: (v) => detail.bankCommition = v.tryToParseToNum??0,
                      controller: detail.textFieldController6,
                      focusNode: detail.focusNode6,
                      onEditingComplete: () {
                      },
                    ),
                  ),
                  separator,
                  Expanded(
                    flex: 2,
                    child: TypeAheadFormField<CostCenterResponse>(
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
                        onSuggestionSelected: (center) {
                          detail.costCenterName = center.name;
                          detail.costCenterCode = center.code;
                          detail.costCenterId = center.id;
                          detail.textFieldController7.text = center.name??"";
                        },
                        validator: (value){
                          if((value??"").isEmpty){
                            return "مطلوب";
                          }
                          return null;
                        },
                        textFieldConfiguration: TextFieldConfiguration(
                          onSubmitted: (filter){
                            final list = controller.costCenters.where((element) => (element.name??"").contains(filter) || (element.code?.toString()??"").contains(filter)).toList();
                            if(list.isEmpty) return;
                            final center = list.first;
                            detail.costCenterName = center.name;
                            detail.costCenterCode = center.code;
                            detail.costCenterId = center.id;
                            detail.textFieldController7.text = center.name??"";
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13.5),
                          ),
                          controller: detail.textFieldController7,
                          focusNode: detail.focusNode7,
                        )
                    ),
                  ),
                  separator,
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 13),
                      ),
                      controller: detail.textFieldController8,
                      focusNode: detail.focusNode8,
                      onChanged: (v) => detail.remarks = v,
                    ),
                  ),
                  separator,
                  Expanded(
                    child: Center(
                      child: IconButtonWidget(
                        onPressed: () => controller.details.removeAt(index),
                        icon: Icons.clear_rounded,
                      ),
                    ),
                  ),
                  separator,
                ],
              );
            },
          );
        },
      );
    });
  }
}
