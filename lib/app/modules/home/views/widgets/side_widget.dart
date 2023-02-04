import 'package:flutter/material.dart';
import 'package:toby_bills/app/components/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/text_field_widget.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_response.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:window_manager/window_manager.dart';
import '../../../../components/text_widget.dart';
import '../../../../routes/app_pages.dart';
import '../../../crm/views/add_crm_event_view.dart';
import 'notifications_widget.dart';

class SideWidget extends GetView<HomeController> {
  const SideWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .17,
      height: size.height,
      color: AppColors.appGreyDark,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Padding(
             padding: const EdgeInsets.all(5.0),
             child: ButtonWidget(text: "اضافة شكوي" , buttonColor: Colors.blue, onPressed: (){
               Get.toNamed(Routes.CRM_EVENT);
               windowManager.setTitle("Toby Bills -> CRM");
             }),
           ),
           const Divider(height: 2, color: Colors.white, ),
          _TitleWidget(title: 'الاجمالي', value: controller.totalNet),
          _TitleWidget(title: 'خصم الهالالات', value: controller.discountHalala),
          _TitleWidget(title: 'قيمة الإشعارات', value: controller.invoiceNoticeValue),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: Row(
              children: [
                const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text("نوع الخصم"),
                    )),
                Expanded(
                  flex: 2,
                  child: Obx(() {
                    return DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        isDense: true,
                      ),
                      dropdownColor: AppColors.appGreyLight,
                      value: controller.selectedDiscountType.value,
                      elevation: 0,
                      items: controller.discountType.entries
                          .map((e) => DropdownMenuItem<int>(
                                value: e.key,
                                child: Text(e.value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        controller.selectedDiscountType(value);
                        controller.calcInvoiceValues();
                      },
                      // value: provider.priceTypeSelected,
                    );
                  }),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: Row(
              children: [
                const Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text("خصم على الفاتورة"),
                    )),
                Expanded(
                  flex: 2,
                  child: Obx(() {
                    final isDiscountValue = controller.selectedDiscountType.value == 0;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: controller.invoiceDiscountController,
                        focusNode: controller.invoiceDiscountFieldFocusNode,
                        enabled: controller.canEdit,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 5),
                            isDense: true,
                            suffixIcon: Text(!isDiscountValue ? "%" : ""),
                            suffixIconConstraints: const BoxConstraints(minHeight: 10)),
                        onChanged: (value) {
                          if (value.isEmpty || num.tryParse(value) == null) {
                            controller.invoiceDiscountController.text = "0";
                          }
                          if (controller.invoiceDiscountController.text.parseToNum > 100 && controller.selectedDiscountType.value == 1) {
                            controller.invoiceDiscountController.text = "100";
                          }
                          controller.calcInvoiceValues();
                        },
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
          // _TitleWidget(title: 'خصم علي الفاتوره', value: controller.discount),
          _TitleWidget(title: 'بعد الخصم الكلي', value: controller.totalAfterDiscount),
          _TitleWidget(title: 'قيمه الضريبه', value: controller.tax),
          _TitleWidget(title: 'الصافي ضريبيا', value: controller.finalNet, fixedWith: 2),
          _TitleWidget(title: 'المبلغ المدفوع', value: controller.payed, fixedWith: 2),
          _TitleWidget(title: 'المبلغ المتبقي', value: controller.remain, fixedWith: 2),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFieldWidget(
              label: "كوبون الخصم",
              onChanged: (value) => controller.offerCoupon = value,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: size.height * 0.05,
            child: TypeAheadFormField<FindCustomerResponse>(
              key: UniqueKey(),
              itemBuilder: (context, client) {
                return Center(
                  child: Text(client.name.toString(), textAlign: TextAlign.center),
                );
              },
              onSuggestionSelected: (FindCustomerResponse client) => controller.getInvoiceListForCustomer(client),
              suggestionsCallback: (filter) => controller.customers,
              textFieldConfiguration: TextFieldConfiguration(
                  focusNode: controller.findSideCustomerFieldFocusNode,
                  controller: controller.findSideCustomerController,
                  onSubmitted: (value) => controller.getCustomersByCode(),
                  decoration: InputDecoration(border: OutlineInputBorder(), hintText: "ابحث عن عميل", isDense: true)),
              noItemFoundText: "لايوجد بيانات",
            ),
          ),
          const SizedBox(height: 10),
            SizedBox(
              height: size.height * 0.05,
              child: TypeAheadFormField<InvoiceList>(
                suggestionsCallback: (filter) => (controller.findCustomerBalanceResponse != null)
                    ? controller.findCustomerBalanceResponse!.invoicesList.where((element) => element.serial != null).toList()
                    : [],
                onSuggestionSelected: (value) {
                  controller.searchForInvoiceById(value.serial.toString());
                },
                itemBuilder: (context, inv) {
                  return SizedBox(
                    child: Text(inv.serial.toString(), textAlign: TextAlign.center),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                  controller: controller.searchedInvoiceController,
                  onSubmitted: controller.searchForInvoiceById,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "ابحث عن فاتورة",
                    isDense: true,
                  ),
                ),
              ),
            ),
          // ButtonWidget(
          //   text: "بحث",
          //   expanded: true,
          //   isOutlined: true,
          //   buttonColor: Colors.black54,
          //   fontColor: Colors.black54,
          //   onPressed: () => controller.searchForInvoiceById(controller.searchedInvoiceController.text),
          // ),
           const SizedBox(height: 10),
           const NotificationsWidget()
        ],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key, required this.title, required this.value, this.fixedWith = 5}) : super(key: key);
  final String title;
  final RxNum value;
  final int fixedWith;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextWidget(
                title,
                // style: smallTextStyleNormal(size),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Center(child: Obx(() {
              return TextWidget(value.toStringAsFixed(fixedWith));
            })),
          ),
        ],
      ),
    );
  }
}
