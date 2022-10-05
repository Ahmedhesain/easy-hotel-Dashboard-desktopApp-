import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_field_widget.dart';
import 'package:toby_bills/app/components/text_widget.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/create_customer_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delegator_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/values/app_colors.dart';

class InvoiceInfoWidget extends GetView<HomeController> {
  const InvoiceInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              TextWidget(controller.invoice?.id.toString() ?? ""),
              const SizedBox(width: 15),
              const Expanded(child: Text('الحالة')),
              const SizedBox(width: 5),
              Expanded(flex: 2, child: Text(controller.invoice?.status.toString() ?? "")),
              const SizedBox(width: 25),
              const Expanded(child: Text('تحديد السعر')),
              Expanded(
                flex: 2,
                child: Obx(() {
                  return DropdownButtonFormField(
                    // menuMaxHeight: size.height * .2,
                    decoration: InputDecoration(
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
                    onChanged: (value) async {
                      // await provider.setPriceTypeSelected(int.parse(value.toString()), context);
                      // setState(() {});
                    },
                    // value: provider.priceTypeSelected,
                  );
                }),
              ),
              const SizedBox(width: 25),
              const Expanded(child: Text('التاريخ')),
              Expanded(
                flex: 2,
                child: Text(
                  DateFormat("dd-MM-yyyy").format(DateTime.now()),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 25),
              const Expanded(child: Text('تاريخ التسليم')),
              Expanded(
                flex: 2,
                child: Text(
                  controller.dueDate == null ? "" : DateFormat("dd-MM-yyyy").format(controller.dueDate!.dueDate),
                  textAlign: TextAlign.center,
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
                      items: controller.invoiceTypeList,
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
              const Text('المندوب:'),
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
              const SizedBox(width: 25),
              const Text('مده التسليم:'),
              const SizedBox(width: 5),
              Expanded(
                child: Text(controller.dueDate?.dayNumber.toString() ?? ""),
              ),
              const SizedBox(width: 25),
              const Text('بروفة:'),
              Obx(() {
                return Checkbox(
                  value: controller.isProof.value,
                  onChanged: controller.isProof,
                );
              })
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text('اختيار العرض:'),
              const SizedBox(width: 5),
              Expanded(
                child: DropdownSearch<String>(
                  items: [],
                  onChanged: print,
                  dropdownDecoratorProps:
                      DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(isDense: true, contentPadding: EdgeInsets.zero, border: OutlineInputBorder())),
                ),
              ),
              const SizedBox(width: 10),
              Text('ملاحظات:'),
              const SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: TextFormField(
                  decoration: const InputDecoration(isDense: true, contentPadding: EdgeInsets.all(13), border: OutlineInputBorder()),
                  controller: controller.invoiceRemarkController,
                ),
              ),
              const SizedBox(width: 10),
              Text('العميل:'),
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
                            border: OutlineInputBorder(),
                            // disabledBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            // focusedBorder: InputBorder.none,
                            hintText: "ابحث عن فاتورة لعميل معين",
                            isDense: true,
                            hintMaxLines: 2,
                            contentPadding: EdgeInsets.all(5),
                            suffixIconConstraints: BoxConstraints(maxWidth: 50),
                            suffixIcon: IconButtonWidget(
                              icon: Icons.search,
                              onPressed: () {
                                controller.getCustomersByCodeForInvoice();
                              },
                            )),
                      )),
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
