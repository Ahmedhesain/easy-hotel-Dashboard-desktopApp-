import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/utils/double_filter.dart';
import 'package:toby_bills/app/data/model/inventory/dto/response/inventory_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

class InvoiceDetailsHeaderWidget extends GetView<HomeController> {
  const InvoiceDetailsHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const separator = SizedBox(width: 5);
    return Container(
      color: Colors.grey[400],
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
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
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TypeAheadField<ItemResponse>(
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
                              onEditingComplete: () {
                                final items = controller.filterItems(controller.itemNameController.text);
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
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.number,
                          focusNode: controller.itemNumberFocusNode,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero,
                          ),
                          textAlign: TextAlign.center,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: controller.itemNumberController,
                          onFieldSubmitted: controller.onItemNumberFieldSubmitted,
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
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          focusNode: controller.itemQuantityFocusNode,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
                          /////////////quantity
                          onEditingComplete: () => controller.itemPriceFocusNode.requestFocus(),
                          controller: controller.itemQuantityController,
                          readOnly: controller.selectedItem.value != null && controller.selectedItem.value!.proGroupId == 1,
                          inputFormatters: [doubleInputFilter],
                          onChanged: controller.onChangeItemQuantity,
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
                            return Text(controller.itemQuantity.value?.toString() ?? "");
                          }))),
                    ],
                  ),
                ),
                separator,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 5),
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            focusNode: controller.itemPriceFocusNode,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
                            controller: controller.itemPriceController,
                            onEditingComplete: () {
                              controller.itemNotesFocusNode.requestFocus();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 5),
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
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Obx(() {
                              return Text(controller.itemDiscount.value?.toString() ?? "");
                            }),
                          ),
                        ),
                      ],
                    ),
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
                          child: Obx(() {
                            return Text(
                              controller.itemNet.value?.toString() ?? "",
                            );
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
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: controller.itemNotesController,
                          focusNode: controller.itemNotesFocusNode,
                          onEditingComplete: () => controller.addNewInvoiceDetail(),
                          decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
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
                          return Checkbox(value: controller.isItemProof.value, activeColor: Colors.green, onChanged: controller.isItemProof);
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
                      Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Obx(() {
                            return DropdownSearch<InventoryResponse>(
                              // showSearchBox: true,
                              items: controller.inventories,
                              itemAsString: (InventoryResponse e) => e.code,
                              onChanged: controller.selectInventory,
                              selectedItem: controller.selectedInventory.value,
                            );
                          })),
                    ],
                  ),
                ),
                separator,
                Expanded(
                  child: controller.selectedItem.value == null
                      ? const SizedBox.shrink()
                      : IconButtonWidget(onPressed: () => controller.addNewInvoiceDetail(), icon: Icons.done_rounded),
                ),
                separator,
              ],
            ),
          ])),
    );
  }
}
