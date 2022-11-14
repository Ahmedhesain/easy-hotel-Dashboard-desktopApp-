import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toby_bills/app/data/model/cost_center/dto/response/cost_center_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/modules/sub_account_statement/controllers/sub_account_statement_controller.dart';

class SubAccountStatementHeaderWidget extends GetView<SubAccountStatementController> {
  const SubAccountStatementHeaderWidget({Key? key}) : super(key: key);

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
                    const Expanded(child: Text("من تاريخ")),
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => controller.pickFromDate(),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            child: Obx(() {
                              return Center(child: Text(controller.dateFrom.value == null ? "----/--/--" : DateFormat("yyyy/MM/dd").format(controller.dateFrom.value!)));
                            }),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Expanded(child: Text("الى تاريخ")),
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => controller.pickToDate(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Obx(() {
                              return Center(child: Text(controller.dateTo.value == null ? "----/--/--" : DateFormat("yyyy/MM/dd").format(controller.dateTo.value!)));
                            }),
                          ),
                        ),
                      ),
                    ),
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
                    const Expanded(child: Text("اسم الحساب")),
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
                              return controller.accounts.where((e) => (e.name ?? "").contains(filter) || (e.accNumber?.toString() ?? "").contains(filter));
                            },
                            onSuggestionSelected: controller.selectedAccount,
                            textFieldConfiguration: TextFieldConfiguration(
                              onSubmitted: (filter) {
                                final list = controller.accounts.where((e) => (e.name ?? "").contains(filter));
                                if (list.isNotEmpty) {
                                  controller.selectedAccount(list.first);
                                }
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 13.5),
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
                    const Expanded(child: Text("من مركز تكلفة")),
                    Expanded(
                      child: Obx(() {
                        return TypeAheadFormField<CostCenterResponse>(
                            key: UniqueKey(),
                            initialValue: controller.selectedCenterFrom.value?.name,
                            itemBuilder: (context, account) {
                              return SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text("${account.name}"),
                                ),
                              );
                            },
                            suggestionsCallback: (filter) {
                              return controller.costCenters.where((e) => (e.name ?? "").contains(filter));
                            },
                            onSuggestionSelected: controller.selectedCenterFrom,
                            textFieldConfiguration: TextFieldConfiguration(
                              onSubmitted: (filter) {
                                final list = controller.costCenters.where((e) => (e.name ?? "").contains(filter));
                                if (list.isNotEmpty) {
                                  controller.selectedCenterFrom(list.first);
                                }
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 13.5),
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
                    const Expanded(child: Text("الى مركز التكلفة")),
                    Expanded(
                      child: Obx(() {
                        return TypeAheadFormField<CostCenterResponse>(
                            key: UniqueKey(),
                            initialValue: controller.selectedCenterTo.value?.name,
                            itemBuilder: (context, account) {
                              return SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text("${account.name}"),
                                ),
                              );
                            },
                            suggestionsCallback: (filter) {
                              return controller.costCenters.where((e) => (e.name ?? "").contains(filter));
                            },
                            onSuggestionSelected: controller.selectedCenterTo,
                            textFieldConfiguration: TextFieldConfiguration(
                              onSubmitted: (filter) {
                                final list = controller.costCenters.where((e) => (e.name ?? "").contains(filter));
                                if (list.isNotEmpty) {
                                  controller.selectedCenterTo(list.first);
                                }
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 13.5),
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
