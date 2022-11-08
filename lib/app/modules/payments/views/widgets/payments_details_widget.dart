// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:get/get.dart';
// import 'package:toby_bills/app/core/extensions/string_ext.dart';
// import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
// import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';
// import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
// import 'package:toby_bills/app/modules/payments/controllers/payments_controller.dart';
// import '../../../../components/icon_button_widget.dart';
// import '../../../../core/utils/double_filter.dart';
// import '../../../../data/model/inventory/dto/response/inventory_response.dart';
//
// class PurchaseInvoiceDetailsWidget extends GetView<PaymentsController> {
//   const PurchaseInvoiceDetailsWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     const separator = SizedBox(width: 5);
//     return Obx(() {
//       final details = controller.invoiceDetails;
//       return ListView.separated(
//         itemCount: details.length,
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         separatorBuilder: (_, __) => const Divider(),
//         itemBuilder: (context, index) {
//           return Obx(() {
//             Rx<InvoiceDetailsModel> detail = details[index];
//             return Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: SizedBox(
//                     height: 30,
//                     child: TypeAheadField<ItemResponse>(
//                       suggestionsCallback: (filter) => controller.filterItems(filter),
//                       onSuggestionSelected: (item){
//                         final newDetail = detail.value.assignItem(item);
//                         detail(newDetail);
//                       },
//                       itemBuilder: (context, item) {
//                         return Center(
//                           child: Text("${item.name} ${item.code}"),
//                         );
//                       },
//                       textFieldConfiguration: TextFieldConfiguration(
//                           controller: TextEditingController(text: "${detail.value.name} ${detail.value.code}"),
//                           textInputAction: TextInputAction.next,
//                           textAlignVertical: TextAlignVertical.center,
//                           decoration: const InputDecoration(
//                               contentPadding: EdgeInsets.symmetric(horizontal: 10), border: OutlineInputBorder(), filled: true, fillColor: Colors.white70),
//                           ),
//                     ),
//                   ),
//                 ),
//                 separator,
//                 Expanded(
//                   child: SizedBox(
//                     height: 30,
//                     child: Builder(builder: (context) {
//                       num? oldValue = (detail.value.quantity??0) / 0.9;
//                       return TextFormField(
//                         controller: TextEditingController(text: ((detail.value.quantity??0) / 0.9).toStringAsFixed(2)),
//                         textDirection: TextDirection.ltr,
//                         textAlign: TextAlign.center,
//                         onChanged: (value) => oldValue = value.tryToParseToNum ?? 0,
//                         focusNode: detail.value.quantityFocus..addListener(() {
//                           if(!detail.value.quantityFocus.hasFocus){
//                             detail(detail.value.copyWith(quantity: (oldValue??0) * 0.9));
//                             controller.calcInvoiceValues();
//                           }
//                         }),
//                         decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero, filled: true, fillColor: Colors.white70),
//                         inputFormatters: [doubleInputFilter],
//                       );
//                     }),
//                   ),
//                 ),
//                 separator,
//                 Expanded(
//                   child: SizedBox(
//                     height: 30,
//                     child: Builder(builder: (context) {
//                       num? oldValue = detail.value.quantity;
//                       return TextFormField(
//                         controller: TextEditingController(text: detail.value.quantity?.toString()),
//                         textDirection: TextDirection.ltr,
//                         textAlign: TextAlign.center,
//                         onChanged: (value) {
//                           oldValue = value.tryToParseToNum ?? 0;
//                         },
//                         focusNode: detail.value.numberFocus..addListener(() {
//                           if(!detail.value.numberFocus.hasFocus){
//                             detail(detail.value.copyWith(quantity: oldValue));
//                             controller.calcInvoiceValues();
//                           }
//                         }),
//                         decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero, filled: true, fillColor: Colors.white70),
//                         inputFormatters: [doubleInputFilter],
//                       );
//                     }),
//                   ),
//                 ),
//                 separator,
//                 Expanded(
//                   child: Container(
//                       height: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.white70,
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Builder(
//                         builder: (context) {
//                           num? oldValue = detail.value.price;
//                           return TextFormField(
//                             controller: TextEditingController(text: detail.value.price?.toStringAsFixed(2)),
//                             textAlign: TextAlign.center,
//                             textDirection: TextDirection.ltr,
//                             onChanged: (value) => oldValue = value.tryToParseToNum ?? 0,
//                             focusNode: detail.value.priceFocus..addListener(() {
//                               if(!detail.value.priceFocus.hasFocus){
//                                 detail(detail.value.copyWith(price: oldValue));
//                                 controller.calcInvoiceValues();
//                               }
//                             }),
//                             inputFormatters: [doubleInputFilter],
//                             decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero, filled: true, fillColor: Colors.white70),
//                           );
//                         }
//                       )),
//                 ),
//                 separator,
//                 Expanded(
//                   child: SizedBox(
//                     height: 30,
//                     child: Builder(builder: (context) {
//                       num? oldValue = detail.value.discount;
//                       return TextFormField(
//                         controller: TextEditingController(text: detail.value.discount?.toStringAsFixed(2)),
//                         textAlign: TextAlign.center,
//                         textDirection: TextDirection.ltr,
//
//                         onChanged: (value) => oldValue = value.tryToParseToNum ?? 0,
//                         focusNode: detail.value.discountFocus..addListener(() {
//                           if(!detail.value.discountFocus.hasFocus){
//                             detail(detail.value.copyWith(discount: oldValue));
//                             controller.calcInvoiceValues();
//                           }
//                         }),
//                         inputFormatters: [doubleInputFilter],
//                         decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero, filled: true, fillColor: Colors.white70),
//                       );
//                     }),
//                   ),
//                 ),
//                 separator,
//                 Expanded(
//                   child: Container(
//                     // width: 50,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       color: Colors.white70,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Center(
//                       child: Text(detail.value.net?.toString() ?? ""),
//                     ),
//                   ),
//                 ),
//                 separator,
//                 Expanded(
//                   flex: 2,
//                   child: DropdownSearch<GlAccountResponse>(
//                     key: UniqueKey(),
//                     items: controller.glAccounts,
//                     itemAsString: (GlAccountResponse account) => "${account.name} ${account.accNumber}",
//                     onChanged: (GlAccountResponse? account) {
//                       detail(detail.value.copyWith(account: account?.id));
//                     },
//                     selectedItem: controller.glAccounts.every((element) => element.id != detail.value.account)?null:controller.glAccounts.singleWhere((element) => element.id == detail.value.account),
//                     dropdownDecoratorProps: const DropDownDecoratorProps(
//                         dropdownSearchDecoration: InputDecoration(
//                             isDense: true,
//                             border: OutlineInputBorder(),
//                             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                             suffixIconConstraints: BoxConstraints(maxHeight: 30))),
//                   ),
//                 ),
//                 separator,
//                 Expanded(
//                   flex: 2,
//                   child: DropdownSearch<InventoryResponse>(
//                     key: UniqueKey(),
//                     items: controller.inventories,
//                     itemAsString: (InventoryResponse inventory) => inventory.code,
//                     onChanged: (InventoryResponse? inventory) {
//                       detail(detail.value.copyWith(
//                           inventoryId: inventory?.id, inventoryCode: inventory?.code, inventoryName: inventory?.name));
//                       controller.calcInvoiceValues();
//                     },
//                     selectedItem: controller.inventories.every((element) => element.id != detail.value.inventoryId)?null:controller.inventories.singleWhere((element) => element.id == detail.value.inventoryId),
//                     dropdownDecoratorProps: const DropDownDecoratorProps(
//                         dropdownSearchDecoration: InputDecoration(
//                             isDense: true,
//                             border: OutlineInputBorder(),
//                             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                             suffixIconConstraints: BoxConstraints(maxHeight: 30))),
//                   ),
//                 ),
//                 separator,
//                 Expanded(
//                   child: IconButtonWidget(
//                     onPressed: () {
//                       final deleted = controller.invoiceDetails.removeAt(index);
//                       if (controller.invoice.value?.id != null) {
//                         controller.invoice.value!.invoiceDetailApiListDeleted.add(deleted.value);
//                       }
//                       controller.calcInvoiceValues();
//                     },
//                     icon: Icons.clear,
//                   ),
//                 ),
//                 separator,
//               ],
//             );
//           });
//         },
//       );
//     });
//   }
// }
