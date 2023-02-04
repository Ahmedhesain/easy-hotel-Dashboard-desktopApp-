


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/dropdown_widget.dart';
import 'package:toby_bills/app/core/utils/crm_printing_helper.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/crm_reports/customers/controllers/customers_controller.dart';
import 'package:toby_bills/app/modules/crm_reports/customers/views/widgets/send_msg_dialog.dart';

import '../../../../../data/model/crm_reports/dto/customers_statue_dto.dart';

class CustomerReportHeader extends GetView<CustomersController> {
  const CustomerReportHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    const spaceV = SizedBox(width: 20,);
    const space = SizedBox(height: 20,);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0 , 5 , 15 , 0  ),
      child: Card(
          color: AppColors.backGround,
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.05,
                                child: const Center(
                                    child: Text(
                                      'المعرض :',
                                      textDirection: TextDirection.rtl,
                                    )),
                              ),
                              Center(
                                child: Obx(() {
                                  return SizedBox(
                                    width: size.width * 0.15,
                                    child: DropDownMultiSelect(
                                      key: UniqueKey(),
                                      options: controller.deliveryPlaces.map((e) => e.name??"").toList(),
                                      selectedValues: controller.selectedDeliveryPlace.map((e) => e.name ?? "").toList(),
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
                            ],
                          ),
                        ),
                        spaceV,
                        SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.05,
                                child: const Center(
                                    child: Text(
                                      'الشركة :',
                                      textDirection: TextDirection.rtl,
                                    )),
                              ),
                              Center(
                                child: Obx(() {
                                  return SizedBox(
                                    width: size.width * 0.2,
                                    child: DropDownMultiSelect(
                                      key: UniqueKey(),
                                      options: controller.companiesList.map((e) => e.name??"").toList(),
                                      selectedValues: controller.selectedCompanies.map((e) => e.name ?? "").toList(),
                                      onChanged: controller.selectNewCompanies,
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
                                              values.isEmpty ? "يرجى تحديد شركة" : values.where((element) => element != "تحديد الكل").join(', '),
                                              maxLines: 1,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                        spaceV,
                        SizedBox(
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.07,
                                child: const Center(
                                    child: Text(
                                      'حالة العملاء :',
                                      textDirection: TextDirection.rtl,
                                    )),
                              ),
                              Center(
                                child: Obx(() {
                                  return SizedBox(
                                    width: size.width * 0.12,
                                    height: size.height * 0.045,
                                    child: DropDownWidget<int?>(
                                      key: UniqueKey(),
                                      items: controller.customerStatues.map((e) => DropdownMenuItem<int?>(value: e.value,child: Text(e.name) ,)).toList(),
                                      value: controller.selectedStatue.value,
                                      onChanged: (value) => controller.selectedStatue.value = value,
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  space,
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonWidget(text: "بحث", onPressed: () => controller.search(), buttonColor: Colors.green, contentPadding: EdgeInsets.all(15),),
                        spaceV,
                        ButtonWidget(text: "طباعة", onPressed: () => CrmPrintingHelper().crmCustomers(context, controller.filteredReportList),contentPadding: const EdgeInsets.all(15),),
                        spaceV,
                        ButtonWidget(text: "ارسال رسالة", onPressed: () =>  Get.dialog(const SendMsgDialog()),contentPadding: const EdgeInsets.all(15), buttonColor: Colors.indigo[100],),
                        spaceV,
                        ButtonWidget(text: "رجوع", onPressed: () => Get.back(), buttonColor: Colors.redAccent,contentPadding: EdgeInsets.all(15),)

                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
