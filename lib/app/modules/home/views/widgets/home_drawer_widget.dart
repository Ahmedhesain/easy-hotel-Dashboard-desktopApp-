import 'dart:convert';
import 'dart:io';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:toby_bills/app/routes/app_pages.dart';
import 'package:window_manager/window_manager.dart';

class HomeDrawerWidget extends GetView<HomeController> {
  const HomeDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sections = UserManager().user.userScreens;
    final list1 = [
      if(sections["invpermissionorder_1"]?.view ??false)
      HomeDrawerTileWidget(
        title: "تفاصيل الفسح",
        onTap: (){
          // Get.toNamed(Routes.FASEH_DETAILS);
          goTo(Routes.FASEH_DETAILS, "تفاصيل الفسح");
        },
      ),
      if(sections["invpurchaseinvoice_1"]?.view ??false)
        HomeDrawerTileWidget(
          title: "فواتير الشراء",
          onTap: () => goTo(Routes.PURCHASE_INVOICES, "فواتير الشراء"),
        ),
      if(sections["customeraddnotice"]?.view??false)
        HomeDrawerTileWidget(
          title: "الإشعارات",
          onTap: () => goTo(Routes.NOTIFICATIONS, "الإشعارات"),
        ),
        HomeDrawerTileWidget(
          title: "استلام الفاتورة",
          onTap: () => goTo(Routes.INVOICE_RECEIVE, "استلام الفاتورة"),
        ),
        HomeDrawerTileWidget(
          title: "تسليم الفاتورة",
          onTap: () => goTo(Routes.INVOICE_DELIVERY, "تسليم الفاتورة"),
        ),
    ];
    final list2 = [
      if(sections["summitionItemReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "إجماليات الفئات",
        onTap: () {
          goTo(Routes.CATEGORIES_TOTALS, "إجماليات الفئات");
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
      if(sections["summitionItemReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "مبيعات الأصناف حسب العملاء تفصيلي",
        onTap: () => goTo(Routes.ITEMS_SALES_BY_CUSTOMERS, "مبيعات الأصناف حسب العملاء تفصيلي"),
      ),
      if(sections["summitionItemReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "الاصناف",
        onTap: () => goTo(Routes.ITEMS, "الاصناف"),
      ),
      if(sections["summitionItemReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "بيان الفواتير حسب الحالة",
        onTap: () => goTo(Routes.INVOICE_STATEMENT_BY_CASE, "بيان الفواتير حسب الحالة"),
      ),
      if(sections["summitionItemReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: " مبيعات الاصناف",
        onTap: () => goTo(Routes.PROFITSOLD, " مبيعات الاصناف"),
      ),
      if(sections["SalesOfItemsByCompany"]?.view ??false)
      HomeDrawerTileWidget(
        title: "المبيعات حسب الشركات لفتره",
        onTap: () => goTo(Routes.SALES_ITEMS_BY_COMPANY, "المبيعات حسب الشركات لفتره"),
      ),
      if(sections["SalesReportByValueAdedDetailsReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "ارصده الاصناف",
        onTap: () => goTo(Routes.ITEMS_BALANCES_STATEMENT, "رصيد الاصناف"),
      ),
      if(sections["SalesReportByValueAdedDetailsReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "فواتير الشركات بدون خياطه",
        onTap: () => goTo(Routes.INVOICES_WITHOUT_SWING, "فواتير الشركات بدون خياطه"),
      ),
      if(sections["clientsNoMovmentReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: " عملاء ليس لديهم حركه من تاريخ",
        onTap: () => goTo(Routes.CLIENTS_NO_MOVEMENT, "عملاء ليس لديهم حركه من تاريخ"),
      ),
      if(sections["CustomerBalancesReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "ارصده العملاء",
        onTap: () => goTo(Routes.FIND_CUSTOMER_BALANCE, "ارصده العملاء"),
      ),
      if(sections["SalesReportByValueAdedDetailsReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "بيان الفواتير حسب الضريبه تفصيلي",
        onTap: () => goTo(Routes.FIND_VALES_VALUES_ADDED_DETAILS, "بيان الفواتير حسب الضريبه تفصيلي"),
      ),
      if(sections["SalesReportByValueAdedReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "بيان الفواتير حسب الضريبه ",
        onTap: () => goTo(Routes.FIND_VALES_VALUES_ADDED, "بيان الفواتير حسب الضريبه "),
      ),
      if(sections["commisionReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "تقرير العمولات",
        onTap: () => goTo(Routes.BALANCE_GALLARY, "تقرير العمولات"),
      ),
      if(sections["CustomerBalancesReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "تقرير بالمبالغ الغير مسدده",
        onTap: () => goTo(Routes.BALANCE_GALLARY_UNPAID, "تقرير بالمبالغ الغير مسدده"),
      ),
      if(sections["CustomerBalancesReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "تقرير بالمبالغ المسدده",
        onTap: () => goTo(Routes.BALANCE_GALLARY_PAID, "تقرير بالمبالغ المسدده"),
      ),
      if(sections["basicdataofitemsbysuppliersreport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "الاصناف حسب الفئات",
        onTap: () => goTo(Routes.INV_ITEM_DTO, "الاصناف حسب الفئات"),
      ),
      if(sections["SalesStatementForThePeriod"]?.view ??false)
      HomeDrawerTileWidget(
        title: "الفواتير المسدده لفتره سابقه",
        onTap: () => goTo(Routes.CATEGORIES_ITEMS, "الفواتير المسدده لفتره سابقه"),
      ),
      if(sections["SalesStatementForThePeriod"]?.view ??false)
      HomeDrawerTileWidget(
        title: "بيان المبيعات لفتره",
        onTap: () => goTo(Routes.SALES_FOR_PERIOD, "بيان المبيعات لفتره"),
      ),
      if(sections["InvoiceMovementReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "حركه الثياب",
        onTap: () => goTo(Routes.INVOICE_MOVEMENT, "حركه الثياب"),
      ),

    ];
    final list3 = <HomeDrawerTileWidget>[
      if(sections["cashaccountsettlement_1"]?.view ??false)
      HomeDrawerTileWidget(
        title: "كشف حساب خزنة",
        onTap: () => goTo(Routes.SAFE_ACCOUNT_SATATMENT, "كشف حساب خزنة"),
      ),
      if(sections["SalesReportByValueAdedDetailsReport"]?.view ??false)
      HomeDrawerTileWidget(
        title: "بيان بالسندات الصادره حسب الفرع",
        onTap: () => goTo(Routes.FIND_STATEMENT_OF_BONDS_BY_BRANCH, "بيان بالسندات الصادره حسب الفرع"),
      ),
    ];
    final list4 = [
      if(sections["notesreceivables"]?.view??false)
        HomeDrawerTileWidget(
          title: "سند القبض",
          onTap: () => goTo(Routes.CATCH_RECEIPT, "سند القبض"),
        ),
      if(sections["notesreceivables"]?.view??false)
        HomeDrawerTileWidget(
          title: "سداد القبض لفرع آخر",
          onTap: () => goTo(Routes.CATCH_RECEIPT_ANOTHER_GALLERY, "سداد القبض لفرع آخر"),
        ),
      if(sections["notesreceivablesadmin"]?.view??false)
        HomeDrawerTileWidget(
          title: "تعديل سندات القبض",
          onTap: () => goTo(Routes.EDITBILLS, "تعديل سندات القبض"),
        ),
      if(sections["settlementdeed"]?.view??false)
        HomeDrawerTileWidget(
          title: "المدفوعات",
          onTap: () => goTo(Routes.PAYMENTS, "المدفوعات"),
        ),
    ];
    final list5 = [
      if(sections["subaccountsummaryreport"]?.view??false)
      HomeDrawerTileWidget(
        title: "كشف حساب فرعي",
        onTap: () => goTo(Routes.SUB_ACCOUNT_STATEMENT,"كشف حساب فرعي"),
      ),
      if(sections["journalDocumentDailyReport"]?.view??false)
      HomeDrawerTileWidget(
        title: "قيد اليوميه تفصيلي",
        onTap: () => goTo(Routes.JOURNAL_DOCUMENT_DIALY, "قيد اليوميه تفصيلي"),
      ),
      if(sections["CustomerBalancesReport"]?.view??false)
      HomeDrawerTileWidget(
        title: "كشف حساب عميل",
        onTap: () => goTo(Routes.CUSTOMER_ACCOUNT_STATEMENT, "كشف حساب عميل"),
      ),

    ];
    final list6 = [
      HomeDrawerTileWidget(
        title: "الشكاوي و المقترحات",
        onTap: () => goTo(Routes.CRM_EVENTS_REPORT,"الشكاوي و المقترحات"),
      ),
      HomeDrawerTileWidget(
        title: "كوبونات الخصم",
        onTap: () => goTo(Routes.coupons,"كوبونات الخصم"),
      ),
      HomeDrawerTileWidget(
        title: "العروض",
        onTap: () => goTo(Routes.offers,"العروض"),
      ),
      HomeDrawerTileWidget(
        title: "عملاء الشركات",
        onTap: () => goTo(Routes.CRMCustomers,"عملاء الشركات"),
      ),
    ];
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
            if(list1.isNotEmpty)
            HomeDrawerSectionWidget(
              title: "حركة المخازن",
              children: list1,
            ),
            if(list2.isNotEmpty)
            HomeDrawerSectionWidget(
                title: "تقارير المخازن",
                children: list2,
            ),
            if(list4.isNotEmpty)
            HomeDrawerSectionWidget(
              title: "حركة الخزائن",
              children: list4,
            ),
            if(list3.isNotEmpty)
            HomeDrawerSectionWidget(
              title: "تقارير الخزائن",
              children: list3,
            ),
            if(list5.isNotEmpty)
            HomeDrawerSectionWidget(
              title: "تقارير الحسابات",
              children: list5,
            ),
            if(list6.isNotEmpty)
            HomeDrawerSectionWidget(
              title: "CRM",
              children: list6,
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(spreadRadius: 2,blurRadius: 5,color: Colors.black12)
                  ]
              ),
              child: Material(
                color: Colors.transparent,
                child: ListTile(
                  onTap: () => Get.offAllNamed(Routes.LOGIN),
                  leading: const SizedBox(
                      width: 20,
                      child: Center(
                          child: Icon(
                            Icons.logout_rounded,
                            size: 15,
                            color: Colors.black,
                          ))),
                  title: const Text("تسجيل خروج"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
  goTo(String to, String title) async {

    // final window = await DesktopMultiWindow.createWindow(jsonEncode({
    //   'route': to,
    // }));
    // window
    //   ..setFrame(const Offset(0, 0) & const Size(1280, 720))
    //   ..center()
    //   ..setTitle(title)
    //   ..show();
    if(Platform.isWindows) {
      windowManager.setTitle("Toby Bills -> $title");
    }
    await Get.toNamed(to);
    if(Platform.isWindows) {
      windowManager.setTitle("Toby Bills -> شاشة المشتريات");
    }
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
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
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
      contentPadding: const EdgeInsets.only(left: 30),
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
