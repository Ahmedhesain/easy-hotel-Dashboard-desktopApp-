


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/date_field_widget.dart';
import 'package:toby_bills/app/components/text_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';

import '../../controllers/customer_report_by_invoice_controller.dart';

class CustomersReportByInvoiceHeadWidget extends GetView<CustomersReportByInvoiceController> {
  const CustomersReportByInvoiceHeadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const space = SizedBox(width: 20,) ;
    const spaceV = SizedBox(height: 10,);
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      child: Card(
        color: AppColors.backGround,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Padding(
                      padding : const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                            width: size.width * 0.1,
                            child: const TextWidget("قيمة الفاتورة" , size: 15, weight: FontWeight.bold,)),
                      ),
                      space,
                      Container(
                        width: size.width * 0.1,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color :AppColors.appGreyLight,),
                          child: TextField(
                          controller: controller.invoiceValueFrom,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            label: TextWidget("من")
                          ),
                        ),
                      ),
                      space,
                      Container(
                        width: size.width * 0.1,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color :AppColors.appGreyLight,

                        ),
                        child: TextField(
                          controller: controller.invoiceValueTo,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              label: TextWidget("الي")
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                spaceV,
                SizedBox(
                  width: size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding : const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                              width: size.width * 0.1,
                              child: const TextWidget("عدد الثياب" , size: 15, weight: FontWeight.bold,))),
                      space,
                      Container(
                        width: size.width * 0.1,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color :AppColors.appGreyLight,),
                          child: TextField(
                          controller: controller.invoiceNumberFrom,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            label: TextWidget("من")
                          ),
                        ),
                      ),
                      space,
                      Container(
                        width: size.width * 0.1,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color :AppColors.appGreyLight,

                        ),
                        child: TextField(
                          controller: controller.invoiceNumberTo,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              label: TextWidget("الي")
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                spaceV,
                SizedBox(
                  width: size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding : const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: size.width * 0.1,
                          child: const TextWidget("تاريخ الشراء" , size: 15, weight: FontWeight.bold,),
                        ),
                      ),
                      space,
                      Container(
                        width: size.width * 0.1,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color :AppColors.appGreyLight,),
                          child: DateFieldWidget(
                          date: controller.invoiceDateFrom.value,
                            label: "من",
                            hideBorder: true,
                            onComplete: (DateTime date) {
                                controller.invoiceDateFrom.value = date ;
                              },
                        ),
                      ),
                      space,
                      Container(
                        width: size.width * 0.1,
                        height: size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color :AppColors.appGreyLight,

                        ),
                        child: DateFieldWidget(
                          date: controller.invoiceDateTo.value,
                          label: "الي",
                          hideBorder: true,
                          onComplete: (DateTime date) {
                            controller.invoiceDateTo.value = date;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                spaceV,
              ],
            ),
          ),
      ),
    );
  }
}
