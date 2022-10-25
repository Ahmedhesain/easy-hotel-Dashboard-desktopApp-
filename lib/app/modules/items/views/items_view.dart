import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import '../controllers/items_controller.dart';

class ItemsView extends GetView<ItemsController> {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        onChanged: (value) => controller.getItems(value),
                        decoration: const InputDecoration(isDense: true, border: OutlineInputBorder(), hintText: "ابحث عن صنف"),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("رجوع"))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    Expanded(
                      child: Center(child: Text("اسم الصنف")),
                    ),
                    Expanded(
                      child: Center(child: Text("كود الصنف")),
                    ),
                    Expanded(
                      child: Center(child: Text("سعر الصنف")),
                    ),
                    Expanded(
                      child: Center(child: Text("سعر التكلفة")),
                    ),
                    Expanded(
                      child: Center(child: Text("Action")),
                    ),
                  ],
                ),
                const Divider(color: Colors.black),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.items.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = controller.items[index];
                      return Row(
                        children: [
                          Expanded(
                            child: Center(child: Text(item.name ?? "")),
                          ),
                          Expanded(
                            child: Center(child: Text(item.code ?? "")),
                          ),
                          Expanded(
                            child: Center(child: Text(item.maxPriceMen?.toStringAsFixed(2) ?? "")),
                          ),
                          Expanded(
                            child: Center(child: Text(item.lastCost?.toStringAsFixed(2) ?? "")),
                          ),
                          Expanded(
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.print),
                                onPressed: (){
                                  PrintingHelper().printItemBarcode(context, item);
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

}
