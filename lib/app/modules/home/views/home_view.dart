import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/shortcuts/intents.dart';
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
    return FocusScope(
      autofocus: true,
      onKeyEvent: (focusNode, keyEvent){
        print(focusNode);
        if(!controller.isLoading.value){
          if(keyEvent.logicalKey == LogicalKeyboardKey.f5){
            controller.saveInvoice();
          } else if(keyEvent.logicalKey == LogicalKeyboardKey.f6){
            controller.newInvoice();
          } else if(keyEvent.logicalKey == LogicalKeyboardKey.f7){
            controller.printInvoice(context);
          } else if(keyEvent.logicalKey == LogicalKeyboardKey.f8){
            controller.printGeneralJournal(context);
          } else {
            return KeyEventResult.ignored;
          }
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;

      },
      child: GestureDetector(
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
      ),
    );
  }
}
