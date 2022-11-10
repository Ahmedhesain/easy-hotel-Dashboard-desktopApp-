import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:toby_bills/app/routes/app_pages.dart';
import 'package:window_manager/window_manager.dart';

class HomeDrawerWidget extends GetView<HomeController> {
  const HomeDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Center(
                    child: Text(
                      "Toby Bills",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -10,
                    left: -5,
                    child: IconButtonWidget(
                      icon: Icons.clear_rounded,
                      onPressed: () => controller.scaffoldKey.currentState!.closeEndDrawer(),
                    ),
                  )
                ],
              ),
            ),
            HomeDrawerSectionWidget(
                title: "تقارير المخازن",
                children: [
                  HomeDrawerTileWidget(
                    title: "إجماليات الفواتير",
                    onTap: () {
                      goTo(Routes.CATEGORIES_TOTALS, "إجماليات الفواتير");
                    },
                  ),
                  HomeDrawerTileWidget(
                    title: "حالة الفاتورة",
                    onTap: () {
                      if(Get.find<HomeController>().invoice.value == null){
                        showPopupText(text: "يجب اختيار فاتورة اولاً");
                        return;
                      }
                      goTo(Routes.INVOICE_STATUS,"حالة الفاتورة");
                    },
                  ),
                  HomeDrawerTileWidget(
                    title: "مراحل الانتاج",
                    onTap: () {
                      if(Get.find<HomeController>().invoice.value == null) {
                        showPopupText(text: "يجب اختيار فاتورة اولاً");
                        return;
                      }
                      goTo(Routes.PRODUCTION_STAGES,"مراحل الانتاج");
                    },
                  ),
                  HomeDrawerTileWidget(
                    title: "كميه الاصناف بالمعرض",
                    onTap: () {
                      if(Get.find<HomeController>().invoice.value == null) {
                        showPopupText(text: "يجب اختيار فاتورة اولاً");
                        return;
                      }
                      goTo(Routes.ITEMS_QUANTITY, "كميه الاصناف بالمعرض");
                    },
                  ),
                  HomeDrawerTileWidget(
                    title: "مبيعات الأصناف حسب العملاء تفصيلي",
                    onTap: () => goTo(Routes.ITEMS_SALES_BY_CUSTOMERS, "مبيعات الأصناف حسب العملاء تفصيلي"),
                  ),
                  HomeDrawerTileWidget(
                    title: "كشف حساب خزنة",
                    onTap: () => goTo(Routes.SAFE_ACCOUNT_SATATMENT, "كشف حساب خزنة"),
                  ),
                  HomeDrawerTileWidget(
                    title: "الاصناف",
                    onTap: () => goTo(Routes.ITEMS, "الاصناف"),
                  ),
                  HomeDrawerTileWidget(
                    title: "بيان الفواتير حسب الحالة",
                    onTap: () => goTo(Routes.INVOICE_STATEMENT_BY_CASE, "بيان الفواتير حسب الحالة"),
                  ),
                  HomeDrawerTileWidget(
                    title: "ارباح مبيعات الاصناف",
                    onTap: () => goTo(Routes.PROFITSOLD, "ارباح مبيعات الاصناف"),
                  ),
                  HomeDrawerTileWidget(
                    title: "المبيعات حسب الشركات لفتره",
                    onTap: () => goTo(Routes.SALES_ITEMS_BY_COMPANY, "المبيعات حسب الشركات لفتره"),
                  ),
                  HomeDrawerTileWidget(
                    title: "رصيد الاصناف",
                    onTap: () => goTo(Routes.ITEMS_BALANCES_STATEMENT, "رصيد الاصناف"),
                  ),
                  HomeDrawerTileWidget(
                    title: "فواتير الشركات بدون خياطه",
                    onTap: () => goTo(Routes.INVOICES_WITHOUT_SWING, "فواتير الشركات بدون خياطه"),
                  ),
                  HomeDrawerTileWidget(
                    title: "عملاء ليس لديهم حركه",
                    onTap: () => goTo(Routes.CLIENTS_NO_MOVEMENT, "عملاء ليس لديهم حركه"),
                  ),
                  HomeDrawerTileWidget(
                    title: "ارصده العملاء",
                    onTap: () => goTo(Routes.FIND_CUSTOMER_BALANCE, "ارصده العملاء"),
                  ),
                  HomeDrawerTileWidget(
                    title: "بيان بالسندات الصادره حسب الفرع",
                    onTap: () => goTo(Routes.FIND_STATEMENT_OF_BONDS_BY_BRANCH, "بيان بالسندات الصادره حسب الفرع"),
                  ),
                  HomeDrawerTileWidget(
                    title: "بيان الفواتير حسب الضريبه تفصيلي",
                    onTap: () => goTo(Routes.FIND_VALES_VALUES_ADDED_DETAILS, "بيان الفواتير حسب الضريبه تفصيلي"),
                  ),
                  HomeDrawerTileWidget(
                    title: "بيان الفواتير حسب الضريبه ",
                    onTap: () => goTo(Routes.FIND_VALES_VALUES_ADDED, "بيان الفواتير حسب الضريبه "),
                  ),
                  HomeDrawerTileWidget(
                    title: "تقرير العمولات",
                    onTap: () => goTo(Routes.BALANCE_GALLARY, "تقرير العمولات"),
                  ),
                  HomeDrawerTileWidget(
                    title: "تقرير بالمبالغ الغير مسدده",
                    onTap: () => goTo(Routes.BALANCE_GALLARY_UNPAID, "تقرير بالمبالغ الغير مسدده"),
                  ),
                  HomeDrawerTileWidget(
                    title: "تقرير بالمبالغ المسدده",
                    onTap: () => goTo(Routes.BALANCE_GALLARY_PAID, "تقرير بالمبالغ المسدده"),
                  ),
                  HomeDrawerTileWidget(
                    title: "الاصناف حسب الفئات",
                    onTap: () => goTo(Routes.INV_ITEM_DTO, "الاصناف حسب الفئات"),
                  ),
                ],
            ),
            HomeDrawerSectionWidget(
              title: "تقارير الحسابات",
              children: [
                HomeDrawerTileWidget(
                  title: "كشف حساب",
                  onTap: () {
                    if(Get.find<HomeController>().selectedCustomer.value == null) {
                      showPopupText(text: "يجب اختيار عميل اولاً");
                      return;
                    }
                    goTo(Routes.ACCOUNT_STATEMENT,"كشف حساب");
                  },
                ),
              ],
            ),
            HomeDrawerSectionWidget(
              title: "حركة الخزائن",
              children: [
                HomeDrawerTileWidget(
                  title: "تعديل سندات القبض",
                  onTap: () => goTo(Routes.EDITBILLS, "تعديل سندات القبض"),
                ),

                HomeDrawerTileWidget(
                  title: "فواتير الشراء",
                  onTap: () => goTo(Routes.PURCHASE_INVOICES, "فواتير الشراء"),
                ),
                HomeDrawerTileWidget(
                  title: "الإشعارات",
                  onTap: () => goTo(Routes.NOTIFICATIONS, "الإشعارات"),
                ),
                HomeDrawerTileWidget(
                  title: "المدفوعات",
                  onTap: () => goTo(Routes.PAYMENTS, "المدفوعات"),
                ),
                HomeDrawerTileWidget(
                  title: "سند القبض",
                  onTap: () => goTo(Routes.CATCH_RECEIPT, "سند القبض"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  goTo(String to, String title)async{
    windowManager.setTitle("Toby Bills -> $title");
    await Get.toNamed(to);
    windowManager.setTitle("Toby Bills -> شاشة المشتريات");
  }
}

class HomeDrawerSectionWidget extends StatelessWidget {
  const HomeDrawerSectionWidget({Key? key, required this.title, required this.children}) : super(key: key);
  final String title;
  final List<HomeDrawerTileWidget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(spreadRadius: 2,blurRadius: 5,color: Colors.black12)
        ]
      ),
      child: Material(
        color: Colors.transparent,
        child: ExpansionTile(
          title: Text(title),
          leading: const Icon(Icons.menu_rounded),
          children: children,
        ),
      ),
    );
  }
}


class HomeDrawerTileWidget extends GetView<HomeController> {
  const HomeDrawerTileWidget({Key? key, required this.title, required this.onTap}) : super(key: key);
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.only(left: 30),
      leading: const SizedBox(
          width: 20,
          child: Center(
              child: Icon(
            Icons.circle,
            size: 10,
            color: Colors.black,
          ))),
      title: Text(title),
    );
  }
}
