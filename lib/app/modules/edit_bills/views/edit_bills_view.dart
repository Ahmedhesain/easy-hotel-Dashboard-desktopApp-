import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/intl.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/colors.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_styles.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/modules/edit_bills/views/edit_bills_buttons.dart';

import '../../../components/table.dart';
import '../controllers/edit_bills_controller.dart';

class EditBillsView extends GetView<EditBillsController> {
  const EditBillsView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime enddate = DateTime.now();
    DateTime startdate = DateTime.now();

    var numController = TextEditingController();
    var itemQuantityController = TextEditingController();
    var clientController = TextEditingController();
    var priceController = TextEditingController();
    var invoiceController = TextEditingController();
    var infoController = TextEditingController();

    return Obx(() {
      return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            body: Column(
              children: [
                const EditBillsButtons(),
                Expanded(
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
                      child: Table(
                        // border: TableBorder.all(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.grey, style: BorderStyle.solid, width: 1),
                        children: [
                          const TableRow(
                            children: [
                              Text('رقم السند', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                              Text('التاريخ', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                              Text('العميل', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                              Text('المبلغ', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                              Text('الخزنه', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                              Text('الملاحظات', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                              Text('الحركه', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                            ],
                            decoration:
                            BoxDecoration(color: appGreyDark, borderRadius: BorderRadius.only(topRight: Radius.circular(0), topLeft: Radius.circular(0))),
                          ),
                          for (GlPayDTO kha in controller.reports)
                            TableRow(
                              children: [
                                Text(kha.serial!.toString(), style: const TextStyle(fontSize: 20.0)),
                                Container(
                                  // width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Container(
                                      width: size.width * .3,
                                      height: size.height * .04,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(onTap: () {
                                            controller.pickEditDate(kha.date!);
                                          }, child: Obx(() {
                                            return Text(
                                              DateFormat("yyyy-MM-dd").format(kha.date!),
                                              style: const TextStyle(decoration: TextDecoration.underline),
                                            ).obs();
                                          })),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TypeAheadFormField<FindCustomerResponse>(
                                    // initialValue: kha != null?kha.customerName.toString():"",
                                      itemBuilder: (context, client) {
                                        return SizedBox(
                                          height: 50,
                                          child: Center(
                                            child: Text("${client.name} ${client.code}"),
                                          ),
                                        );
                                      },
                                      suggestionsCallback: (filter) => controller.customers,
                                      onSuggestionSelected: (value) {
                                        print(value.name);
                                        controller.reportController(kha).text = "${value.name} ";
                                      },
                                      textFieldConfiguration: TextFieldConfiguration(
                                        textInputAction: TextInputAction.next,
                                        controller: controller.reportController(kha),
                                        focusNode: controller.reportNodes(kha),
                                        onEditingComplete: () => controller.getCustomersByCodeForInvoice(controller.reportNodes(kha)),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            disabledBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            hintText: "ابحث عن فاتورة لعميل معين",
                                            isDense: true,
                                            hintMaxLines: 1,
                                            contentPadding: EdgeInsets.all(5),
                                            suffixIconConstraints: BoxConstraints(maxWidth: 50),
                                            suffixIcon: IconButtonWidget(
                                              icon: Icons.search,
                                              onPressed: () {
                                                controller.getCustomersByCodeForInvoice(controller.reportNodes(kha));
                                              },
                                            )),
                                      )),
                                ),
                                Container(
                                  // width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextFormField(
                                    // focusNode: invoiceFocus,
                                    initialValue: kha != null ? kha.value.toString() : "",
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
                                    /////////////quantity
                                    // onEditingComplete: () => FocusScope.of(context).requestFocus(priceFocus),
                                    // controller: invoiceController,
                                    // readOnly: provider.selectedItem != null && provider.selectedItem!.proGroupId == 1,
                                    // inputFormatters: [doubleFilter],
                                    // onChanged: (value) async {
                                    //   if (value.isEmpty) return;
                                    //   provider.quantityOfUnit = num.parse(value);
                                    //   provider.sellPrice = await provider.getItemPrice(
                                    //       context.read<ClientProvider>().clintSelected!.id!,
                                    //       provider.quantityOfUnit!,
                                    //       context);
                                    //   provider.calcRow();
                                    //   setState(() {});
                                    // },
                                  ),
                                ),
                                Container(
                                  // width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(children: [
                                    Container(
                                      // width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TypeAheadFormField<GlPayDTO>(
                                        // initialValue: kha != null?kha.customerName.toString():"",
                                          itemBuilder: (context, client) {
                                            return SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: Text("${client.bankName} ${client.serial}"),
                                              ),
                                            );
                                          },
                                          suggestionsCallback: (filter) => controller.allInvoices,
                                          onSuggestionSelected: (value) {
                                            print(value.bankName);
                                            // controller.addinvoice();
                                            controller.bankController(kha).text = "${value.bankName}";
                                          },
                                          textFieldConfiguration: TextFieldConfiguration(
                                            textInputAction: TextInputAction.next,
                                            controller: controller.bankController(kha),
                                            focusNode: controller.bankNodes(kha),
                                            // onEditingComplete: () => controller.addinvoice(),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                disabledBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                // hintText: "ابحث عن فاتورة لعميل معين",
                                                isDense: true,
                                                hintMaxLines: 1,
                                                contentPadding: EdgeInsets.all(5),
                                                suffixIconConstraints: BoxConstraints(maxWidth: 50),
                                                suffixIcon: IconButtonWidget(
                                                  icon: Icons.search,
                                                  onPressed: () {
                                                    controller.getCustomersByCodeForInvoice(controller.bankNodes(kha));
                                                  },
                                                )),
                                          )),
                                    ),
                                  ]),
                                ),
                                Container(
                                  // width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextFormField(
                                    // focusNode: invoiceFocus,
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
                                    /////////////quantity
                                    // onEditingComplete: () => FocusScope.of(context).requestFocus(priceFocus),
                                    // controller: invoiceController,
                                    // readOnly: provider.selectedItem != null && provider.selectedItem!.proGroupId == 1,
                                    // inputFormatters: [doubleFilter],
                                    // onChanged: (value) async {
                                    //   if (value.isEmpty) return;
                                    //   provider.quantityOfUnit = num.parse(value);
                                    //   provider.sellPrice = await provider.getItemPrice(
                                    //       context.read<ClientProvider>().clintSelected!.id!,
                                    //       provider.quantityOfUnit!,
                                    //       context);
                                    //   provider.calcRow();
                                    //   setState(() {});
                                    // },
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 2, 3, 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // controller.addinvoice();
                                                  //
                                                  // print(controller.allInvoicesSelected);

                                                  controller.editInvoice(controller.allInvoicesSelected, 22);

                                                  // context.read<TobyPayProvider>().delete(kha);
                                                },
                                                child: Container(
                                                  alignment: Alignment.centerRight,
                                                  height: size.height * .045,
                                                  width: size.width * .045,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                                    color: coloryellow,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Text(
                                                        'تعديل',
                                                        style: smallTextStyleNormal(size, color: Colors.black),
                                                      ),
                                                      Icon(
                                                        Icons.edit,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 2, 3, 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // context.read<TobyPayProvider>().delete(kha);
                                                },
                                                child: Container(
                                                  alignment: Alignment.centerRight,
                                                  height: size.height * .045,
                                                  width: size.width * .04,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                                    color: coloryellow,
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
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 2, 2, 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // context.read<TobyPayProvider>().delete(kha);
                                                },
                                                child: Container(
                                                  alignment: Alignment.centerRight,
                                                  height: size.height * .045,
                                                  width: size.width * .045,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                                    color: coloryellow,
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
                              ],
                              decoration:
                              BoxDecoration(color: appGreyLight, borderRadius: BorderRadius.only(topRight: Radius.circular(0), topLeft: Radius.circular(0))),
                            )
                        ],
                      )),
                ),
              ],
            ),
          ));
    });
  }
}
