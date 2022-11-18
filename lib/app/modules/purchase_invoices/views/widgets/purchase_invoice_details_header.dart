import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/double_filter.dart';
import 'package:toby_bills/app/data/model/inventory/dto/response/inventory_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../controllers/purchase_invoices_controller.dart';

class PurchaseInvoiceDetailsHeaderWidget extends GetView<PurchaseInvoicesController> {
  const PurchaseInvoiceDetailsHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const separator = SizedBox(width: 5);
    return Container(
      color: Colors.grey[400],
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text(
                          "البند",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: TypeAheadFormField<ItemResponse>(
                          suggestionsCallback: (filter) => controller.filterItems(filter),
                          onSuggestionSelected: controller.selectItem,
                          itemBuilder: (context, item) {
                            return Center(
                              child: Text("${item.name} ${item.code}"),
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
                                if(controller.selectedItem.value != null){
                                  controller.itemQuantityFocusNode.requestFocus();
                                  return;
                                }
                                if (controller.itemNameController.text.isNotEmpty) {
                                  controller.selectItem(items.first);
                                }
                              }),
                        ),
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
                          "ع بـ الياردة",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                          focusNode: controller.itemYardNumberFocusNode,
                          enabled: controller.selectedItem.value != null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                          inputFormatters: [doubleInputFilter],
                          controller: controller.itemYardNumberController,
                          onFieldSubmitted: (_) => controller.itemQuantityFocusNode.requestFocus(),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              controller.itemYardNumberController.text = "0";
                            }
                            final yardNumber = controller.itemYardNumberController.text.parseToNum * 0.9;
                            controller.itemQuantityController.text = yardNumber.toStringAsFixed(2);
                            controller.calcItemData();
                          },
                        ),
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
                          "العدد",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          textDirection: TextDirection.ltr,
                          focusNode: controller.itemQuantityFocusNode,
                          textAlign: TextAlign.center,
                          enabled: controller.selectedItem.value != null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                          /////////////quantity
                          onEditingComplete: () => controller.itemPriceFocusNode.requestFocus(),
                          controller: controller.itemQuantityController,
                          inputFormatters: [doubleInputFilter],
                          onChanged: (value) {
                            if (value.isEmpty) {
                              controller.itemQuantityController.text = "0";
                            }
                            controller.calcItemData();
                          },
                        ),
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
                          "السعر",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          focusNode: controller.itemPriceFocusNode,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          enabled: controller.selectedItem.value != null,
                          inputFormatters: [doubleInputFilter],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              controller.itemPriceController.text = "0";
                            }
                            controller.calcItemData();
                          },
                          controller: controller.itemPriceController,
                          onEditingComplete: () {
                            controller.itemDiscountFocusNode.requestFocus();
                          },
                        ),
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
                          " الخصم",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: TextFormField(
                          focusNode: controller.itemDiscountFocusNode,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          inputFormatters: [doubleInputFilter],
                          enabled: controller.selectedItem.value != null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.white70,
                          ),
                          onChanged: (value) {
                            if (value.isEmpty || value.tryToParseToNum == null) {
                              controller.itemDiscountController.text = "0";
                            }
                            if (controller.itemDiscountController.text.parseToNum > 100) {
                              controller.itemDiscountController.text = "100";
                            }
                            // controller.itemDiscountValueController.text = "0";
                            controller.calcItemData();
                          },
                          controller: controller.itemDiscountController,
                          onEditingComplete: () {
                            controller.itemGlAccountFocusNode.requestFocus();
                          },
                        ),
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
                          "الاجمالي",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(child: Obx(() {
                            return Text(controller.itemNet.value?.toString() ?? "");
                          }))),
                    ],
                  ),
                ),
                separator,
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "الحساب",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        // width: 50,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TypeAheadFormField<GlAccountResponse>(
                            itemBuilder: (context, client) {
                              return SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text("${client.name} ${client.accNumber}"),
                                ),
                              );
                            },
                            suggestionsCallback: (filter) => controller.glAccounts.where((element) => (element.name??"").contains(filter) || element.accNumber.toString().contains(filter)),
                            onSuggestionSelected: (value) async {
                              controller.itemGlAccountController.text = "${value.name} ${value.accNumber}";
                              controller.selectedGlAccount(value);
                              controller.addNewInvoiceDetail();
                            },
                            textFieldConfiguration: TextFieldConfiguration(
                              textInputAction: TextInputAction.next,
                              controller: controller.itemGlAccountController,
                              focusNode: controller.itemGlAccountFocusNode,
                              decoration:  const InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                  hintMaxLines: 2,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 13),
                                  suffixIconConstraints: BoxConstraints(maxWidth: 50)
                              ),
                            )),
                      ),
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
                          "المستودع",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Obx(() {
                        return DropdownSearch<InventoryResponse>(
                          // showSearchBox: true,
                          items: controller.inventories,
                          itemAsString: (InventoryResponse e) => e.code,
                          onChanged: controller.selectInventory,
                          selectedItem: controller.selectedInventory.value,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(),
                                fillColor: Colors.white70,
                                isDense: true,
                                filled: true,
                                suffixIconConstraints: BoxConstraints(maxHeight: 30)),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                separator,
                Expanded(
                  child: Obx(() {
                    if (controller.selectedItem.value == null) {
                      return const SizedBox.shrink();
                    }
                    return IconButtonWidget(
                      onPressed: () => controller.addNewInvoiceDetail(),
                      icon: Icons.done_rounded,
                    );
                  }),
                ),
                separator,
              ],
            );
          })),
    );
  }
}
