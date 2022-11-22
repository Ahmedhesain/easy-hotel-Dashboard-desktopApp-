import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toby_bills/app/components/date_field_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_widget.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delegator_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gl_account_response.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../core/values/app_colors.dart';
import '../../controllers/purchase_invoices_controller.dart';

class PurchaseInvoiceInfoWidget extends GetView<PurchaseInvoicesController> {
  const PurchaseInvoiceInfoWidget({Key? key}) : super(key: key);

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
                const Text('رقم الفاتورة:'),
                const SizedBox(width: 5),
                if (controller.invoice.value?.serial != null)
                  GetBuilder<PurchaseInvoicesController>(
                      id: PurchaseInvoicesController.getBuilderSerial,
                      builder: (context) {
                        return TextWidget(controller.invoice.value?.serial?.toString() ?? "");
                      }),
                const SizedBox(width: 10),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('تاريخ فاتورة المورد:'),
                        const SizedBox(width: 5),
                        Expanded(
                          child: DateFieldWidget(
                              onComplete: (date){
                                controller.supplierDate(date);
                              },
                            date: controller.supplierDate.value,
                          ),
                        ),
                        // MouseRegion(
                        //   cursor: SystemMouseCursors.click,
                        //   child: GestureDetector(
                        //     onTap: () async {
                        //       final date = await showDatePicker(
                        //           context: context,
                        //           initialDate: controller.supplierDate.value ?? DateTime.now(),
                        //           firstDate: DateTime(2000),
                        //           lastDate: DateTime.now()
                        //       );
                        //       controller.supplierDate(date);
                        //     },
                        //     child: Text(
                        //       controller.supplierDate.value == null ? "dd-mm-yyyy" : DateFormat("dd-MM-yyyy").format(controller.supplierDate.value!),
                        //       textAlign: TextAlign.center,
                        //       style: const TextStyle(decoration: TextDecoration.underline),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Obx(() {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('تاريخ الاستحقاق:'),
                          const SizedBox(width: 5),
                          Expanded(
                            child: DateFieldWidget(
                              onComplete: (date){
                                controller.dueDate(date);
                              },
                              date: controller.dueDate.value,
                            ),
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
              const Text('مندوب المشتريات:'),
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
                      suggestionsCallback: (filter) => controller.suppliers,
                      onSuggestionSelected: (value) async {
                        controller.invoiceCustomerController.text = "${value.name} ${value.code}";
                        controller.selectedCustomer(value);
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                        textInputAction: TextInputAction.next,
                        controller: controller.invoiceCustomerController,
                        focusNode: controller.invoiceCustomerFieldFocusNode,
                        onSubmitted: (_) => controller.getCustomersByCodeForInvoice(),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
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
                  controller: controller.invoiceSupplierNumberController,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Text('ملاحظات:'),
              const SizedBox(width: 5),
              Expanded(
                flex: 2,
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
