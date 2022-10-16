import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
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
                  const Center(child: Text("Toby Bills",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
                  Positioned(
                    top: -10,
                    left: -5,
                    child: IconButtonWidget(
                        icon: Icons.clear_rounded,
                        onPressed: () =>controller.scaffoldKey.currentState!.closeEndDrawer(),
                    ),
                  )
                ],
              ),
            ),
            const _Tile(title: "إجماليات الفواتير",route: Routes.CATEGORIES_TOTALS),
            const _Tile(title: "حالة الفاتورة",route: Routes.INVOICE_STATUS),
          ],
        ),
      ),
    );
  }
}

class _Tile extends GetView<HomeController> {
  const _Tile({Key? key, required this.title, required this.route}) : super(key: key);
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        controller.scaffoldKey.currentState!.closeEndDrawer();
        Get.toNamed(route);
      },
      leading: const SizedBox(width: 20,child: Center(child: Icon(Icons.circle,size: 10,color: Colors.black,))),
      title: Text(title),
    );
  }
}
