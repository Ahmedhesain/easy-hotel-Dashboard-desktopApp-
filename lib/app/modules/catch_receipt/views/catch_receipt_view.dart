import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_styles.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/modules/catch_receipt/controllers/widgets/catch_receipt_buttons_widget.dart';

import '../controllers/catch_receipt_controller.dart';

class CatchReceiptView extends GetView<CatchReceiptController> {
  const CatchReceiptView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          body: Column(
            children: [
              const CatchReceiptButtonsWidget(),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text(
                                  'العميل',
                                  style: subTitleTextStyle(size),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Container(
                                  width: size.width * .13,
                                  height: size.height * .06,
                                  decoration:
                                  BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)), color: Colors.white, border: Border.all(color: Colors.grey)),
                                  child: TypeAheadFormField<FindCustomerResponse>(
                                      itemBuilder: (context, client) {
                                        return SizedBox(
                                          height: 50,
                                          child: Center(
                                            child: Text(client.name!),
                                          ),
                                        );
                                      },
                                      suggestionsCallback: (filter) =>
                                          controller.customers.where((element) => (element.name ?? "").contains(filter) || (element.code ?? "").contains(filter)),
                                      onSuggestionSelected: (value) {
                                        controller.customerController.text = value.name ?? "";
                                        controller.selectedCustomer(value);
                                        controller.getInvoiceListForCustomer(value, () { });
                                      },
                                      textFieldConfiguration: TextFieldConfiguration(
                                        controller: controller.customerController,
                                        onSubmitted: (search) => controller.getCustomers(search),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .01,
                              ),
                              Text('الرصيد', style: subTitleTextStyle(size)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Container(
                                  width: size.width * .1,
                                  height: size.height * .06,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(child: Obx(() {
                                    return Text(controller.customerBalance.value?.balance.toString() ?? "0");
                                  })),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .02,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Text('التاريخ', style: subTitleTextStyle(size)),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                                child: Container(
                                  width: size.width * .1,
                                  height: size.height * .03,
                                  child: Text(
                                    DateFormat("dd/MM/yyyy").format(DateTime.now()),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * .01,
                              ),
                              Text('ملاحظات', style: subTitleTextStyle(size)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                child: Container(
                                  width: size.width * .25,
                                  height: size.height * .06,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
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
                                                child: Text(inv.serial!.toString()),
                                              ),
                                            );
                                          },
                                          suggestionsCallback: (filter) => controller.customerBalance.value?.invoicesList??[],
                                          onSuggestionSelected: (value) {
                                            controller.itemInvoiceController.text = value.serial.toString();
                                            controller.itemRemainController.text = value.salesStatementForThePeriod.remain.toString();
                                          },
                                          textFieldConfiguration: TextFieldConfiguration(
                                            controller: controller.itemInvoiceController,
                                            focusNode: controller.itemInvoiceFocus,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              disabledBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                          )),
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
                                        decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 8)),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
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
                                        decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 8)),
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.center,
                                        controller: controller.itemPayController,
                                        focusNode: controller.itemPayFocus,
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
                                              child: Text(bank.bankName!),
                                            ),
                                          );
                                        },
                                        suggestionsCallback: (filter) => [],
                                        onSuggestionSelected: (value) {},
                                        textFieldConfiguration: TextFieldConfiguration(
                                          controller: controller.itemBankController,
                                          focusNode: controller.itemBankFocus,
                                          decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              isDense: true),
                                        )),
                                  ),
                                ]),
                              ),
                              const SizedBox(width: 15),
                              const Expanded(
                                child: Center(
                                  child: IconButtonWidget(
                                    icon: Icons.done_rounded,
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
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(size.width * .194),
                                      border: TableBorder.all(
                                          borderRadius: const BorderRadius.all(Radius.circular(0)), color: Colors.grey, style: BorderStyle.solid, width: 1),
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
                                              color: AppColors.appGreyDark, borderRadius: BorderRadius.only(topRight: Radius.circular(0), topLeft: Radius.circular(0))),
                                        ),
                                        for (GlPayDTO kha in [])
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
                                                                onTap: () {},
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
                                    ),
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
