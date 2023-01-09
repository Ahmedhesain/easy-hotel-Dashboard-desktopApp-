  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:multiselect/multiselect.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/date_field_widget.dart';
import 'package:toby_bills/app/components/scrollable_row.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/modules/reports/item_sales_by_customers/controllers/items_sales_by_customers_controller.dart';

class ItemSalesByCustomersView extends GetView<ItemsSalesByCustomersController> {
  const ItemSalesByCustomersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Column(
            children: [
              ScrollableRow(
                minimumWidth: 800,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                textDirection: TextDirection.rtl,
                children: (isScrollable) {
                  return [
                    const Text(
                      "اختر معرض: ",
                      textDirection: TextDirection.rtl,
                    ),
                    Obx(() {
                      return SizedBox(
                        width: 300,
                        height: 35,
                        child: DropDownMultiSelect(
                          options: controller.deliveryPlaces.map((e) => e.name??"").toList(),
                          selectedValues: controller.selectedDeliveryPlace.map((e) => e.name??"").toList(),
                          onChanged: controller.selectNewDeliveryplace,
                          isDense: true,
                          childBuilder: (List<String> values) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                values.isEmpty ? "يرجى تحديد معرض على الاقل" : values.join(', '),
                                maxLines: 1,
                              ),
                            );
                          },
                        ),
                      );
                    }),
                    const SizedBox(width: 15),
                    const Text(
                      "من تاريخ: ",
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      width: 150,
                      child: DateFieldWidget(
                        onComplete: (date){
                          controller.dateFrom(date);
                        },
                        date: controller.dateFrom.value,
                      ),
                    ),
                    // Obx(() {
                    //   return MouseRegion(
                    //     cursor: SystemMouseCursors.click,
                    //     child: GestureDetector(
                    //         onTap: () {
                    //           controller.pickFromDate();
                    //         },
                    //         child: Text(
                    //           DateFormat("yyyy-MM-dd").format(controller.dateFrom.value),
                    //           style: const TextStyle(decoration: TextDecoration.underline),
                    //         )),
                    //   );
                    // }),
                    const SizedBox(width: 15),
                    const Text(
                      "الى تاريخ: ",
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(
                      width: 150,
                      child: DateFieldWidget(
                        onComplete: (date){
                          controller.dateTo(date);
                        },
                        date: controller.dateTo.value,
                      ),
                    ),
                    // Obx( () {
                    //   return MouseRegion(
                    //     cursor: SystemMouseCursors.click,
                    //     child: GestureDetector(
                    //         onTap: () {
                    //           controller.pickToDate();
                    //         },
                    //         child: Text(
                    //           DateFormat("yyyy-MM-dd").format(controller.dateTo.value),
                    //           style: const TextStyle(decoration: TextDecoration.underline),
                    //         )),
                    //   );
                    // }),
                    if (!isScrollable) const Spacer(),
                    if (isScrollable) const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => controller.getPurchases(),
                      child: const Text("بحث"),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => PrintingHelper().itemSales(context, controller.purchasesGroups, controller.dateFrom.value, controller.dateTo.value),
                      child: const Text("طباعة"),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("رجوع"),
                    ),
                  ];
                },
              ),
              const Divider(),
              Expanded(
                child: Obx(() {
                  if(controller.error != null){
                    return Center(
                      child: Column(
                        children: [
                          Text(controller.error!),
                          IconButton(
                              onPressed: () => controller.getDeliveryPlaces(),
                              icon: const Icon(Icons.refresh_rounded))
                        ],
                      ),
                    );
                  }
                  final purchases = controller.purchasesGroups;
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              "اسم العميل",
                              "رقم الفاتورة",
                              "رقم الشغل",
                              "تاريخ الفاتورة",
                              "رقم الصنف",
                              "البيان",
                              "الوحدة",
                              "الكمية",
                              "تكلفة الشراء",
                              "الخصم",
                              "القيمة",
                            ]
                                .map((e) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                child: Text(e, textAlign: TextAlign.center),
                              ),
                            ))
                                .toList(),
                          ),
                        ),
                        const Divider(thickness: 2,height: 2,),
                        Expanded(
                          child: ListView.builder(
                            itemCount: purchases.length + 1,
                            itemBuilder: (context, i){
                              if(purchases.length == i){
                                return ColoredBox(
                                  color: Colors.grey.shade400,
                                  child: Column(
                                    children: [
                                      const Divider(thickness: 2,height: 0),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          "الاجمالي",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          purchases.fold<num>(0, (p, e) => p + (e.purchases.fold<num>(0, (p, e) => p + (e.cost ?? 0)))).toStringAsFixed(2),
                                        ]
                                            .map((e) => Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 7),
                                            child: Text(e, textAlign: TextAlign.center),
                                          ),
                                        ))
                                            .toList(),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                );
                              }
                              return ListView.separated(
                                itemCount: purchases[i].purchases.length,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (_,__) => const Divider(),
                                itemBuilder: (context, j){
                                  final e = purchases[i].purchases[j];
                                  return Column(
                                    children: [
                                      if(j==0)
                                        ColoredBox(
                                          color: Colors.grey.shade300,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            child: Row(
                                              children: [
                                                purchases[i].name,
                                                "",
                                                "",
                                                "",
                                                "",
                                                "",
                                                "",
                                                "",
                                                "",
                                                "",
                                                purchases[i].purchases.fold<num>(0, (p, e) => p+(e.cost ?? 0)).toStringAsFixed(2)
                                              ].map((d) {
                                                return Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 7),
                                                    child: Text(
                                                      d,
                                                      maxLines: 2,
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          children: [
                                            "",
                                            "${e.serialTax}",
                                            "${e.serial}",
                                            e.date == null?"":DateFormat("yyyy-MM-dd").format(e.date!),
                                            (e.itemBarcode ?? ""),
                                            (e.itemName ?? ""),
                                            (e.itemUnitName ?? ""),
                                            "${e.itemQuantity}",
                                            "${e.cost}",
                                            "${e.discount}",
                                            e.cost?.toStringAsFixed(2) ?? "",
                                          ].map((d) {
                                            return Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 7),
                                                child: Text(
                                                  d,
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }

}
