import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_widget.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_constants.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delegator_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../core/values/app_colors.dart';
import '../../controllers/purchase_invoices_controller.dart';

class InvoiceInfoWidget extends GetView<PurchaseInvoicesController> {
  const InvoiceInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(() {
            return Row(
              children: [
                const Text('الحالة:'),
                const SizedBox(width: 5),
                if (controller.invoice.value?.id != null)
                  GetBuilder<PurchaseInvoicesController>(
                      id: PurchaseInvoicesController.getBuilderSerial,
                      builder: (context) {
                        return TextWidget(controller.invoice.value?.serial?.toString() ?? "");
                      }),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      const Text('تحديد السعر:'),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Obx(() {
                          return DropdownButtonFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(10),
                              isDense: true,
                            ),
                            dropdownColor: AppColors.appGreyLight,
                            value: controller.selectedPriceType.value,
                            // style: smallTextStyleNormal(size, color: Colors.black),
                            elevation: 0,
                            items: controller.priceTypes.entries
                                .map((e) => DropdownMenuItem<int>(
                                      value: e.key,
                                      child: Text(e.value),
                                    ))
                                .toList(),
                            onChanged: controller.changePriceType,
                            // value: provider.priceTypeSelected,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Row(
                      children: [
                        const Text('التاريخ:'),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat("dd-MM-yyyy").format(DateTime.now()),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Obx(() {
                    return Center(
                      child: Row(
                        children: [
                          const Text('تاريخ الاستحقاق:'),
                          const SizedBox(width: 5),
                          Text(
                            controller.dueDate.value?.dueDate == null ? "" : DateFormat("dd-MM-yyyy").format(controller.dueDate.value!.dueDate!),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            );
          }),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Text('مكان الاستلام:'),
              const SizedBox(width: 5),
              Expanded(
                flex: 3,
                child: Obx(() {
                  return DropdownSearch<DeliveryPlaceResposne>(
                    // showSearchBox: true,
                    items: controller.deliveryPlaces,
                    itemAsString: (DeliveryPlaceResposne e) => e.name,
                    onChanged: controller.selectedDeliveryPlace,
                    selectedItem: controller.selectedDeliveryPlace.value,
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(10),
                        isDense: true,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(width: 25),
              const Text('نوع الفاتوره:'),
              const SizedBox(width: 5),
              Expanded(
                  flex: 3,
                  child: Obx(() {
                    return DropdownSearch<String>(
                      key: UniqueKey(),
                      selectedItem: controller.selectedInvoiceType.value,
                      items: AppConstants.invoiceTypeList,
                      onChanged: (value) {
                        controller.selectedInvoiceType(value);
                        // if (value == context.read<InvoiceProvider>().invoiceTypeList.first) {
                        //   context.read<InvoiceProvider>().invoiceTypeSelected = null;
                        // } else {
                        //   context.read<InvoiceProvider>().invoiceTypeSelected = context.read<InvoiceProvider>().invoiceTypeList.indexOf(value!) - 1;
                        // }
                        // context.read<InvoiceProvider>().invoiceTypeName = value!;
                      },
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                        ),
                      ),
                    );
                  })),
              const SizedBox(width: 25),
              const Text('مندوب المبيعات:'),
              const SizedBox(width: 5),
              Expanded(
                flex: 3,
                child: Obx(() {
                  return DropdownSearch<DelegatorResponse>(
                    // showSearchBox: true,
                    key: UniqueKey(),
                    items: controller.delegators,
                    itemAsString: (DelegatorResponse e) => e.name,
                    // dropdownSearchDecoration: InputDecoration(
                    //   hintText: delegatorList.isNotEmpty?  delegatorList[0].name:"" ,
                    // ),
                    onChanged: controller.selectedDelegator,
                    selectedItem: controller.selectedDelegator.value,
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.all(10), isDense: true)),
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Text('اختيار المعرض:'),
              const SizedBox(width: 5),
              Expanded(
                child: Obx(() {
                  return DropdownSearch<GalleryResponse>(
                    items: controller.galleries,
                    selectedItem: controller.selectedGallery.value,
                    onChanged: UserManager().changeGallery,
                    itemAsString: (gallery) => gallery.name ?? "",
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(width: 10),
              const Text('ملاحظات:'),
              const SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: TextFormField(
                  decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.all(13), border: OutlineInputBorder()),
                  controller: controller.invoiceRemarkController,
                ),
              ),
              const SizedBox(width: 10),
              const Text('المورد:'),
              const SizedBox(width: 4),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.appGreyLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TypeAheadFormField<FindCustomerResponse>(
                      itemBuilder: (context, client) {
                        return SizedBox(
                          height: 50,
                          child: Center(
                            child: Text("${client.name} ${client.code}"),
                          ),
                        );
                      },
                      suggestionsCallback: (filter) => controller.customers,
                      onSuggestionSelected: (value) async {
                        controller.invoiceCustomerController.text = "${value.name} ${value.code}";
                        controller.selectedCustomer(value);
                        controller.getCustomerBalance(value.id);
                        // provider.loading = true;
                        // setState(() {});
                        // try {
                        //   searchedClientSelected = value;
                        //   searchedCustomerBalance = await context.read<InvoiceProvider>().getbalanceScreenGroups(value.id!);
                        //   searchClintController.text = value.name! + " " + value.code!;
                        // } catch (e, s) {
                        //   print('$e\n$s');
                        //   Helper().showToast(context, "عذراً حصل خطأ", MsgType.error);
                        // }
                        // provider.loading = false;
                        // setState(() {});
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                        textInputAction: TextInputAction.next,
                        controller: controller.invoiceCustomerController,
                        focusNode: controller.invoiceCustomerFieldFocusNode,
                        onEditingComplete: () => controller.getCustomersByCodeForInvoice(),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            // disabledBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            // focusedBorder: InputBorder.none,
                            hintText: "ابحث عن مورد",
                            isDense: true,
                            hintMaxLines: 2,
                            contentPadding: const EdgeInsets.all(5),
                            suffixIconConstraints: const BoxConstraints(maxWidth: 50),
                            suffixIcon: IconButtonWidget(
                              icon: Icons.search,
                              onPressed: () {
                                controller.getCustomersByCodeForInvoice();
                              },
                            )),
                      )),
                ),
              ),
              const SizedBox(width: 10),
              const Text('رقم فاتورة المورد:'),
              const SizedBox(width: 5),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.all(13), border: OutlineInputBorder()),
                  controller: controller.invoiceRemarkController,
                ),
              ),
              // IconButton(
              //   icon: Icon(Icons.add),
              //   onPressed: () {
              //     final formKey = GlobalKey<FormState>();
              //     final newCustomer = CreateCustomerRequest();
              //     Get.dialog(AlertDialog(
              //       title: Center(child: Text("إضافة عميل")),
              //       content: Form(
              //         key: formKey,
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             TextFieldWidget(label: "اسم العميل", onChanged: (value) => newCustomer.name = value, validator: AppValidator.forceValue),
              //             const SizedBox(height: 15),
              //             TextFieldWidget(label: "هاتف العميل", onChanged: (value) => newCustomer.mobile = value, validator: AppValidator.forceValue,textAlign: TextAlign.left,textDirection: TextDirection.ltr,),
              //             const SizedBox(height: 15),
              //             TextFieldWidget(label: "إيميل العميل", onChanged: (value) => newCustomer.email = value),
              //             const SizedBox(height: 15),
              //             TextFieldWidget(label: "الطول", onChanged: (value) => newCustomer.length = double.tryParse(value), justNumbers: true),
              //             const SizedBox(height: 15),
              //             TextFieldWidget(label: "الكتف", onChanged: (value) => newCustomer.shoulder = double.tryParse(value), justNumbers: true),
              //             const SizedBox(height: 15),
              //             TextFieldWidget(label: "الخطوة", onChanged: (value) => newCustomer.step = double.tryParse(value), justNumbers: true),
              //           ],
              //         ),
              //       ),
              //       actions: [
              //         ElevatedButton(
              //           onPressed: () async {
              //             if (formKey.currentState!.validate()) {
              //               controller.createCustomer(newCustomer);
              //               Get.back();
              //             }
              //           },
              //           child: Text("حفظ"),
              //         )
              //       ],
              //     ));
              //   },
              // )
            ],
          ),
        ),
      ],
    );
  }
}
