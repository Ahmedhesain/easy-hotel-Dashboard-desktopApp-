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
import '../../controllers/purchase_invoices_controller.dart';

class InvoiceDetailsWidget extends GetView<PurchaseInvoicesController> {
  const InvoiceDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    child: TypeAheadField<ItemResponse>(
                      suggestionsCallback: (filter) => controller.filterItems(filter),
                      onSuggestionSelected: (item) => controller.getItemData(
                          itemId: item.id!,
                          onSuccess: (itemData) {
                            if (item.itemData!.availableQuantity != null && item.itemData!.availableQuantity == 0) {
                              showPopupText(text: "لايوجد كمية متاحة");
                              detail(detail.value.copyWith(name: detail.value.name, code: detail.value.code));
                              return;
                            }
                            item.itemData = itemData;
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
                          enabled: false,
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
                                    if (detail.value.availableQuantityRow != null && detail.value.availableQuantityRow! < detail.value.number! * detail.value.quantity!) {
                                      showPopupText(text: "لايمكن إضافة هذا العدد");
                                      detail(detail.value.copyWith(number: oldValue));
                                    } else {
                                      detail(detail.value.copyWith(number: detail.value.number));
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
                      num? oldValue = detail.value.quantity;
                      return TextFormField(
                        controller: TextEditingController(text: detail.value.quantity?.toString()),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        // enabled: (detail.value.progroupId ?? 1) != 1,
                        onChanged: (value) => detail.value.quantity = value.tryToParseToNum ?? 0,
                        focusNode: detail.value.quantityFocus
                          ..addListener(() {
                            if (oldValue == detail.value.quantity) return;
                            controller.getItemData(
                                itemId: detail.value.itemId!,
                                onSuccess: (itemData) {
                                  detail.value.availableQuantityRow = itemData.availableQuantity;
                                  if (!detail.value.quantityFocus.hasFocus) {
                                    if (detail.value.availableQuantityRow != null && detail.value.availableQuantityRow! < detail.value.number! * detail.value.quantity!) {
                                      showPopupText(text: "لايمكن إضافة هذه الكمية");
                                      detail(detail.value.copyWith(quantity: oldValue));
                                    } else {
                                      detail(detail.value.copyWith(quantity: detail.value.quantity));
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
                              if (!detail.value.isValidPrice(controller.selectedPriceType.value!)) {
                                showPopupText(text: "لايمكن إدخال هذا السعر");
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
                  child: IconButtonWidget(
                    onPressed: () {
                      final deleted = controller.invoiceDetails.removeAt(index);
                      if (controller.invoice.value?.id != null) {
                        controller.invoice.value!.invoiceDetailApiListDeleted.add(deleted.value);
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
