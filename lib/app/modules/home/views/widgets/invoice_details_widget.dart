import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../../components/icon_button_widget.dart';
import '../../../../core/utils/double_filter.dart';
import '../../../../data/model/inventory/dto/response/inventory_response.dart';

class InvoiceDetailsWidget extends GetView<HomeController> {
  const InvoiceDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    const separator = SizedBox(width: 5);
    return Obx(() {
      final details = controller.invoiceDetails;
      return ListView.separated(
        itemCount: details.length,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        separatorBuilder: (_,__) => const Divider(),
        itemBuilder: (context, index) {
          return Obx(() {
            InvoiceDetailsModel detail = details[index].value;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 30,
                    child: TypeAheadField<ItemResponse>(
                      suggestionsCallback: (filter) => controller.filterItems(filter),
                      onSuggestionSelected: (item) => controller.getItemData(itemId: item.id, onSuccess: (itemData) {
                        if(item.itemData!.availableQuantity != null && item.itemData!.availableQuantity == 0){
                          showPopupText(text: "لايوجد كمية متاحة");
                          details[index](detail.copyWith(
                            name: detail.name,
                            code: detail.code
                          ));
                          return;
                        }
                        item.itemData = itemData;
                        final newDetail = detail.assignItem(item);
                        details[index](newDetail);
                        controller.calcInvoiceValues();
                      }),
                      itemBuilder: (context, item) {
                        return Center(
                          child: Text("${item.name} ${item.code}"),
                        );
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: TextEditingController(text: "${detail.name} ${detail.code}"),
                          textInputAction: TextInputAction.next,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white70
                          ),
                          onSubmitted: (value) {
                            final items = controller.filterItems(value);
                            if (controller.itemNameController.text.isNotEmpty) {
                              controller.getItemData(itemId: items.first.id, onSuccess: (data) {});
                            }
                          }),
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: TextEditingController(text: detail.number?.toString()),
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                      focusNode: detail.numberFocus..addListener(() {
                        if(!detail.numberFocus.hasFocus){

                        }
                      }),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.white70
                      ),
                      textAlign: TextAlign.center,
                      inputFormatters: [doubleInputFilter],
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: TextEditingController(text: detail.quantity?.toString()),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.white70
                      ),
                      onEditingComplete: () {},
                      readOnly: detail.progroupId! == 1,
                      inputFormatters: [doubleInputFilter],
                      onChanged: (value) {},
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Text(((detail.number ?? 0) * (detail.quantity ?? 0)).toString()))),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: TextEditingController(text: detail.price.toString()),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      inputFormatters: [doubleInputFilter],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Colors.white70
                      ),
                      onEditingComplete: () {},
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: TextEditingController(text: detail.discount.toString()),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      inputFormatters: [doubleInputFilter],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.white70
                      ),
                      onEditingComplete: () {},
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: TextEditingController(text: detail.discountValue.toString()),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      inputFormatters: [doubleInputFilter],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.white70
                      ),
                      onEditingComplete: () {},
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: Container(
                    // width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(detail.net?.toString() ?? ""),
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(detail.availableQuantityRow?.toString() ?? "--"),
                    ),
                  ),
                ),
                separator,
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: TextEditingController(text: detail.remark),
                      onEditingComplete: () {},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          filled: true,
                          fillColor: Colors.white70
                      ),
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Checkbox(
                      value: detail.proof == 1,
                      activeColor: Colors.green,
                      onChanged: (value){
                        details[index](detail.copyWith(proof: value!?1:0));
                      },
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Checkbox(
                      value: detail.isRemains == 1,
                      activeColor: Colors.green,
                      onChanged: (value){
                        details[index](detail.copyWith(isRemains: value!?1:0));
                      },
                    ),
                  ),
                ),
                separator,
                Expanded(
                  flex: 2,
                  child: DropdownSearch<InventoryResponse>(
                    items: controller.inventories,
                    itemAsString: (InventoryResponse inventory) => inventory.code,
                    onChanged: (InventoryResponse? inventory) {
                      final item = controller.items.singleWhere((element) => element.id == detail.itemId);
                      controller.getItemData(itemId: item.id, inventoryId: inventory!.id, onSuccess: (itemData) {
                        if(item.itemData!.availableQuantity != null && item.itemData!.availableQuantity == 0){
                          showPopupText(text: "لايوجد كمية متاحة");
                          details[index](detail.copyWith(inventoryId: detail.inventoryId));
                          return;
                        }
                        item.itemData = itemData;
                        final newDetail = detail.assignItem(item);
                        details[index](newDetail);
                        controller.calcInvoiceValues();
                      });
                    },
                    selectedItem: controller.inventories.singleWhere((element) => element.id == detail.inventoryId),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                            suffixIconConstraints: BoxConstraints(maxHeight: 30))),
                  ),
                ),
                separator,
                Expanded(
                  child: IconButtonWidget(
                    onPressed: () {
                      controller.invoiceDetails.removeAt(index);
                      controller.calcInvoiceValues();
                    },
                    icon: Icons.clear,
                  ),
                ),
                separator,
              ],
            );
          });
        },
      );
    });
  }
}
