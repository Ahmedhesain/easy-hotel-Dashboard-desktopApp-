import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/date_field_widget.dart';
import 'package:toby_bills/app/components/text_styles.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/modules/edit_bills/views/edit_bills_buttons.dart';

import '../../../components/table.dart';
import '../controllers/edit_bills_controller.dart';

class EditBillsView extends GetView<EditBillsController> {
  const EditBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    final permissions = UserManager().user.userScreens["customeraddnotice"];
    Size size = MediaQuery
        .of(context)
        .size;
    return Obx(() {
      return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            body: Column(
              children: [
                const EditBillsButtons(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                        foregroundDecoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey),
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        clipBehavior: Clip.antiAlias,
                        margin: const EdgeInsets.all(15),
                        child: Obx(() {
                          final reports = controller.reports;
                          return Table(
                            // border: TableBorder.all(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey, style: BorderStyle.solid, width: 1),
                            children: [
                              const TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('رقم السند', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('التاريخ', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('العميل', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('الفاتورة', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('المبلغ', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('الخزنه', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('الملاحظات', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('الحركه', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                                  ),
                                ],
                                decoration: BoxDecoration(color: AppColors.appGreyDark, border: Border(bottom: BorderSide())),
                              ),
                              for (GlPayDTO kha in reports)
                                TableRow(
                                  children: [
                                    SizedBox(height: 40, child: Center(child: Text(kha.serial.toString(), style: const TextStyle(fontSize: 20.0)))),
                                    // SizedBox(
                                    //   height: 40,
                                    //   child: Center(
                                    //     child: GetBuilder<EditBillsController>(
                                    //         id: kha.id.toString(),
                                    //         builder: (_) {
                                    //           return MouseRegion(
                                    //             cursor: SystemMouseCursors.click,
                                    //             child: GestureDetector(
                                    //               onTap: () async {
                                    //                 final date = await showDatePicker(
                                    //                     context: context,
                                    //                     initialDate: kha.date ?? DateTime.now(),
                                    //                     firstDate: DateTime(2017),
                                    //                     lastDate: DateTime.now());
                                    //                 kha.date = date ?? kha.date;
                                    //                 controller.update([kha.id.toString()]);
                                    //               },
                                    //               child: Text(
                                    //                 DateFormat("yyyy-MM-dd").format(kha.date!),
                                    //                 style: const TextStyle(decoration: TextDecoration.underline, fontSize: 18),
                                    //               ),
                                    //             ),
                                    //           );
                                    //         }),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 40,
                                      child: DateFieldWidget(
                                        onComplete: (DateTime date) {
                                          kha.date = date;
                                        },
                                        date: kha.date,
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      margin: const EdgeInsets.all(5),
                                      child: TypeAheadFormField<FindCustomerResponse>(
                                          key: UniqueKey(),
                                          itemBuilder: (context, client) {
                                            return SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: Text("${client.name} ${client.code}"),
                                              ),
                                            );
                                          },
                                          suggestionsCallback: (filter) =>
                                              controller.customers.where((element) =>
                                              (element.name ?? "").trim().contains(filter.trim()) ||
                                                  (element.code ?? "").trim().contains(filter.trim())),
                                          onSuggestionSelected: (value) {
                                            kha.textFieldController1.text = value.name ?? "";
                                            kha.textFieldController2.clear();
                                            kha.customerId = value.id;
                                            kha.customerName = value.name;
                                            kha.focusNode2.unfocus();

                                            controller.getInvoiceListForCustomer(value.id??-1, () => kha.focusNode2.requestFocus());
                                          },
                                          textFieldConfiguration: TextFieldConfiguration(
                                            textInputAction: TextInputAction.next,
                                            controller: kha.textFieldController1,
                                            focusNode: kha.focusNode1,
                                            textDirection: TextDirection.rtl,
                                            onSubmitted: (value) =>
                                                controller.getCustomersByCodeForInvoice(value, kha.focusNode1, kha.id??-1),
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                isDense: true,
                                                hintMaxLines: 1,
                                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
                                          )),
                                    ),
                                    Container(
                                      height: 40,
                                      margin: const EdgeInsets.all(5),
                                      child: TypeAheadFormField<InvoiceList>(
                                          key: UniqueKey(),
                                          itemBuilder: (context, inv) {
                                            return SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: Text("${inv.serial}"),
                                              ),
                                            );
                                          },
                                          suggestionsCallback: (filter) =>
                                              (controller.balances[kha.customerId]?.invoicesList ?? []).where((element) =>
                                                  (element.serial.toString() ?? "").contains(filter.trim())),
                                          onSuggestionSelected: (value) {
                                            kha.textFieldController2.text = value.serial?.toString() ?? "";
                                            kha.textFieldController3.text = value.salesStatementForThePeriod.remain.toStringAsFixed(2);
                                            kha.focusNode3.requestFocus();
                                            kha.invoiceSerial = value.serial;
                                            kha.invoiceId = value.id;
                                          },
                                          textFieldConfiguration: TextFieldConfiguration(
                                            textInputAction: TextInputAction.next,
                                            controller: kha.textFieldController2,
                                            focusNode: kha.focusNode2,
                                            textDirection: TextDirection.rtl,
                                            onTap: () => controller.getInvoiceListForCustomer(kha.customerId??-1, () => kha.focusNode2.requestFocus()),
                                            onChanged: (value) => kha.invoiceSerial = int.tryParse(value),
                                            onSubmitted: (value) =>
                                                controller.getCustomersByCodeForInvoice(value, kha.focusNode1, kha.id??-1),
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                isDense: true,
                                                hintMaxLines: 1,
                                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
                                          )),
                                    ),
                                    Container(
                                      height: 40,
                                      margin: const EdgeInsets.all(5),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: kha.textFieldController3,
                                        focusNode: kha.focusNode3,
                                        onFieldSubmitted: (_) => kha.focusNode4.requestFocus(),
                                        onChanged: (v) {
                                          kha.value = num.tryParse(v) ?? 0;
                                          // if(kha.value! >= (kha.remain??0)){
                                          //   kha.textFieldController3.text = kha.remain?.toStringAsFixed(2)??"";
                                          // }
                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      margin: const EdgeInsets.all(5),
                                      child: TypeAheadFormField<GlPayDTO>(
                                          key: UniqueKey(),
                                          itemBuilder: (context, client) {
                                            return SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: Text(client.bankName ?? ''),
                                              ),
                                            );
                                          },
                                          suggestionsCallback: (filter) =>
                                              controller.banks.where((element) => (element.bankName ?? "").trim().contains(filter)),
                                          onSuggestionSelected: (value) {
                                            kha.textFieldController4.text = value.bankName ?? "";
                                            kha.focusNode5.requestFocus();
                                            kha.bankId = value.bankId;
                                            kha.bankName = value.bankName;
                                          },
                                          textFieldConfiguration: TextFieldConfiguration(
                                            textInputAction: TextInputAction.next,
                                            controller: kha.textFieldController4,
                                            focusNode: kha.focusNode4,
                                            // onEditingComplete: () => controller.addinvoice(),
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                isDense: true,
                                                hintMaxLines: 1,
                                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12)),
                                          )),
                                    ),
                                    Container(
                                      height: 40,
                                      margin: const EdgeInsets.all(5),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: kha.textFieldController5,
                                        onChanged: (v) => kha.remark = v,
                                        focusNode: kha.focusNode5,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      margin: const EdgeInsets.all(5),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            if(permissions?.edit??false)
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.editInvoice(kha);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                                      color: AppColors.colorYellow,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text(
                                                          'حفظ',
                                                          style: smallTextStyleNormal(size, color: Colors.black),
                                                        ),
                                                        Icon(
                                                          Icons.edit,
                                                          color: Colors.black,
                                                          size: 15,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if((permissions?.edit??false) || (permissions?.delete??false))
                                              const SizedBox(width: 5),
                                            if(permissions?.delete??false)
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.deleteRow(kha.id??-1);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(Radius.circular(6.00)),
                                                      color: AppColors.colorYellow,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        Text(
                                                          'حذف',
                                                          style: smallTextStyleNormal(size, color: Colors.black),
                                                        ),
                                                        Icon(
                                                          Icons.delete,
                                                          color: Colors.black,
                                                          size: 15,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if((permissions?.edit??false) && (permissions?.delete??false))
                                              const SizedBox(width: 5),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () => controller.printRow(kha.id??-1, context),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(Radius.circular(6.00)),
                                                    color: AppColors.colorYellow,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Text(
                                                        'طباعه',
                                                        style: smallTextStyleNormal(size, color: Colors.black),
                                                      ),
                                                      Icon(
                                                        Icons.print,
                                                        color: Colors.black,
                                                        size: 15,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                  decoration: const BoxDecoration(color: AppColors.appGreyLight, border: Border(bottom: BorderSide())),
                                )
                            ],
                          );
                        })),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
