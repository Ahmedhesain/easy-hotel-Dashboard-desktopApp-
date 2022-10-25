import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/modules/home/views/widgets/home_drawer_widget.dart';
import 'package:toby_bills/app/modules/home/views/widgets/invoice_details_header.dart';
import 'package:toby_bills/app/modules/home/views/widgets/invoice_details_widget.dart';
import '../controllers/home_controller.dart';
import 'widgets/customer_info_widget.dart';
import 'widgets/invoice_info_widget.dart';
import 'widgets/home_header_widget.dart';
import 'widgets/side_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTap: (){
        controller.scaffoldKey.currentState!.openEndDrawer();
      },
      child: Obx(() {
        return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            key: controller.scaffoldKey,
            endDrawer: const HomeDrawerWidget(),
            drawerScrimColor: Colors.transparent,
            body: Stack(
              children: [
                Row(
                  children: [
                    const SideWidget(),
                    Expanded(
                      child: Column(
                        children: [
                          const HomeHeaderWidget(),
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: Colors.grey)),
                                margin: const EdgeInsets.all(20).copyWith(top: 0),
                                child: Column(
                                  children: const [
                                    InvoiceInfoWidget(),
                                    SizedBox(height: 10),
                                    CustomerInfoWidget(),
                                    InvoiceDetailsHeaderWidget(),
                                    Expanded(child: InvoiceDetailsWidget()),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 5,
                  left: 10,
                  child: IconButtonWidget(
                    icon: Icons.menu,
                    onPressed: () => controller.scaffoldKey.currentState!.openEndDrawer(),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
