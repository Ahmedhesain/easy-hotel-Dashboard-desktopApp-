import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
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
                          enabled: false,
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
                    child: Builder(
                      builder: (context) {
                        num? oldValue = detail.number;
                        return TextFormField(
                          controller: TextEditingController(text: detail.number?.toString()),
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => detail.number = value.tryToParseToNum ?? 0,
                          focusNode: detail.numberFocus..addListener(() {
                            if(!detail.numberFocus.hasFocus){
                              if(detail.availableQuantityRow != null && detail.availableQuantityRow! < detail.number! * detail.quantity!){
                                showPopupText(text: "لايمكن إضافة هذا العدد");
                                details[index](detail.copyWith(number: oldValue));
                              } else{
                                details[index](detail.copyWith(number: detail.number));
                              }
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
                        );
                      }
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Builder(
                      builder: (context) {
                        num? oldValue = detail.quantity;
                        return TextFormField(
                          controller: TextEditingController(text: detail.quantity?.toString()),
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          enabled: detail.progroupId! != 1,
                          onChanged: (value) => detail.quantity = value.tryToParseToNum ?? 0,
                          focusNode: detail.quantityFocus..addListener(() {
                            if(!detail.quantityFocus.hasFocus) {
                              if (detail.availableQuantityRow != null && detail.availableQuantityRow! < detail.number! * detail.quantity!) {
                                showPopupText(text: "لايمكن إضافة هذه الكمية");
                                details[index](detail.copyWith(quantity: oldValue));
                              } else {
                                details[index](detail.copyWith(quantity: detail.quantity));
                              }
                            }
                          }),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero,
                              filled: true,
                              fillColor: Colors.white70
                          ),
                          inputFormatters: [doubleInputFilter],
                        );
                      }
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
                      child: Center(child: Text(detail.totalQuantity.toString()))),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Builder(
                      builder: (context) {
                        num? oldValue = detail.price;
                        return TextFormField(
                          controller: TextEditingController(text: detail.price.toString()),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          onChanged: (value) => detail.price = value.tryToParseToNum ?? 0,
                          focusNode: detail.priceFocus..addListener(() {
                            if(!detail.priceFocus.hasFocus){
                              showPopupText(text: "لايمكن إدخال هذا السعر");
                              if(!detail.isValidPrice(controller.selectedPriceType.value!)){
                                details[index](detail.copyWith());
                              } else {
                                details[index](detail.copyWith(price: detail.price));
                              }
                            }
                          }),
                          inputFormatters: [doubleInputFilter],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.zero,
                            filled: true,
                            fillColor: Colors.white70
                          ),
                        );
                      }
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
                      onChanged: (value) => detail.discount = value.tryToParseToNum ?? 0,
                      focusNode: detail.discountFocus..addListener(() {
                        if(!detail.discountFocus.hasFocus) {
                            detail.discount ??= 0;
                            if (detail.discount! > 100) {
                              detail.discount = 100;
                            }
                            details[index](detail.copyWith(discount: detail.discount, discountValue: detail.discount! > 0 ? 0 : null));
                          }
                        }),
                      inputFormatters: [doubleInputFilter],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.zero,
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
                    child: TextFormField(
                      controller: TextEditingController(text: detail.discountValue.toString()),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      inputFormatters: [doubleInputFilter],
                      onChanged: (value) => detail.discountValue = value.tryToParseToNum ?? 0,
                      focusNode: detail.discountValueFocus..addListener(() {
                        if(!detail.discountValueFocus.hasFocus) {
                            detail.discountValue ??= 0;
                            if (detail.discountValue! > detail.netWithoutDiscount!) {
                              detail.discountValue = detail.netWithoutDiscount!;
                            }
                            details[index](detail.copyWith(discountValue: detail.discountValue, discount: detail.discountValue! > 0 ? 0 : null));
                          }
                        }),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.white70
                      ),
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
                      if(item.isInventoryItem == 0){
                        details[index](detail.copyWith(inventoryId: inventory!.id,inventoryCode: inventory.code, inventoryName: inventory.name));
                        return;
                      }
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
