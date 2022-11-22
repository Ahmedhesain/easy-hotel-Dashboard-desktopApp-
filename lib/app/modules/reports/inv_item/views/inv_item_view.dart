import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/colors.dart';
import 'package:toby_bills/app/components/date_field_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/components/text_styles.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/inv_item_dto_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/modules/reports/inv_item/controllers/inv_item_controller.dart';
import 'package:toby_bills/app/modules/reports/profit_sold/controllers/profit_sold_controller.dart';


class InvItemView extends GetView<InvItemController> {
  const InvItemView({super.key});



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 20, 15, 0),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    color: appGreyDark,
                                    border: Border.all(color: Colors.grey)),
                                height: size.height*.25,
                                width: size.width*.95,
                                child: Column(
                                  children: [

                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                        child: Row(
                                          children: [



                                            SizedBox(width: size.width*.08,),
                                            Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text('الاصناف المستخدمه',style: smallTextStyleNormal(size)),
                  ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                              child:  Checkbox(value: controller.checkBoxValue.value,
                                                activeColor: Colors.green,
                                                onChanged:(bool? newValue){

                                                  controller.checkBoxValue.value = newValue!;
                                                },
                                              ),
                                            ),


                                            SizedBox(width: size.width*.2,),
                                               Text('الفئه',style: smallTextStyleNormal(size)),
                                              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Container(
                  width: size.width * .2,
                  height: size.height * .045,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5)),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)),
                  child:
                  Obx(() {
                    return SizedBox(
                      width: 200,
                      child: DropDownMultiSelect(
                        key: UniqueKey(),
                        options: controller.groups.map((e) => e.name ?? "").toList(),
                        selectedValues: controller.selectedGroup.map((e) => e.name ?? "").toList(),
                        onChanged: controller.selectNewDeliveryplace,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          border: OutlineInputBorder(),
                          // contentPadding: EdgeInsets.all(10),
                          // isDense: true,
                        ),

                        childBuilder: (List<String> values) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                values.isEmpty ? "يرجى تحديد نوع على الاقل" : values.where((element) => element != "تحديد الكل").join(', '),
                                maxLines: 1,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  // Obx(() {
                  //   return DropdownSearch<DeliveryPlaceResposne>(
                  //     // showSearchBox: true,
                  //     items: controller.deliveryPlaces,
                  //     itemAsString: (DeliveryPlaceResposne e) => e.name,
                  //     onChanged: controller.selectedDeliveryPlace,
                  //     selectedItem: controller.selectedDeliveryPlace.value,
                  //     dropdownDecoratorProps: const DropDownDecoratorProps(
                  //       dropdownSearchDecoration: InputDecoration(
                  //         border: OutlineInputBorder(),
                  //         contentPadding: EdgeInsets.all(10),
                  //         isDense: true,
                  //       ),
                  //     ),
                  //   );
                  // }),                                              ),
                ),


              ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                        child: Row(
                                          children: [





                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                              child: Text('التكلفه اقل من او تساوي',style: smallTextStyleNormal(size)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                              child: Container(
                                                width: size.width * .2,
                                                height: size.height * .045,
                                                decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
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
                                                  controller: controller.categoryController,
                                                  // readOnly: provider.selectedItem != null && provider.selectedItem!.proGroupId == 1,
                                                  // inputFormatters: [doubleFilter],
                                                  onChanged: (value)  {
                                                  },
                                                ),
                                              ),
                                            ),



                                          ],
                                        ),
                                      ),
                                    ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
  children: [
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: Text('طبيعه الصنف',style: smallTextStyleNormal(size)),
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Container(
        width: size.width * .25,
        height: size.height * .04,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                  Radius.circular(5)),
            color: Colors.white,
            border: Border.all(color: Colors.grey)),
        child:
        DropdownButton<int>(
          value: controller.selectedStatus.value,
          onChanged: (int? newVal) {
            controller.selectedStatus.value = newVal!;
          },
          items: controller.discBasis.entries.map((e) {
            return DropdownMenuItem<int>(
              value: e.key,
              child: Text(e.value),
            );
          }).toList(),                                              ),
      ),
    ),
    Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
        child: Row(
          children: [

            SizedBox(width: size.width*.1,)
            , Text('من تاريخ',style: smallTextStyleNormal(size)),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * .3,
              child: DateFieldWidget(
                  fillColor: Colors.white,
                  onComplete: (date){
                    controller.dateFrom(date);
                  },
                  date: controller.dateFrom.value,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            //   child:
            //   Container(
            //     width: size.width * .3,
            //     height: size.height * .04,
            //     decoration: BoxDecoration(
            //       color: Colors.white70,
            //       borderRadius: BorderRadius.circular(5),
            //
            //     ),child:
            //
            //   Center(
            //     child: MouseRegion(
            //       cursor: SystemMouseCursors.click,
            //       child: GestureDetector(
            //           onTap: () {
            //             controller.pickFromDate();
            //           },
            //           child: Obx(() {
            //             return Text(
            //               controller.dateFrom.value == null ? "yyyy-mm-dd":DateFormat("yyyy-MM-dd").format(controller.dateFrom.value!),
            //               style: const TextStyle(decoration: TextDecoration.underline),
            //             );
            //           })),
            //     ),
            //   ),
            //
            //
            //
            //
            //   ),
            // ),
          ],
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
                                                // controller.getStatements();
                                                // context.read<TobyEditBillsProvider>().getEditBillsScreenGroups(182, numController.text, startdate, enddate);
                                                // glpaydtolist = context.read<TobyEditBillsProvider>().glBankList ;
                                                // setState(() {
                                                //
                                                // });
                                              },

                                              child:Row(children: [

                                                const SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: (){
                                                    controller.getInvItemSold();
                                                  },
                                                  child: Container(alignment: Alignment.centerRight,

                                                    height: size.height * .05,
                                                    width: size.width * .1,
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.all(
                                                          Radius.circular(6.00)), color:coloryellow,
                                                    ),
                                                    child: Row(mainAxisAlignment: MainAxisAlignment
                                                        .spaceAround,
                                                      children: [
                                                        Text('بحث',
                                                          style: smallTextStyleNormal(size,color: Colors.black),),
                                                        const Icon(Icons.search,color: Colors.black,)
                                                      ],
                                                    ),

                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  height: size.height * .048,
                                                  width: size.width * .1,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.all(
                                                        Radius.circular(6.00)),
                                                    color:coloryellow,
                                                  ),
                                                  child: ElevatedButton(
                                                    child: const Text("رجوع"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                UnconstrainedBox(
                                                  child: Obx(() {
                                                    return ElevatedButton(
                                                      onPressed: controller.reports.isEmpty ? null : () => PrintingHelper().printInvItem(context, controller.reports),
                                                      child: const Text("طباعة"),
                                                    );
                                                  }),
                                                ),
                                                const SizedBox(width: 10),
                                                UnconstrainedBox(
                                                  child: Obx(() {
                                                    return ElevatedButton(
                                                      onPressed: controller.reports.isEmpty ? null : () => ExcelHelper.InvtemExcel(controller.reports, context),
                                                      child: const Text("تصدير الى اكسل"),
                                                    );
                                                  }),
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
                                  height: size.height*.03,child:const SizedBox()),
                            ),
                          ),
                          Container(
                              width:size.width,
                              height:size.height*.62,
                              child:SingleChildScrollView(physics:  const AlwaysScrollableScrollPhysics(),
                                child: Column(children: [
                                  Container(
                                    margin: const EdgeInsets.all(0),
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(size.width * .0745),
                                      border: TableBorder.all(
                                          borderRadius: const BorderRadius.all(Radius.circular(0)),
                                          color: Colors.grey,
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [

                                        TableRow(children: [
                                          Column(children: [const Text('رقم الصنف',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text('اسم الصنف',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text('التكلفه',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text('اعلي سعر للرجال',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text('اعلي سعر للشباب',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text('اقل سعر للرجال',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text('اقل سعر للشباب',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text('عدد الامتار المجانيه للرجال',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text('عدد الامتار المجانيه للشباب',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [const Text('عدد الامتار للرجال',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: [Center(
                                            child: const Text('عدد الامتار للشباب',
                                                style: TextStyle(fontSize: 20.0)),
                                          )
                                          ]),
                                          Column(children: [Center(
                                            child: const Text('طبيعه الصنف',
                                                style: TextStyle(fontSize: 20.0)),
                                          )
                                          ]),
                                          Column(children: [Center(
                                            child: const Text('المتاح',
                                                style: TextStyle(fontSize: 20.0)),
                                          )
                                          ]),




                                        ],
                                          decoration: const BoxDecoration(color: appGreyDark,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(0),
                                                  topLeft: Radius.circular(0))),
                                        ),
                                        if(controller.reports != null)


                                          for(InvItemDtoResponse kha in controller.reports??[] )
                                            TableRow(children: [
                                              Column(children: [
                                                Text(
                                                    kha.code!,
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.name!,
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),

                                              Column(children: [
                                                Text(
                                                    kha.sellPrice!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.maxpricemen!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.maxpriceyoung!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.minpricemen!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.minpriceyoung!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.numbermetersfreemen!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]), Column(children: [
                                                Text(
                                                    kha.numbermetersfreeyoung!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]), Column(children: [
                                                Text(
                                                    kha.numbermetersmen!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]), Column(children: [
                                                Text(
                                                    kha.numbermetersyoung!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.itemNatural!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]), Column(children: [
                                                Text(
                                                    kha.quantity!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),


                                            ],
                                              decoration: const BoxDecoration( color: appGreyLight,
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
