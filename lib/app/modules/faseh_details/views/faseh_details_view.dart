import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
import 'package:toby_bills/app/components/keys_widget.dart';
import 'package:toby_bills/app/core/utils/double_filter.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/item/dto/response/item_response.dart';
import '../controllers/faseh_details_controller.dart';

class FasehDetailsView extends GetView<FasehDetailsController> {
  const FasehDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return KeysWidget(
          enabled: !controller.isLoading.value,
          saveFunc: () => controller.save(),
          newFunc: () => controller.newInvoice(),
          printFunc: () => PrintingHelper().fash(context, controller.invoiceDetailsList, controller.invoiceModel!),
          child: AppLoadingOverlay(
            isLoading: controller.isLoading.value,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
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
                            ButtonWidget(text: 'رجوع', onPressed: () => Navigator.pop(context), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                            if (!controller.isSaved.value)
                              ButtonWidget(text: 'حفظ', onPressed: () => controller.save(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                            // ButtonWidget(text: 'بحث', onPressed: () => controller.save(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                            // ButtonWidget(text: 'حذف', onPressed: () => controller.save(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                            if (controller.isSaved.value)
                              ButtonWidget(
                                text: 'طباعة',
                                onPressed: () => PrintingHelper().fash(context, controller.invoiceDetailsList, controller.invoiceModel!),
                                margin: const EdgeInsets.symmetric(horizontal: 2.5),
                              ),
                            ButtonWidget(text: 'جديد', onPressed: () => controller.newInvoice(), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                            if (controller.isSaved.value)
                              ButtonWidget(text: 'تصدير الى اكسل', onPressed: () => ExcelHelper.fashExcel(controller.invoiceDetailsList, context), margin: const EdgeInsets.symmetric(horizontal: 2.5)),
                          ],
                        );
                      }),
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
                            _row("المعرض:", Text(controller.findInvoiceModel?.gallaryName ?? "")),
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
                                controller.findInvoiceModel?.invDate == null
                                    ? const SizedBox.shrink()
                                    : Text(DateFormat("yyyy-MM-dd hh:mm aa").format(controller.findInvoiceModel!.invDate!))),
                            const SizedBox(height: 10),
                            _row(
                                "العميل:",
                                controller.findInvoiceModel == null
                                    ? const SizedBox.shrink()
                                    : Text("${controller.findInvoiceModel!.iosName} ${controller.findInvoiceModel!.iosCode} ${controller.findInvoiceModel!.iosMobile}")),
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
                            _row("رقم الفسح:", controller.findInvoiceModel == null ? const SizedBox.shrink() : Text(controller.findInvoiceModel!.delegatorId.toString())),
                            const SizedBox(height: 10),
                            _row("التاريخ:", Text(DateFormat("yyyy-MM-dd hh:mm aa").format(DateTime.now()))),
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
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Text((index + 1).toString()),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  "${controller.invoiceDetailsList[index].code!} ${controller.invoiceDetailsList[index].name}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: TextFormField(
                                                  initialValue: (controller.invoiceDetailsList[index].quantityOfOneUnit ?? '').toString(),
                                                  onChanged: (value) {
                                                    if (value.isEmpty) return;
                                                    controller.invoiceDetailsList[index].quantityOfOneUnit = num.parse(value);
                                                  },
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                                  decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.symmetric(vertical: 5), border: OutlineInputBorder(), isDense: true),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                  onPressed: () => controller.removeDetail(index),
                                                  icon: const Icon(Icons.clear),
                                                ),
                                              )
                                            ],
                                          ),
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
