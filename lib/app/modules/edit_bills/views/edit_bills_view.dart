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

import '../../../components/table.dart';
import '../controllers/edit_bills_controller.dart';

class EditBillsView extends GetView<EditBillsController> {
  const EditBillsView({super.key});



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime enddate =DateTime.now();
    DateTime startdate =DateTime.now();


    var numController = TextEditingController();
    var itemQuantityController = TextEditingController();
    var clientController = TextEditingController();
    var priceController = TextEditingController();
    var invoiceController = TextEditingController();
    var infoController = TextEditingController();

    return Obx(() {
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child:Scaffold(
          body:  Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Center(
                child: Container(width: size.width*.97,
                    height: size.height*.96,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 20, 15, 0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)),
                                  color: appGreyDark,
                                  border: Border.all(color: Colors.grey)),
                              height: size.height*.22,
                              width: size.width*.95,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Text('رقم السند',style: subTitleTextStyle(size),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                    child: Container(
                                      width: size.width * .3,
                                      height: size.height * .03,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey)),
                                      child:
                                      TextFormField(
                                        // focusNode: quantityFocus,
                                        textAlign: TextAlign.center,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
                                        /////////////quantity
                                        // onEditingComplete: () => FocusScope.of(context).requestFocus(priceFocus),
                                        controller: controller.selectedStatus,
                                        // readOnly: provider.selectedItem != null && provider.selectedItem!.proGroupId == 1,
                                        // inputFormatters: [doubleFilter],
                                        onChanged: (value)  {
                                        },
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      children: [

                                        SizedBox(width: size.width*.05,)
                                        , Text('من تاريخ',style: subTitleTextStyle(size)),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child:
                                          Container(
                                            width: size.width * .3,
                                            height: size.height * .04,
                                            decoration: BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius: BorderRadius.circular(5),

                                            ),child:

                                          Center(
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    controller.pickFromDate();
                                                  },
                                                  child: Obx(() {
                                                    return Text(
                                                        controller.dateFrom.value == null ? "yyyy-mm-dd":DateFormat("yyyy-MM-dd").format(controller.dateFrom.value!),
                                                      style: const TextStyle(decoration: TextDecoration.underline),
                                                    );
                                                  })),
                                            ),
                                          ),




                                          ),
                                        ),
                                        SizedBox(width: size.width*.1,)
                                        ,Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                          child: Text('الي تاريخ',style: subTitleTextStyle(size)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                          child: Container(
                                            width: size.width * .3,
                                            height: size.height * .04,
                                            decoration: BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius: BorderRadius.circular(5),

                                            ),child:

                                          Center(
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    controller.pickToDate();
                                                  },
                                                  child: Obx(() {
                                                    return Text(
                                                      controller.dateTo.value == null ? "yyyy-mm-dd":DateFormat("yyyy-MM-dd").format(controller.dateTo.value!),
                                                      style: const TextStyle(decoration: TextDecoration.underline),
                                                    );
                                                  })),
                                            ),
                                          ),




                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, size.height * .01, 0, 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            controller.getStatements();
                                            // context.read<TobyEditBillsProvider>().getEditBillsScreenGroups(182, numController.text, startdate, enddate);
                                            // glpaydtolist = context.read<TobyEditBillsProvider>().glBankList ;
                                            // setState(() {
                                            //
                                            // });
                                          },

                                          child:Row(children: [

                                            const SizedBox(width: 10),
                                            Container(alignment: Alignment.centerRight,

                                              height: size.height * .05,
                                              width: size.width * .1,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6.00)), color:coloryellow,
                                              ),
                                              child: Row(mainAxisAlignment: MainAxisAlignment
                                                  .spaceAround,
                                                children: [
                                                  Text('بحث',
                                                    style: smallTextStyleNormal(size,color: Colors.black),),
                                                  Icon(Icons.search,color: Colors.black,)
                                                ],
                                              ),

                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              height: size.height * .048,
                                              width: size.width * .1,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6.00)),
                                                color:coloryellow,
                                              ),
                                              child: ElevatedButton(
                                                child: Text("رجوع"),
                                                onPressed: () => Get.back(),
                                              ),
                                            ),
                                          ],)

                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              )


                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            color: coloryellow,
                            width:size.width*.97,
                            height: size.height*.06,
                            child:
                            Container(width:size.width*.03,
                                height: size.height*.03,child:SizedBox()),
                          ),
                        ),
                        Container(
                            width:size.width,
                            height:size.height*.45,
                            child:SingleChildScrollView(physics:  const AlwaysScrollableScrollPhysics(),
                              child: Column(children: [
                                Container(
                                  margin: EdgeInsets.all(0),
                                  child: Table(
                                    defaultColumnWidth: FixedColumnWidth(size.width * .138),
                                    border: TableBorder.all(
                                        borderRadius: BorderRadius.all(Radius.circular(0)),
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1),
                                    children: [

                                      TableRow(children: [
                                        Column(children: [Text('رقم السند',
                                            style: TextStyle(fontSize: 20.0))
                                        ]),
                                        Column(children: [Text('التاريخ',
                                            style: TextStyle(fontSize: 20.0))
                                        ]),
                                        Column(children: [Text('العميل',
                                            style: TextStyle(fontSize: 20.0))
                                        ]),
                                        Column(children: [Text('المبلغ',
                                            style: TextStyle(fontSize: 20.0))
                                        ]),
                                        Column(children: [Text('الخزنه',
                                            style: TextStyle(fontSize: 20.0))
                                        ]),
                                        Column(children: [Text('الملاحظات',
                                            style: TextStyle(fontSize: 20.0))
                                        ]),
                                        Column(children: [Text('الحركه',
                                            style: TextStyle(fontSize: 20.0))
                                        ]),




                                      ],
                                        decoration: BoxDecoration(color: appGreyDark,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(0),
                                                topLeft: Radius.circular(0))),
                                      ),
                                      if(controller.reports != null)


                                        for(GlPayDTO kha in controller.reports??[] )
                                          TableRow(children: [
                                            Column(children: [
                                              Text(
                                                  kha.serial!.toString(),
                                                  style: TextStyle(fontSize: 20.0))
                                            ]),
                                            Column(children: [
                                              Container(

                                                // width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child:
                                                TextFormField(



                                                  // focusNode: invoiceFocus,
                                                  initialValue: kha != null?DateFormat("yyyy-MM-dd").format(kha.date!).toString():"",
                                                  textAlign: TextAlign.center,
                                                  decoration: const InputDecoration(
                                                      border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
                                                  /////////////quantity
                                                  // onEditingComplete: () => FocusScope.of(context).requestFocus(priceFocus),
                                                  // controller: invoiceController,
                                                  // readOnly: provider.selectedItem != null && provider.selectedItem!.proGroupId == 1,

                                                  // inputFormatters: [doubleFilter],
                                                  onTap: (){
                                                    showDatePicker(
                                                      context: context,
                                                      initialDate: DateTime.now(),
                                                      firstDate: DateTime(2022),
                                                      lastDate: DateTime(2030),
                                                    ).then((value){
                                                      if(value!= null){
                                                        // setState(() {
                                                        //   newdate=value ;
                                                        //  }
                                                        // );
                                                      }
                                                    });
                                                  },                                                // onChanged: (value) async {
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
                                            ]),

                                            Column(children: [
                                              Container(
                                                // width: 100,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child:
                                                TypeAheadFormField<FindCustomerResponse>(
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
                                            ]),

                                            Column(children: [
                                              Container(
                                                // width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child:
                                                TextFormField(
                                                  // focusNode: invoiceFocus,
                                                  initialValue: kha!= null?kha.value.toString():"",
                                                  textAlign: TextAlign.center,
                                                  decoration: const InputDecoration(
                                                      border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
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
                                            ]),
                                            Column(children: [
                                              Container(
                                                // width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child:
                                                Column(children: [
                                                  Container(
                                                    // width: 100,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white70,
                                                      borderRadius: BorderRadius.circular(5),
                                                    ),
                                                    child:
                                                    TypeAheadFormField<GlPayDTO>(
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
                                                          controller.bankController(kha).text = "${value.bankName} ";

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

                                                    //   DropdownSearch<GlPayDTO>(
                                                    //   // showSearchBox: true,
                                                    //   items: controller.allInvoices,
                                                    //   itemAsString: (GlPayDTO e) => e.bankName!,
                                                    //   // onSaved: controller.getAllInvoices(),
                                                    //   selectedItem: controller.ivoiceSelected,
                                                    //
                                                    //   dropdownDecoratorProps: const DropDownDecoratorProps(
                                                    //     dropdownSearchDecoration: InputDecoration(
                                                    //       border: OutlineInputBorder(),
                                                    //       contentPadding: EdgeInsets.all(10),
                                                    //       isDense: true,
                                                    //     ),
                                                    //   ),
                                                    // )
                                                    // TextFormField(
                                                    //   // focusNode: invoiceFocus,
                                                    //   initialValue: kha != null?kha.bankName:"",
                                                    //   textAlign: TextAlign.center,
                                                    //   decoration: const InputDecoration(
                                                    //       border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
                                                    //   /////////////quantity
                                                    //   // onEditingComplete: () => FocusScope.of(context).requestFocus(priceFocus),
                                                    //   // controller: invoiceController,
                                                    //   // readOnly: provider.selectedItem != null && provider.selectedItem!.proGroupId == 1,
                                                    //   // inputFormatters: [doubleFilter],
                                                    //   // onChanged: (value) async {
                                                    //   //   if (value.isEmpty) return;
                                                    //   //   provider.quantityOfUnit = num.parse(value);
                                                    //   //   provider.sellPrice = await provider.getItemPrice(
                                                    //   //       context.read<ClientProvider>().clintSelected!.id!,
                                                    //   //       provider.quantityOfUnit!,
                                                    //   //       context);
                                                    //   //   provider.calcRow();
                                                    //   //   setState(() {});
                                                    //   // },
                                                    // ),

                                                  ),
                                                ]),

                                              ),
                                            ]),
                                            Column(children: [
                                              Container(
                                                // width: 100,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child:
                                                TextFormField(
                                                  // focusNode: invoiceFocus,
                                                  textAlign: TextAlign.center,
                                                  decoration: const InputDecoration(
                                                      border: OutlineInputBorder(), contentPadding: EdgeInsets.zero),
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

                                            ]),
                                            Column(children: [
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child: Row(children: [
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(0, 2, 3, 0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: (){
                                                              // controller.addinvoice();
                                                              //
                                                              // print(controller.allInvoicesSelected);

                                                              controller.editInvoice(controller.allInvoicesSelected,22);

                                                              // context.read<TobyPayProvider>().delete(kha);
                                                            },

                                                            child: Container(alignment: Alignment.centerRight,

                                                              height: size.height * .03,
                                                              width: size.width * .045,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(6.00)), color:coloryellow,
                                                              ),
                                                              child: Row(mainAxisAlignment: MainAxisAlignment
                                                                  .spaceAround,
                                                                children: [
                                                                  Text('تعديل',
                                                                    style: smallTextStyleNormal(size,color: Colors.black),),
                                                                  Icon(Icons.edit,color: Colors.black,)
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
                                                            onTap: (){
                                                              // context.read<TobyPayProvider>().delete(kha);
                                                            },

                                                            child: Container(alignment: Alignment.centerRight,

                                                              height: size.height * .03,
                                                              width: size.width * .04,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(6.00)), color:coloryellow,
                                                              ),
                                                              child: Row(mainAxisAlignment: MainAxisAlignment
                                                                  .spaceAround,
                                                                children: [
                                                                  Text('حذف',
                                                                    style: smallTextStyleNormal(size,color: Colors.black),),
                                                                  Icon(Icons.delete,color: Colors.black,)
                                                                ],
                                                              ),

                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),



                                                  ],),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0, 2, 2, 0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        // context.read<TobyPayProvider>().delete(kha);
                                                      },

                                                      child: Container(alignment: Alignment.centerRight,

                                                        height: size.height * .03,
                                                        width: size.width * .045,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(6.00)), color:coloryellow,
                                                        ),
                                                        child: Row(mainAxisAlignment: MainAxisAlignment
                                                            .spaceAround,
                                                          children: [
                                                            Text('طباعه',
                                                              style: smallTextStyleNormal(size,color: Colors.black),),
                                                            Icon(Icons.print,color: Colors.black,)
                                                          ],
                                                        ),

                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ]),


                                          ],
                                            decoration: BoxDecoration( color: appGreyLight,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(0),
                                                    topLeft: Radius.circular(0))),
                                          )








                                    ],
                                  ),
                                ),

                              ],),
                            )

                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        //   child: Container(
                        //     color: coloryellow,
                        //     width:size.width*.97,
                        //     height: size.height*.06,
                        //     child: Padding(
                        //       padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                        //       child: Container(
                        //           child:Row(children: [
                        //             index==0?
                        //             Padding(
                        //               padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
                        //               child: Row(children: [
                        //                 Padding(
                        //                   padding: EdgeInsets.fromLTRB(0, size.height * .001, size.width*.75, 0),
                        //                   child: Row(
                        //                     mainAxisAlignment: MainAxisAlignment.center,
                        //                     children: [
                        //                       GestureDetector(onTap: () {
                        //                         print('dfjdfjh');
                        //                         context.read<TobyPayProvider>().save(clientname!.id!,remarkselected.text , context.read<TobyPayProvider>().glPayDtoList,context.read<AuthProvider>().branchId,context.read<AuthProvider>().companyId,context.read<AuthProvider>().id,context);
                        //                         setState(() {
                        //                           index++;
                        //                         });
                        //
                        //                         print('2323');
                        //                       },
                        //                         child: Container(alignment: Alignment.centerRight,
                        //
                        //                           height: size.height * .05,
                        //                           width: size.width * .05,
                        //                           decoration: BoxDecoration(
                        //                             borderRadius: BorderRadius.all(
                        //                                 Radius.circular(6.00)), color:Colors.green,
                        //                           ),
                        //                           child: Row(mainAxisAlignment: MainAxisAlignment
                        //                               .spaceAround,
                        //                             children: [
                        //                               Text('حفظ',
                        //                                 style: smallTextStyleNormal(size,color: Colors.black),),
                        //                               Icon(Icons.save,color: Colors.black,)
                        //                             ],
                        //                           ),
                        //
                        //                         ),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ],),
                        //             ):
                        //             Padding(
                        //               padding: EdgeInsets.fromLTRB(0, 0, size.width*.8, 0),
                        //               child: Row(
                        //                 mainAxisAlignment: MainAxisAlignment.center,
                        //                 children: [
                        //
                        //                   GestureDetector(onTap: () {
                        //                     context.read<TobyPayProvider>().preprint(clientname!.id!,remarkselected.text , context.read<TobyPayProvider>().glPayDtoList,182,125,201,clientselected.text, context);
                        //                     // printInvoice(context.read<tobypayProvider>().glBankTransactionApi!,context);
                        //                     // create();
                        //                     // testReceipt('192.168.0.123', port: 9100);
                        //
                        //                   },
                        //                     child: Container(alignment: Alignment.centerRight,
                        //
                        //                       height: size.height * .05,
                        //                       width: size.width * .05,
                        //                       decoration: BoxDecoration(
                        //                         borderRadius: BorderRadius.all(
                        //                             Radius.circular(6.00)),
                        //                         color: Colors.green,
                        //                       ),
                        //                       child: Row(mainAxisAlignment: MainAxisAlignment
                        //                           .spaceAround,
                        //                         children: [
                        //                           Text('طباعه ',
                        //                             style: smallTextStyleNormal(size),),
                        //                           Icon(Icons.print)
                        //                         ],
                        //                       ),
                        //
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //
                        //
                        //           ],)),
                        //     ),
                        //   ),
                        // ),
                      ],)
                ),
              )







          ),
        )
      );
    });
  }
}
