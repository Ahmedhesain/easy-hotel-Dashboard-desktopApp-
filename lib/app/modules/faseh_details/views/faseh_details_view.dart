import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/keys_widget.dart';
import 'package:toby_bills/app/core/utils/double_filter.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/data/model/inventory/dto/response/inventory_response.dart';
import 'package:toby_bills/app/data/model/invoice/invoice_detail_model.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import '../controllers/faseh_details_controller.dart';

class FasehDetailsView extends GetView<FasehDetailsController> {
  const FasehDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final permissions = UserManager().user.userScreens["invpermissionorder_1"];
    return Scaffold(
      body: Obx(() {
        return KeysWidget(
          enabled: !controller.isLoading.value,
          saveFunc: () => controller.save(),
          newFunc: () => controller.newInvoice(),
          printFunc: () => PrintingHelper().fash(context, controller.invoiceDetailsList, controller.invoiceModel.value!),
          child: AppLoadingOverlay(
            isLoading: controller.isLoading.value,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: controller.fasehSearchController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: "ابحث عن فسح",
                              isDense: true,
                              suffixIcon: IconButtonWidget(
                                icon: Icons.search,
                                onPressed: () => controller.searchOnFaseh(),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10)
                            ),
                            onSubmitted: (_) => controller.searchOnFaseh(),
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.appGreyDark,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2.5),
                            child: Obx(() {
                              return Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if ((permissions?.delete ?? false) && controller.invoiceModel.value?.id != null)
                                    ButtonWidget(text: 'حذف', onPressed: () => controller.delete(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                                  ButtonWidget(text: 'رجوع', onPressed: () => Navigator.pop(context), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                                  if ((permissions?.edit ?? false) || controller.invoiceModel.value?.id == null)
                                    ButtonWidget(text: 'حفظ', onPressed: () => controller.save(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                                  ButtonWidget(text: 'بحث', onPressed: () => controller.searchOnFaseh(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                                  if (controller.invoiceModel.value != null)
                                    ButtonWidget(
                                      text: 'طباعة',
                                      onPressed: () => controller.print(context),
                                      margin: const EdgeInsets.symmetric(horizontal: 2.5),
                                    ),
                                  if((permissions?.add ?? false))
                                  ButtonWidget(text: 'جديد', onPressed: () => controller.newInvoice(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                                  if (controller.invoiceModel.value != null)
                                    ButtonWidget(text: 'تصدير الى اكسل', onPressed: () => ExcelHelper.fashExcel(controller.invoiceDetailsList, context), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _row("المعرض:", Text(controller.galleryName.value)),
                            const SizedBox(height: 10),
                            _row(
                                "رقم فاتورة المبيعات:",
                                SizedBox(
                                  width: 150,
                                  child: TextFormField(
                                    controller: controller.searchController,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                        suffix: InkWell(
                                          borderRadius: BorderRadius.circular(50),
                                          onTap: () {
                                            controller.search();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.search,
                                              size: 15,
                                            ),
                                          ),
                                        )),
                                    onFieldSubmitted: (_) {
                                      controller.search();
                                    },
                                  ),
                                )),
                            const SizedBox(height: 10),
                            _row(
                                "تاريخ فاتورة العميل:",
                                controller.supplierDate.value == null
                                    ? const SizedBox.shrink()
                                    : Text(DateFormat("yyyy-MM-dd hh:mm aa").format(controller.supplierDate.value!))),
                            const SizedBox(height: 10),
                            _row(
                                "العميل:",
                                Text(controller.customer.value)),
                            const SizedBox(height: 10),
                            _row(
                                "ملاحظات:",
                                SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                    controller: controller.remarksController,
                                    decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.all(5)),
                                  ),
                                )),
                          ],
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _row("رقم الفسح:", controller.invoiceModel.value == null ? const SizedBox.shrink() : Text(controller.invoiceModel.value!.serial.toString())),
                            const SizedBox(height: 10),
                            _row("التاريخ:",
                                controller.invoiceDate.value == null
                                    ? const SizedBox.shrink()
                                    : Text(DateFormat("yyyy-MM-dd hh:mm aa").format(controller.invoiceDate.value!))),
                            _row("المستودع:", SizedBox(
                              width: 200,
                              child: Obx(() {
                                return DropdownSearch<InventoryResponse>(
                                  // showSearchBox: true,
                                  items: controller.inventories,
                                  itemAsString: (InventoryResponse e) => e.code.toString(),
                                  onChanged: controller.selectedInventory,
                                  selectedItem: controller.selectedInventory.value,
                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                        // border: OutlineInputBorder(),
                                        fillColor: Colors.white70,
                                        isDense: true,
                                        filled: true,
                                        suffixIconConstraints: BoxConstraints(maxHeight: 30)),
                                  ),
                                );
                              }),
                            )),
                          ],
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                          // width: size.width * .75,
                          // height: size.height * .9,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          margin: const EdgeInsets.all(20).copyWith(top: 0),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.grey[400],
                                width: double.infinity,
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text("#")),
                                          Expanded(
                                            flex: 4,
                                            child: Column(children: [
                                              const Center(
                                                child: Text(
                                                  "البند",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: TypeAheadFormField<ItemResponse>(
                                                  suggestionsCallback: (String pattern) =>
                                                      controller.items.where((e) => e.name.toString().contains(pattern) || e.code.toString().contains(pattern)),
                                                  onSuggestionSelected: (item) {
                                                    controller.selectNewItem(item);
                                                  },
                                                  itemBuilder: (context, item) {
                                                    return Center(
                                                      child: Text("${item.name!} ${item.code!}"),
                                                    );
                                                  },
                                                  textFieldConfiguration: TextFieldConfiguration(
                                                      textInputAction: TextInputAction.next,
                                                      textAlignVertical: TextAlignVertical.center,
                                                      focusNode: controller.itemNameFocus,
                                                      onSubmitted: (value) {
                                                        List<ItemResponse> list = controller.items;
                                                        if (list.isNotEmpty && controller.itemCodeController.text.isNotEmpty) {
                                                          controller.selectNewItem(list.first);
                                                        }
                                                      },
                                                      controller: controller.itemCodeController),
                                                ),
                                              ),
                                            ]),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(children: [
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
                                                // width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: TextFormField(
                                                  textDirection: TextDirection.rtl,
                                                  keyboardType: TextInputType.number,
                                                  focusNode: controller.quantityFocus,
                                                  decoration: const InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    contentPadding: EdgeInsets.zero,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  inputFormatters: [doubleInputFilter],
                                                  controller: controller.itemQuantityController,
                                                  onFieldSubmitted: (value) {
                                                    if (value.isNotEmpty) {
                                                      controller.addItem();
                                                    }
                                                  },
                                                ),
                                              ),
                                            ]),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(children: [
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
                                                  onChanged: controller.itemSelectedInventory,
                                                  selectedItem: controller.itemSelectedInventory.value,
                                                  dropdownDecoratorProps: const DropDownDecoratorProps(
                                                    dropdownSearchDecoration: InputDecoration(
                                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                        border: OutlineInputBorder(),
                                                        fillColor: Colors.white70,
                                                        isDense: true,
                                                        filled: true,
                                                        suffixIconConstraints: BoxConstraints(maxHeight: 30)
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ]),
                                          ),
                                          const Spacer()
                                        ],
                                      ),
                                    ])),
                              ),
                              Expanded(
                                child: Obx(() {
                                  return ListView.builder(
                                      itemCount: controller.invoiceDetailsList.length,
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Text((index + 1).toString()),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: TypeAheadFormField<ItemResponse>(
                                                key: UniqueKey(),
                                                suggestionsCallback: (String pattern) =>
                                                    controller.items.where((e) => e.name.toString().contains(pattern) || e.code.toString().contains(pattern)),
                                                onSuggestionSelected: (item) {
                                                  controller.invoiceDetailsList[index].code = item.code;
                                                  controller.invoiceDetailsList[index].name = item.name??"";
                                                  final backup = <InvoiceDetailsModel>[];
                                                  backup.assignAll(controller.invoiceDetailsList);
                                                  controller.invoiceDetailsList.clear();
                                                  controller.invoiceDetailsList.assignAll(backup);

                                                },
                                                itemBuilder: (context, item) {
                                                  return Center(
                                                    child: Text("${item.name!} ${item.code!}"),
                                                  );
                                                },
                                                initialValue: "${controller.invoiceDetailsList[index].code!} ${controller.invoiceDetailsList[index].name}",
                                                textFieldConfiguration: TextFieldConfiguration(
                                                    textInputAction: TextInputAction.next,
                                                    textAlignVertical: TextAlignVertical.center,
                                                    // focusNode: controller.itemNameFocus,
                                                    // onSubmitted: (value) {
                                                    //   List<ItemResponse> list = controller.items;
                                                    //   if (list.isNotEmpty && controller.itemCodeController.text.isNotEmpty) {
                                                    //     controller.selectNewItem(list.first);
                                                    //   }
                                                    // },
                                                    // controller: controller.itemCodeController
                                                ),
                                              ),
                                            ),
                                            // Expanded(
                                            //   flex: 4,
                                            //   child: Text(
                                            //     "${controller.invoiceDetailsList[index].code!} ${controller.invoiceDetailsList[index].name}",
                                            //     textAlign: TextAlign.center,
                                            //     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                            //   ),
                                            // ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: TextFormField(
                                                initialValue: (controller.invoiceDetailsList[index].quantityOfOneUnit ?? '').toString(),
                                                onChanged: (value) {
                                                  if (value.isEmpty) return;
                                                  controller.invoiceDetailsList[index].quantityOfOneUnit = num.parse(value);
                                                },
                                                inputFormatters: [doubleInputFilter],
                                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                                decoration: const InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(vertical: 7), border: OutlineInputBorder(), isDense: true),
                                                textAlign: TextAlign.center,
                                                textDirection: TextDirection.ltr,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: DropdownSearch<InventoryResponse>(
                                                // showSearchBox: true,
                                                items: controller.inventories,
                                                itemAsString: (InventoryResponse e) => e.code.toString(),
                                                onChanged: (inventory){
                                                  controller.invoiceDetailsList[index].inventoryId = inventory?.id;
                                                },
                                                selectedItem: controller.inventories.singleWhere((element) => element.id == controller.invoiceDetailsList[index].inventoryId),
                                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                                  dropdownSearchDecoration: InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                                      border: OutlineInputBorder(),
                                                      fillColor: Colors.white70,
                                                      isDense: true,
                                                      filled: true,
                                                      suffixIconConstraints: BoxConstraints(maxHeight: 30)
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                onPressed: () => controller.removeDetail(index),
                                                icon: const Icon(Icons.clear),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                }),
                              ),
                            ],
                          )))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _row(String label, Widget details) {
    return Row(
      children: [SizedBox(width: 150, child: Text(label)), details],
    );
  }
}
