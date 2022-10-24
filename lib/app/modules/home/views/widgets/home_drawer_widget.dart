import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:toby_bills/app/routes/app_pages.dart';

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
            _Tile(
              title: "إجماليات الفواتير",
              onTap: () {
                Get.toNamed(Routes.CATEGORIES_TOTALS);
              },
            ),
            _Tile(
              title: "حالة الفاتورة",
              onTap: () {
                if(Get.find<HomeController>().invoice.value == null){
                  showPopupText(text: "يجب اختيار فاتورة اولاً");
                  return;
                }
                Get.toNamed(Routes.INVOICE_STATUS);
              },
            ),
            _Tile(
              title: "كشف حساب",
              onTap: () {
                if(Get.find<HomeController>().selectedCustomer.value == null) {
                  showPopupText(text: "يجب اختيار عميل اولاً");
                  return;
                }
                Get.toNamed(Routes.ACCOUNT_STATEMENT);
              },
            ),
            _Tile(
              title: "مراحل الانتاج",
              onTap: () {
                if(Get.find<HomeController>().invoice.value == null) {
                  showPopupText(text: "يجب اختيار فاتورة اولاً");
                  return;
                }
                Get.toNamed(Routes.PRODUCTION_STAGES);
              },
            ),
            _Tile(
              title: "كميه الاصناف بالمعرض",
              onTap: () {
                if(Get.find<HomeController>().invoice.value == null) {
                  showPopupText(text: "يجب اختيار فاتورة اولاً");
                  return;
                }
                Get.toNamed(Routes.ITEMS_QUANTITY);
              },
            ),
            _Tile(
              title: "مبيعات الأصناف حسب العملاء تفصيلي",
              onTap: () => Get.toNamed(Routes.ITEMS_SALES_BY_CUSTOMERS),
            ),

          ],
        ),
      ),
    );
  }
}

class _Tile extends GetView<HomeController> {
  const _Tile({Key? key, required this.title, required this.onTap}) : super(key: key);
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
