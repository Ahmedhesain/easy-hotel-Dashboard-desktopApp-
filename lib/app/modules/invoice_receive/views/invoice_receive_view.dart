import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';

import '../controllers/invoice_receive_controller.dart';

class InvoiceReceiveView extends GetView<InvoiceReceiveController> {
  const InvoiceReceiveView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("رجوع"),
                    ),
                    if (controller.invoiceModel.value != null && !controller.isSaved) const SizedBox(width: 10),
                    if (controller.invoiceModel.value != null && !controller.isSaved)
                      ElevatedButton(
                        onPressed: () async {
                          await controller.save(context);
                          controller.searchFocus.requestFocus();
                        },
                        child: const Text("حفظ"),
                      ),
                    if (controller.invoiceModel.value != null) const SizedBox(width: 10),
                    if (controller.invoiceModel.value != null)
                      ElevatedButton(
                        onPressed: () {
                          controller.newOne();
                          controller.searchFocus.requestFocus();
                        },
                        child: const Text("جديد"),
                      ),
                  ],
                ),
                const SizedBox(height: 40),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration:
                      BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black38), borderRadius: BorderRadius.circular(15.0)),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child: Text("التاريخ"),
                              ),
                              Expanded(
                                child: Text(DateFormat("yyyy-MM-dd").format(DateTime.now())),
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Text("الوقت"),
                              ),
                              Expanded(
                                child: Text(DateFormat("hh:mm aa").format(DateTime.now())),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Expanded(
                                child: Text("رقم التسليم"),
                              ),
                              Expanded(
                                child: FractionallySizedBox(
                                  widthFactor: 0.7,
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text((controller.invoiceModel.value?.serial??"").toString()),
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Text("رقم الفاتورة"),
                              ),
                              Expanded(
                                child: FractionallySizedBox(
                                  widthFactor: 0.7,
                                  alignment: AlignmentDirectional.centerStart,
                                  child: TextFormField(
                                    controller: controller.searchController,
                                    focusNode: controller.searchFocus,
                                    decoration: InputDecoration(
                                        isDense: true,
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
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Spacer(
                                flex: 2,
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Text("العميل"),
                              ),
                              Expanded(
                                child: FractionallySizedBox(
                                  widthFactor: 0.7,
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(controller.invoiceModel.value == null
                                      ? ""
                                      : "${controller.invoiceModel.value!.customerName} ${controller.invoiceModel.value!.customerMobile} ${controller.invoiceModel.value!.customerCode}"),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Spacer(
                                flex: 2,
                              ),
                              const SizedBox(width: 20),
                              const Expanded(
                                child: Text("ملاحظات"),
                              ),
                              Expanded(
                                child: FractionallySizedBox(
                                  widthFactor: 0.8,
                                  alignment: AlignmentDirectional.centerStart,
                                  child: TextFormField(
                                    decoration: const InputDecoration(isDense: true),
                                    controller: controller.remarksController,
                                    focusNode: controller.notesFocus,
                                    onFieldSubmitted: (_) async {
                                      if(controller.invoiceModel.value != null) {
                                        controller.save(context);
                                        controller.searchController.clear();
                                        controller.remarksController.clear();
                                        controller.invoiceModel.value!.customerName="";
                                        controller.invoiceModel.value!.customerMobile="";
                                        controller.invoiceModel.value!.customerCode="";
                                        controller.searchFocus.requestFocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Positioned(
                      top: -2,
                      right: 50,
                      height: 10,
                      width: 170,
                      child: ColoredBox(
                        color: Colors.white,
                      ),
                    ),
                    const Positioned(
                      top: -10,
                      right: 65,
                      child: Text("استلام الفاتورة بالمعرض"),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white, border: Border.all(color: Colors.black38), borderRadius: BorderRadius.circular(15.0)),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Center(child: Text("#")),
                                  ),
                                  Container(color: Colors.black12, width: 2, height: 40),
                                  const SizedBox(width: 10),
                                  const Expanded(
                                    flex: 2,
                                    child: Text("البند"),
                                  ),
                                  const Expanded(
                                    flex: 2,
                                    child: Text("العدد"),
                                  ),
                                  Container(color: Colors.black12, width: 2, height: 40),
                                  const Expanded(
                                    flex: 3,
                                    child: Center(child: Text("الحركة")),
                                  ),
                                ],
                              ),
                              const Divider(height: 0),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller.invoiceModel.value?.invoiceDetailApiList?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final item = controller.invoiceModel.value?.invoiceDetailApiList![index];
                                    return ColoredBox(
                                      color: index % 2 == 0 ? Colors.black.withOpacity(0.08) : Colors.white,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(color: Colors.black12, width: 2, height: 40),
                                              Expanded(
                                                child: Center(child: Text((index + 1).toString())),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                flex: 2,
                                                child: Text(item!.name.toString()),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: TextFormField(
                                                  initialValue: item.number.toString(),
                                                  onChanged: (value) => item.number = num.tryParse(value),
                                                  decoration: const InputDecoration(
                                                    border: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    errorBorder: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Center(
                                                  child: IconButton(
                                                    icon: const Icon(Icons.clear),
                                                    onPressed: () {
                                                      controller.invoiceModel.value!.invoiceDetailApiList!.removeAt(index);
                                                      controller.invoiceModel.update((val) { });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Container(color: Colors.black12, width: 2, height: 40),
                                            ],
                                          ),
                                          const Divider(
                                            height: 0,
                                            thickness: 2,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        top: -2,
                        right: 50,
                        height: 10,
                        width: 210,
                        child: ColoredBox(
                          color: Colors.white,
                        ),
                      ),
                      const Positioned(
                        top: -10,
                        right: 65,
                        child: Text("بيانات استلام الفاتورة بالمعرض"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
