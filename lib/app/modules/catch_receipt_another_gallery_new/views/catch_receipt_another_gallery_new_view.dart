import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_styles.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/utils/double_filter.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/modules/catch_receipt_another_gallery_new/views/widgets/catch_receipt_buttons_widget.dart';
import '../../../data/model/invoice/dto/response/gallery_response.dart';
import '../controllers/catch_receipt_another_gallery_new_controller.dart';

class CatchReceiptAnotherGalleryNewView extends GetView<CatchReceiptAnotherGalleryNewController> {
  const CatchReceiptAnotherGalleryNewView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          body: Column(
            children: [
              const CatchReceiptAnotherGalleryNewButtonsWidget(),
              Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                    ),
                    margin: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: AppColors.appGreyDark,
                            border: Border.all(color: Colors.grey),
                          ),
                          margin: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text(
                                  'المعرض',
                                ),
                              ),
                              Container(
                                width: size.width * .15,
                                height: 30,
                                margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    color: Colors.white,
                                    // border: Border.all(color: Colors.grey)
                                ),
                                child: Obx(() {
                                  return DropdownSearch<GalleryResponse>(
                                    items: controller.galleries,
                                    selectedItem: controller.selectedGallery.value,
                                    onChanged: controller.selectedGallery,
                                    itemAsString: (gallery) => gallery.name ?? "",
                                    dropdownBuilder: (context, g) => Text(g?.name??"",maxLines: 1,overflow: TextOverflow.ellipsis,style: const TextStyle(fontWeight: FontWeight.bold),),
                                    dropdownButtonProps: const DropdownButtonProps(
                                      iconSize: 15,
                                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                                      constraints: BoxConstraints(minHeight: 10)
                                    ),
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
                              SizedBox(
                                width: size.width * .01,
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text(
                                  'العميل',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Container(
                                  width: size.width * .1,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey)),
                                  child: TypeAheadFormField<FindCustomerResponse>(
                                    itemBuilder: (context, client) {
                                      return SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: Text(client.name.toString()),
                                        ),
                                      );
                                    },
                                    onSuggestionSelected: (value) {
                                      controller.customerController.text = value.name ?? "";
                                      controller.selectedCustomer(value);
                                      controller.getInvoiceListForCustomer(value, () {});
                                      controller.itemInvoiceController.text = '' ;
                                      controller.itemRemainController.text = '' ;
                                      controller.itemPayController.text = '' ;

                                    },
                                    textFieldConfiguration: TextFieldConfiguration(
                                      controller: controller.customerController,
                                      focusNode: controller.customerFocusNode,
                                      onSubmitted: (search) => controller.getCustomers(search),
                                      decoration: InputDecoration(
                                        suffixIcon: IconButtonWidget(
                                          icon: Icons.search,
                                          onPressed: (){
                                            controller.getCustomers(controller.customerController.text);
                                          },
                                        )
                                      ),
                                    ),
                                      suggestionsCallback: (filter) => controller.customers,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .01,
                              ),
                              const Text('الرصيد'),
                              Container(
                                width: size.width * .1,
                                height: 30,
                                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(child: Obx(() {
                                  return Text(controller.customerBalance.value?.balance.toString() ?? "0");
                                })),
                              ),
                              SizedBox(
                                width: size.width * .02,
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Text('التاريخ'),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                                child: SizedBox(
                                  width: size.width * .1,
                                  height: 30,
                                  child: Text(
                                    DateFormat("dd/MM/yyyy").format(DateTime.now()),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .01,
                              ),
                              const Text('ملاحظات'),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Container(
                                  width: size.width * .25,
                                  // height: size.height * .06,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10)
                                    ),
                                    controller: controller.remarksController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.grey[400],
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(children: [
                                    const Center(
                                      child: Text(
                                        "رقم الفاتوره",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TypeAheadFormField<InvoiceList>(
                                          itemBuilder: (context, inv) {
                                            return SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: Text(inv.serial.toString()),
                                              ),
                                            );
                                          },
                                          suggestionsCallback: (filter) => controller.customerBalance.value?.invoicesList.where((inv) => inv.serial != null && inv.serial.toString().contains(filter)) ?? [],
                                          onSuggestionSelected: controller.onSelectInvoice ,
                                        // (value) {
                                          //   controller.itemInvoiceController.text = value.serial.toString();
                                          //   controller.itemRemainController.text = "0";
                                          //   controller.itemPayController.text = value.salesStatementForThePeriod.remain.toString();
                                          //   controller.itemPayFocus.requestFocus();
                                          //   controller.itemInvoice = value;
                                          // },
                                      textFieldConfiguration: TextFieldConfiguration(
                                          controller: controller.itemInvoiceController,
                                          focusNode: controller.itemInvoiceFocus
                                      ),
                                      ),
                                    ),
                                  ])),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    const Center(
                                      child: Text(
                                        "المتبقي",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 8)),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        enabled: false,
                                        controller: controller.itemRemainController,
                                        focusNode: controller.itemRemainFocus,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    const Center(
                                      child: Text(
                                        "المدفوع",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 8)),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        controller: controller.itemPayController,
                                        enabled: controller.isPayedEnabled.value,
                                        focusNode: controller.itemPayFocus,
                                        inputFormatters: [doubleInputFilter],
                                        onFieldSubmitted: (_) => controller.itemBankFocus.requestFocus(),
                                        onChanged: (value) {
                                          if (controller.itemInvoice == null) return;
                                          final pay = value.tryToParseToNum ?? 0;
                                          final remain = controller.itemInvoice!.salesStatementForThePeriod.remain - pay;
                                          if (remain < 0) {
                                            controller.itemPayController.text = controller.itemInvoice!.salesStatementForThePeriod.remain.toString();
                                            return;
                                          }
                                          controller.itemRemainController.text = remain.toString();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 2,
                                child: Column(children: [
                                  const Center(
                                    child: Text(
                                      "الخزينه",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TypeAheadFormField<GlPayDTO>(
                                      itemBuilder: (context, bank) {
                                        return SizedBox(
                                          height: 50,
                                          child: Center(
                                            child: Text(bank.bankName.toString()),
                                          ),
                                        );
                                      },
                                        suggestionsCallback: (filter) =>
                                            controller.banks.where((element) => element.bankName.toString().trim().contains(filter.trim())),
                                        onSuggestionSelected: (value) {
                                          controller.itemBank = value;
                                          controller.itemBankController.text = value.bankName ?? "";
                                          if (controller.itemInvoice != null) {
                                            controller.addNewDetail();
                                          }
                                        },
                                      textFieldConfiguration: TextFieldConfiguration(
                                        controller: controller.itemBankController,
                                        focusNode: controller.itemBankFocus,
                                      ),
                                        ),
                                  ),
                                ]),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Center(
                                  child: IconButtonWidget(
                                    icon: Icons.done_rounded,
                                    onPressed: () {
                                      if (controller.itemInvoice == null) {
                                        showPopupText(text: "يرجى اختيار فاتورة اولاً");
                                      } else {
                                        controller.addNewDetail();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(0),
                                child: Obx(() {
                                  return Table(
                                    border: TableBorder.all(
                                        borderRadius: const BorderRadius.all(Radius.circular(0)),
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1),
                                    children: [
                                      const TableRow(
                                        children: [
                                          Text(
                                            'رقم الفاتوره',
                                            style: TextStyle(fontSize: 20.0),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'المتبقي',
                                            style: TextStyle(fontSize: 20.0),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'المدفوع',
                                            style: TextStyle(fontSize: 20.0),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'الخزينه',
                                            style: TextStyle(fontSize: 20.0),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            'حذف',
                                            style: TextStyle(fontSize: 20.0),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                        decoration: BoxDecoration(
                                            color: AppColors.appGreyDark,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(0), topLeft: Radius.circular(0))),
                                      ),
                                      for (GlPayDTO kha in controller.banksToPay)
                                        TableRow(
                                          children: [
                                            Column(children: [Text(kha.invoiceSerial!.toString(), style: const TextStyle(fontSize: 20.0))]),
                                            Column(children: [Text(kha.remain!.toString(), style: const TextStyle(fontSize: 20.0))]),
                                            Column(children: [Text(kha.value!.toString(), style: const TextStyle(fontSize: 20.0))]),
                                            Column(children: [Text(kha.bankName!, style: const TextStyle(fontSize: 20.0))]),
                                            Column(children: [
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.fromLTRB(0, size.height * .01, 5, 0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                controller.banksToPay.remove(kha);
                                                              },
                                                              child: Container(
                                                                alignment: Alignment.centerRight,
                                                                height: size.height * .05,
                                                                width: size.width * .05,
                                                                decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                                                  color: AppColors.colorYellow,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  children: [
                                                                    Text(
                                                                      'حذف',
                                                                      style: smallTextStyleNormal(size, color: Colors.black),
                                                                    ),
                                                                    const Icon(
                                                                      Icons.delete,
                                                                      color: Colors.black,
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ],
                                          decoration: const BoxDecoration(
                                              color: AppColors.appGreyLight,
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(0), topLeft: Radius.circular(0))),
                                        )
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),
                        )),
                      ],
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
