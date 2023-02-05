import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/double_filter.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/inventory/dto/response/inventory_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

class InvoiceDetailsHeaderWidget extends GetView<HomeController> {
  const InvoiceDetailsHeaderWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const separator = SizedBox(width: 5);
    return Scrollable(
      viewportBuilder: (BuildContext context, ViewportOffset position) {
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
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Center(
                            child: Text(
                              "الصنف",
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
                                return Container(
                                  color: Colors.grey,
                                  child: Center(
                                    child: Text("${item.name} ${item.code}"),
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
                                    if(controller.selectedItem.value != null){
                                      controller.itemNumberFocusNode.requestFocus();
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
                              keyboardType: TextInputType.number,
                              focusNode: controller.itemNumberFocusNode,
                              enabled: controller.selectedItem.value != null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.white70,
                              ),
                              textAlign: TextAlign.center,
                              inputFormatters: [doubleInputFilter],
                              controller: controller.itemNumberController,
                              onFieldSubmitted: controller.onItemNumberFieldSubmitted,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  controller.itemNumberController.text = "0";
                                }
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
                              "الكميه",
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
                              enabled: !(controller.selectedItem.value == null || (controller.selectedItem.value != null && controller.selectedItem.value!.proGroupId == 1)),
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
                              "ك الكليه",
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
                                return Text(controller.itemTotalQuantity.value?.toString() ?? "");
                              }))),
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
                              enabled: (controller.selectedItem.value != null && (controller.selectedItem.value?.isRequiredEditPrivilege != 1 || UserManager().itemsEditPerivilege.contains(controller.selectedItem.value?.id))),
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
                              },
                              controller: controller.itemPriceController,
                              onEditingComplete: () {
                                controller.itemPriceListener();
                                if(controller.canEdit) {
                                  controller.itemDiscountFocusNode.requestFocus();
                                } else {
                                  controller.itemNotesFocusNode.requestFocus();
                                }
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
                              // enabled: controller.selectedItem.value != null,
                              enabled: controller.canEdit,
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
                                controller.itemDiscountValueController.text = "0";
                                controller.calcItemData();
                              },
                              controller: controller.itemDiscountController,
                              onEditingComplete: () {
                                controller.itemDiscountValueFocusNode.requestFocus();
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
                              "خ قيمة",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: TextFormField(
                              focusNode: controller.itemDiscountValueFocusNode,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.ltr,
                              inputFormatters: [doubleInputFilter],
                              enabled: controller.canEdit,
                              // enabled: controller.selectedItem.value != null,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.white70,
                              ),
                              onChanged: (value) {
                                if (value.isEmpty || value.tryToParseToNum == null) {
                                  controller.itemDiscountValueController.text = "0";
                                }
                                if ((controller.itemDiscountValueController.text.tryToParseToNum??0) > controller.itemNetWithoutDiscount) {
                                  controller.itemDiscountValueController.text = controller.itemNetWithoutDiscount.toString();
                                }
                                controller.itemDiscountController.text = "0";
                                controller.calcItemData();
                              },
                              controller: controller.itemDiscountValueController,
                              onEditingComplete: () {
                                controller.itemNotesFocusNode.requestFocus();
                              },
                            ),
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
                              "الصافي",
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
                            child: Center(
                              child: Obx(() =>
                                  Text(
                                    controller.itemNet.value?.toString() ?? "",
                                  )),
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
                              "ك م",
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
                            child: Center(
                              child: Obx(() {
                                return Text(controller.itemAvailableQuantity.value?.toString() ?? "");
                              }),
                            ),
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
                              "ملاحظات",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: TextFormField(
                              controller: controller.itemNotesController,
                              focusNode: controller.itemNotesFocusNode,
                              onEditingComplete: () => controller.addNewInvoiceDetail(),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                filled: true,
                                fillColor: Colors.white70,
                              ),
                            ),
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
                              "قيمة إشعار",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: TextFormField(
                              controller: controller.itemNoticeController,
                              focusNode: controller.itemNoticeFocusNode,
                              inputFormatters: [doubleInputFilter],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                filled: true,
                                fillColor: Colors.white70,
                              ),
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
                              "بروفه",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Obx(() {
                              return Checkbox(
                                value: controller.isItemProof.value,
                                activeColor: Colors.green,
                                onChanged: controller.isItemProof,
                              );
                            }),
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
                              "بواقي",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: Obx(() {
                              return Checkbox(
                                value: controller.isItemRemains.value,
                                activeColor: Colors.green,
                                onChanged: controller.isItemRemains,
                              );
                            }),
                          )
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
                              itemAsString: (InventoryResponse e) => e.code.toString(),
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
      },
    );
  }
}
