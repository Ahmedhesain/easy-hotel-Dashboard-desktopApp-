import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/colors.dart';
import 'package:toby_bills/app/components/date_field_widget.dart';
import 'package:toby_bills/app/components/text_styles.dart';
import 'package:toby_bills/app/core/utils/excel_helper.dart';
import 'package:toby_bills/app/core/utils/printing_methods_helper.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_items_response.dart';
import 'package:toby_bills/app/modules/reports/categories_items/controllers/categories_items_controller.dart';


class CategoriesItemsView extends GetView<CategoriesItemsController> {
  const CategoriesItemsView({super.key});

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
                      height: size.height,
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
                                height: size.height*.3,
                                width: size.width*.95,
                                child: Column(
                                  children: [

                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                        child: Row(
                                          children: [

                                             Text('المعرض  ',style: smallTextStyleNormal(size)),
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
                                                      options: controller.deliveryPlaces.map((e) => e.name??"").toList(),
                                                      selectedValues: controller.selectedDeliveryPlace.map((e) => e.name??"").toList(),
                                                      onChanged: controller.selectNewDeliveryplace,
                                                      decoration: const InputDecoration(
                                                        isDense: true,
                                                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                                                        border: OutlineInputBorder(),
                                                      ),

                                                      childBuilder: (List<String> values) {
                                                        return Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Align(
                                                            alignment: Alignment.centerRight,
                                                            child: Text(
                                                              values.isEmpty ? "يرجى تحديد معرض على الاقل" : values.where((element) => element != "تحديد الكل").join(', '),
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }),
                                            ),


                                            ),
                                            SizedBox(width: size.width*.08,)


                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                        child: Row(
                                          children: [

                                         Text('من تاريخ',style: smallTextStyleNormal(size)),
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
                                            Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: Text('رصيد اقل من',style: smallTextStyleNormal(size)),
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
                                            controller.categoryController.text =value;

                                          },
                                        ),
                                      ),
                                    ),
                                             SizedBox(width: size.width*.05,)

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
                                                child:Row(children: [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                    child: Text('اختيار الفواتير التي  لها باقي فقط',style: smallTextStyleNormal(size)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                    child:  Checkbox(value: controller.checkBoxValueNotzero.value,
                                                      activeColor: Colors.green,
                                                      onChanged:(bool? newValue){

                                                        controller.checkBoxValueNotzero.value = newValue!;
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                    child: Text('اختيار الفواتير التي ليس لها باقي فقط',style: smallTextStyleNormal(size)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                    child:  Checkbox(value: controller.checkBoxValuezero.value,
                                                      activeColor: Colors.green,
                                                      onChanged:(bool? newValue){

                                                        controller.checkBoxValuezero.value = newValue!;
                                                      },
                                                    ),
                                                  ),




                                                ],)

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
                                                child:Row(children: [

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                    child: Text('اختيار الفواتير التي  لها رصيد اقل من ',style: smallTextStyleNormal(size)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                                    child:  Checkbox(value: controller.checkBoxValueRemain.value,
                                                      activeColor: Colors.green,
                                                      onChanged:(bool? newValue){

                                                        controller.checkBoxValueRemain.value = newValue!;
                                                      },
                                                    ),
                                                  ),



                                                ],)

                                            ),


                                          ],
                                        ),
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
                                                    controller.getCategoriesItems();
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
                                                      onPressed: controller.reports.isEmpty ? null : () => PrintingHelper().printCategoriesItems(context, controller.reports,controller.dateFrom.value!),
                                                      child: const Text("طباعة"),
                                                    );
                                                  }),
                                                ),
                                                const SizedBox(width: 10),
                                                UnconstrainedBox(
                                                  child: Obx(() {
                                                    return ElevatedButton(
                                                      onPressed: controller.reports.isEmpty ? null : () => ExcelHelper.CategoriesItemsExcel(controller.reports, context),
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
                              SizedBox(width:size.width*.03,
                                  height: size.height*.03,child:const SizedBox()),
                            ),
                          ),
                          SizedBox(
                              width:size.width,
                              height:size.height*.59,
                              child:SingleChildScrollView(physics:  const AlwaysScrollableScrollPhysics(),
                                child: Column(children: [
                                  Container(
                                    margin: const EdgeInsets.all(0),
                                    child: Table(
                                      defaultColumnWidth: FixedColumnWidth(size.width * .0965),
                                      border: TableBorder.all(
                                          borderRadius: const BorderRadius.all(Radius.circular(0)),
                                          color: Colors.grey,
                                          style: BorderStyle.solid,
                                          width: 1),
                                      children: [

                                        TableRow(children: [

                                          Column(children: const [Text('المعرض',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: const [Text('رقم',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: const [Text('التاريخ',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: const [Text('رقم العميل',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: const [Text('العميل',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: const [Text('قيمه الفاتوره',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),

                                          Column(children: const [Text('صافي الفاتوره',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: const [Text('المسدد',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: const [Text('الباقي',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),
                                          Column(children: const [Text('الحاله',
                                              style: TextStyle(fontSize: 20.0))
                                          ]),




                                        ],
                                          decoration: const BoxDecoration(color: appGreyDark,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(0),
                                                  topLeft: Radius.circular(0))),
                                        ),

                                          for(CategoriesItemsResponse kha in controller.reports)
                                            TableRow(children: [
                                              Column(children: [
                                                Text(
                                                    kha.galleryName!,
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.serial!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),

                                              Column(children: [
                                                Text(
                                                    DateFormat("yyyy-MM-dd").format(kha.invoiceDate!),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.code!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.name!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.totalAfterTax!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.totalBeforeTax!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.paid!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.remain!.toString(),
                                                    style: const TextStyle(fontSize: 20.0))
                                              ]),
                                              Column(children: [
                                                Text(
                                                    kha.invoiceStatus??"",
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
                        ],)
                  ),
                )







            ),
          )
      );
    });
  }
}