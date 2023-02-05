  import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return Obx(() {
            Rx<InvoiceDetailsModel> detail = details[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 30,
                    child: TypeAheadFormField<ItemResponse>(
                      suggestionsCallback: (filter) => controller.filterItems(filter),
                      onSuggestionSelected: (item) => controller.getItemData(
                          itemId: item.id!,
                          inventoryId: detail.value.inventoryId,
                          onSuccess: (itemData) {
                            if (itemData.availableQuantity != null && itemData.availableQuantity! <= 0) {
                              showPopupText(text: "لايوجد كمية متاحة");
                              detail(detail.value.copyWith(name: detail.value.name, code: detail.value.code));
                              return;
                            }
                            // item.itemData = itemData;
                            final newDetail = detail.value.assignItem(item);
                            detail(newDetail);
                            controller.calcInvoiceValues();
                          }),
                      itemBuilder: (context, item) {
                        return Center(
                          child: Text("${item.name} ${item.code}"),
                        );
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: TextEditingController(text: "${detail.value.name} ${detail.value.code}"),
                          textInputAction: TextInputAction.next,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10), border: OutlineInputBorder(), filled: true, fillColor: Colors.white70),
                          onSubmitted: (value) {
                            final items = controller.filterItems(value);
                            if (controller.itemNameController.text.isNotEmpty) {
                              controller.getItemData(itemId: items.first.id!, onSuccess: (data) {});
                            }
                          }),
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Builder(builder: (context) {
                      num? oldValue = detail.value.number;
                      return TextFormField(
                        controller: TextEditingController(text: detail.value.number?.toString()),
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.number,
                        onChanged: (value) => detail.value.number = value.tryToParseToNum ?? 0,
                        focusNode: detail.value.numberFocus
                          ..addListener(() {
                            if (detail.value.number == oldValue) return;
                            controller.getItemData(
                                itemId: detail.value.itemId!,
                                onSuccess: (itemData) {
                                  detail.value.availableQuantityRow = itemData.availableQuantity;
                                  if (!detail.value.numberFocus.hasFocus) {
                                    if (detail.value.availableQuantityRow != null && detail.value.availableQuantityRow! < detail.value.number! * detail.value.quantityOfOneUnit!) {
                                      showPopupText(text: "لايمكن إضافة هذا العدد");
                                      detail(detail.value.copyWith(number: oldValue));
                                    } else {
                                      detail(detail.value.copyWith(number: detail.value.number));
                                      controller.calcInvoiceValues();
                                    }
                                  }
                                });
                          }),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.zero,
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                        inputFormatters: [doubleInputFilter],
                      );
                    }),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Builder(builder: (context) {
                      num? oldValue = detail.value.quantityOfOneUnit;
                      return TextFormField(
                        controller: TextEditingController(text: detail.value.quantityOfOneUnit?.toString()),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        // enabled: (detail.value.progroupId ?? 1) != 1,
                        onChanged: (value) => detail.value.quantityOfOneUnit = value.tryToParseToNum ?? 0,
                        focusNode: detail.value.quantityFocus
                          ..addListener(() {
                            if (oldValue == detail.value.quantityOfOneUnit || detail.value.quantityFocus.hasFocus) return;
                            if(controller.items.every((element) => element.id != detail.value.itemId)){
                              showPopupText(text: "يرجى عمل تحديث للبيانات أولاً");
                              detail(detail.value.copyWith(quantityOfOneUnit: oldValue));
                            }
                            final item = controller.items.singleWhere((element) => element.id == detail.value.itemId);
                            if(item.isInventoryItem == 0) {
                              detail(detail.value.copyWith(quantityOfOneUnit: detail.value.quantityOfOneUnit));
                              controller.calcInvoiceValues();
                              return;
                            }
                            if(detail.value.id != null) {
                              final oldResult = ((oldValue??1) * (detail.value.number??1)) + (detail.value.availableQuantityRow??0);
                              if(oldResult < detail.value.totalQuantity){
                                showPopupText(text: "الكمية اقل من المتاح");
                                detail(detail.value.copyWith(quantityOfOneUnit: oldValue));
                              } else {
                                detail(detail.value.copyWith(quantityOfOneUnit: detail.value.quantityOfOneUnit));
                                controller.calcInvoiceValues();
                              }
                              return;
                            }
                            controller.getItemData(
                                itemId: detail.value.itemId!,
                                onSuccess: (itemData) {
                                  detail.value.availableQuantityRow = itemData.availableQuantity;
                                  if (!detail.value.quantityFocus.hasFocus) {
                                    if (detail.value.availableQuantityRow != null && detail.value.availableQuantityRow! < detail.value.number! * detail.value.quantityOfOneUnit!) {
                                      showPopupText(text: "لايمكن إضافة هذه الكمية");
                                      detail(detail.value.copyWith(quantityOfOneUnit: oldValue));
                                    } else {
                                      detail(detail.value.copyWith(quantityOfOneUnit: detail.value.quantityOfOneUnit));
                                      controller.calcInvoiceValues();
                                    }
                                  }
                                });
                          }),
                        decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero, filled: true, fillColor: Colors.white70),
                        inputFormatters: [doubleInputFilter],
                      );
                    }),
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
                      child: Center(child: Text(detail.value.totalQuantity.toString()))),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Builder(builder: (context) {
                      num? oldValue = detail.value.price;
                      return TextFormField(
                        controller: TextEditingController(text: detail.value.price?.toStringAsFixed(2)),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        onChanged: (value) => detail.value.price = value.tryToParseToNum ?? 0,
                        focusNode: detail.value.priceFocus
                          ..addListener(() {
                            if (!detail.value.priceFocus.hasFocus) {
                              if (detail.value.id == null && !detail.value.isValidPrice(controller.selectedPriceType.value!)) {
                                showPopupText(text: "المبلغ اقل من الحد الادنى للسعر");
                                detail(detail.value.copyWith(price: oldValue));
                              } else {
                                detail(detail.value.copyWith(price: detail.value.price));
                              }
                            }
                          }),
                        inputFormatters: [doubleInputFilter],
                        decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero, filled: true, fillColor: Colors.white70),
                      );
                    }),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: TextEditingController(text: detail.value.discount.toString()),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      enabled: controller.canEdit,
                      onChanged: (value) => detail.value.discount = value.tryToParseToNum ?? 0,
                      focusNode: detail.value.discountFocus
                        ..addListener(() {
                          if (!detail.value.discountFocus.hasFocus) {
                            detail.value.discount ??= 0;
                            if (detail.value.discount! > 100) {
                              detail.value.discount = 100;
                            }
                            detail(detail.value.copyWith(discount: detail.value.discount, discountValue: detail.value.discount! > 0 ? 0 : null));
                            controller.calcInvoiceValues();
                          }
                        }),
                      inputFormatters: [doubleInputFilter],
                      decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero, filled: true, fillColor: Colors.white70),
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: TextEditingController(text: detail.value.discountValue.toString()),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      enabled: controller.canEdit,
                      inputFormatters: [doubleInputFilter],
                      onChanged: (value) => detail.value.discountValue = value.tryToParseToNum ?? 0,
                      focusNode: detail.value.discountValueFocus
                        ..addListener(() {
                          if (!detail.value.discountValueFocus.hasFocus) {
                            detail.value.discountValue ??= 0;
                            if (detail.value.discountValue! > detail.value.netWithoutDiscount!) {
                              detail.value.discountValue = detail.value.netWithoutDiscount!;
                            }
                            detail(detail.value.copyWith(discountValue: detail.value.discountValue, discount: detail.value.discountValue! > 0 ? 0 : null));
                            controller.calcInvoiceValues();
                          }
                        }),
                      decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero, filled: true, fillColor: Colors.white70),
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
                      child: Text(detail.value.net?.toString() ?? ""),
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
                      child: Text(detail.value.availableQuantityRow?.toString() ?? "--"),
                    ),
                  ),
                ),
                separator,
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: TextEditingController(text: detail.value.remark),
                      onChanged: (value) => detail.value.remark = value,
                      onEditingComplete: () {},
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 10), filled: true, fillColor: Colors.white70),
                    ),
                  ),
                ),
                separator,
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: TextEditingController(text: detail.value.invNoticeValue?.toString()),
                      onChanged: (value) {
                        detail.value.invNoticeValue = value.tryToParseToNum;
                        controller.calcInvoiceValues();
                      },
                      inputFormatters: [doubleInputFilter],
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 10), filled: true, fillColor: Colors.white70),
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Checkbox(
                      value: detail.value.proof == 1,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        detail(detail.value.copyWith(proof: value! ? 1 : 0));
                      },
                    ),
                  ),
                ),
                separator,
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Checkbox(
                      value: detail.value.remnants == 1,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        details[index](detail.value.copyWith(remnants: value! ? 1 : 0));
                      },
                    ),
                  ),
                ),
                separator,
                Expanded(
                  flex: 2,
                  child: DropdownSearch<InventoryResponse>(
                    key: UniqueKey(),
                    items: controller.inventories,
                    itemAsString: (InventoryResponse inventory) => inventory.code.toString(),
                    onChanged: (InventoryResponse? inventory) {
                      final item = controller.items.singleWhere((element) => element.id == detail.value.itemId);
                      if (item.isInventoryItem == 0) {
                        details[index](detail.value.copyWith(inventoryId: inventory!.id, inventoryCode: inventory.code, inventoryName: inventory.name));
                        return;
                      }
                      controller.getItemData(
                          itemId: item.id!,
                          inventoryId: inventory!.id,
                          onSuccess: (itemData) {
                            bool haveToChangeNumber = false;
                            if (itemData.availableQuantity != null) {
                              if (itemData.availableQuantity! <= 0) {
                                showPopupText(text: "لايوجد كمية متاحة");
                                detail(detail.value.copyWith(
                                    inventoryId: detail.value.inventoryId, inventoryCode: detail.value.inventoryCode, inventoryName: detail.value.inventoryName));
                                return;
                              } else if (itemData.availableQuantity! < detail.value.totalQuantity) {
                                showPopupText(text: "الكمية الكلية اكبر من الكمية المتاحة");
                                haveToChangeNumber = true;
                              }
                            }
                            item.itemData = itemData;
                            final newDetail = detail.value.assignItem(item);
                            detail(newDetail.copyWith(
                                inventoryId: inventory.id, inventoryCode: inventory.code, inventoryName: inventory.name, number: haveToChangeNumber ? 1 : null));
                            controller.calcInvoiceValues();
                          });
                    },
                    selectedItem:  controller.inventories.isNotEmpty ? controller.inventories.singleWhere((element) => element.id == detail.value.inventoryId) : null,
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
                      final deleted = controller.invoiceDetails.removeAt(index);
                      if (controller.invoice.value?.id != null) {
                        controller.invoice.value!.invoiceDetailApiListDeleted!.add(deleted.value);
                      }
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
