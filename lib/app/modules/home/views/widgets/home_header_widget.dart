import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/core/utils/double_filter.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:toby_bills/app/routes/app_pages.dart';
import 'package:window_manager/window_manager.dart';

class HomeHeaderWidget extends GetView<HomeController> {
  const HomeHeaderWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    final permissions = UserManager().user.userScreens["proworkorder"];
    final ScrollController scrollController = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 10,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: Obx(() {
                return SizedBox(
                  width: size.width *0.75,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ButtonWidget(text: "دفع", onPressed: () async {
                            Widget okButton = TextButton(
                              child: const Center(
                                  child: Text(
                                    "رجوع",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              onPressed: () {
                                Navigator.pop(context);
                                controller.calcInvoiceValues();
                              },
                            );
                            AlertDialog alert = AlertDialog(
                              title: const Center(
                                  child: Text(
                                    "الخزائن",
                                  )),
                              content: Directionality(
                                textDirection: TextDirection.rtl,
                                child: SizedBox(
                                  height: context.height * .4,
                                  width: context.width * .45,
                                  child: ListView.separated(
                                    itemCount: controller.glPayDtoList.length,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    separatorBuilder: (_, __) => SizedBox(height: 15),
                                    itemBuilder: (context, index) {
                                      final GlPayDTO kha = controller.glPayDtoList[index];
                                      return Container(
                                        // height: size.height * .15,
                                        // width: size.width * .4,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                          color: AppColors.appGreyDark,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                            const Text("الخزنه"),
                                            Expanded(
                                              child: Container(
                                                height: context.height * .05,
                                                margin: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Center(child: Text(kha.bankName!)),
                                              ),
                                            ),
                                            const Text(
                                              "المبلغ"
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: context.height * .05,
                                                margin: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Colors.white70,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: TextFormField(
                                                  initialValue: kha.value?.toString(),
                                                  onChanged: (value) => kha.value = double.tryParse(value),
                                                  inputFormatters: [doubleInputFilter],
                                                  decoration: const InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    border: OutlineInputBorder(borderSide: BorderSide()),
                                                  ),
                                                  textAlignVertical: TextAlignVertical.center,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            )
                                          ]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              actions: [
                                Center(
                                  child: Container(
                                      height: context.height * .06,
                                      width: context.width * .1,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(6.00)),
                                        color: AppColors.colorYellow,
                                      ),
                                      child: okButton),
                                ),
                              ],
                            );
                            // show the dialog
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                                barrierDismissible: false);
                            controller.calcInvoiceValues();
                          }),
                          const SizedBox(width: 5),
                          ButtonWidget(text: "سند القبض", onPressed: () async {
                            windowManager.setTitle("Toby Bills -> سند القبض");
                            await Get.toNamed(Routes.CATCH_RECEIPT);
                            windowManager.setTitle("Toby Bills -> شاشة المبيعات");
                          }),
                          const SizedBox(width: 5),
                          ButtonWidget(text: "كشف حساب عميل", onPressed: () async {
                            if(Get.find<HomeController>().selectedCustomer.value?.id == null) {
                              showPopupText(text: "يجب اختيار عميل اولاً");
                              return;
                            }
                            windowManager.setTitle("Toby Bills -> كشف حساب عميل");
                            await Get.toNamed(Routes.ACCOUNT_STATEMENT);
                            windowManager.setTitle("Toby Bills -> شاشة المبيعات");
                          }),
                          const SizedBox(width: 5),
                          ButtonWidget(text: "حالة الفاتورة", onPressed: () async {
                            if(Get.find<HomeController>().invoice.value?.id == null) {
                              showPopupText(text: "يجب اختيار فاتورة اولاً");
                              return;
                            }
                            windowManager.setTitle("Toby Bills -> حالة الفاتورة");
                            await Get.toNamed(Routes.INVOICE_STATUS);
                            windowManager.setTitle("Toby Bills -> شاشة المبيعات");
                          }),
                          const SizedBox(width: 5),
                          ButtonWidget(text: "مراحل الانتاج", onPressed: () async {
                            if(Get.find<HomeController>().invoice.value?.id == null) {
                              showPopupText(text: "يجب اختيار فاتورة اولاً");
                              return;
                            }
                            windowManager.setTitle("Toby Bills -> مراحل الانتاج");
                            await Get.toNamed(Routes.PRODUCTION_STAGES);
                            windowManager.setTitle("Toby Bills -> شاشة المبيعات");
                          }),
                          const SizedBox(width: 5),
                          ButtonWidget(text: "استعلام", onPressed: () async {
                            windowManager.setTitle("Toby Bills -> استعلام");
                            await Get.toNamed(Routes.INVOICES_QUERY);
                            windowManager.setTitle("Toby Bills -> شاشة المبيعات");
                          }),
                          const SizedBox(width: 5),
                          ButtonWidget(text: "تنزيل عرض", onPressed: () => controller.offerOne()),
                          const SizedBox(width: 5),
                          ButtonWidget(text: "تحديث", onPressed: () => controller.getItems()),
                          if((permissions?.edit ?? false) || controller.invoice.value?.id == null)
                            const SizedBox(width: 5),
                          if((permissions?.edit ?? false) || controller.invoice.value?.id == null)
                            ButtonWidget(text: "حفظ", onPressed: () => controller.saveInvoice()),
                          if((permissions?.add ?? false))
                            const SizedBox(width: 5),
                          if((permissions?.add ?? false))
                            ButtonWidget(text: "جديد", onPressed: () => controller.newInvoice()),
                          const SizedBox(width: 5),
                          ButtonWidget(text: "حذف هللة", onPressed: () => controller.removeHalala()),
                          const SizedBox(width: 5),
                          ButtonWidget(text: "إرجاع هللة", onPressed: () => controller.retreiveHalala()),
                          const SizedBox(width: 5),

                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            if (controller.invoice.value != null)
                              ButtonWidget(
                                  text: "طباعة",
                                  onPressed: () => controller.printInvoice(context)),
                            if (controller.invoice.value != null && (permissions?.edit ?? false))
                              const SizedBox(width: 5),
                            if (controller.invoice.value != null && (permissions?.edit ?? false))
                              ButtonWidget(text: "طباعة قيد", onPressed: () => controller.printGeneralJournal(context)),
                            if (controller.invoice.value != null)
                              const SizedBox(width: 5),
                            if(controller.invoice.value != null && controller.invoice.value?.gallaryDeliveryShow != null)
                              ButtonWidget(text: "تعديلات الفواتير", onPressed: () => controller.updateGallaryDeliveryShow()),
                            if((permissions?.delete ?? false) && controller.invoice.value?.id != null)
                              const SizedBox(width: 5),
                            if((permissions?.delete ?? false) && controller.invoice.value?.id != null)
                              ButtonWidget(text: "حذف", onPressed: () => controller.deleteInvoice()),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
