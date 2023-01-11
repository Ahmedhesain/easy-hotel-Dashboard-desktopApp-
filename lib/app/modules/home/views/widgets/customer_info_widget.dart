import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/core/utils/double_filter.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';
import 'package:toby_bills/app/modules/home/views/widgets/show_customer_image_dialog.dart';

class CustomerInfoWidget extends GetView<HomeController> {
  const CustomerInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.appGreyLight,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return Row(
                children: [
                  const Text(
                    "ايميل ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 2,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(text: controller.selectedCustomer.value?.email?.toString()),
                          decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                          textAlign: TextAlign.center,
                          onChanged: (value) => controller.selectedCustomer.value?.email = value,
                        )
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "الطول",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: TextEditingController(
                            text: controller.selectedCustomer.value?.length.toString()),
                        decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        inputFormatters: [doubleInputFilter],
                        onChanged: (value) {
                          if (value.isEmpty) {
                            controller.selectedCustomer.value?.length = 0;
                            return;
                          }
                          controller.selectedCustomer.value?.length = double.parse(value);
                        },
                      ),
                      // child: Center(
                      //     child: Text(provider.clintSelected != null
                      //         ? provider.clintSelected!.length!.toString()
                      //         : "")),
                    ),
                  ),

                  const SizedBox(width: 10),
                  const Text(
                    "الكتف",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(
                              text: controller.selectedCustomer.value?.shoulder.toString()),
                          decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          inputFormatters: [doubleInputFilter],
                          onChanged: (value) {
                            if (value.isEmpty) {
                              controller.selectedCustomer.value?.shoulder = 0;
                              return;
                            }
                            controller.selectedCustomer.value?.shoulder = double.parse(value);
                          },
                        )
                      // child: Center(
                      //     child: Text(provider.clintSelected != null
                      //         ? provider.clintSelected!.shoulder!.toString()
                      //         : "")),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "الخطوه",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(
                              text: controller.selectedCustomer.value?.step.toString()),
                          decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          inputFormatters: [doubleInputFilter],
                          onChanged: (value) {
                            if (value.isEmpty) {
                              controller.selectedCustomer.value?.step = 0;
                              return;
                            }
                            controller.selectedCustomer.value?.step = double.parse(value);
                          },
                        )
                      // child: Center(
                      //     child: Text(provider.clintSelected != null
                      //         ? provider.clintSelected!.step!.toString()
                      //         : "")),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "تليفون ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 2,
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(

                          controller: TextEditingController(

                              text: controller.selectedCustomer.value?.mobile.toString()),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                            counterText: ""
                          ),
                          textAlign: TextAlign.center,
                          maxLength: 12,
                          enabled: false,

                          textDirection: TextDirection.ltr,
                          onChanged: (value) {
                            controller.selectedCustomer.value?.mobile = value;
                          },
                        )
                      // child: Center(
                      //     child: Text(provider.clintSelected != null
                      //         ? provider.clintSelected!.mobile!.toString()
                      //         : "")),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "كود",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(text: controller.selectedCustomer.value?.code.toString() ?? ""),
                          decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.ltr,
                          enabled: false,
                        )),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "جهه",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: TextEditingController(text: controller.selectedCustomer.value?.offerCompanyName ?? ""),
                          decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                          textAlign: TextAlign.center,
                          enabled: false,
                        )),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "الرصيد",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: TextEditingController(text: controller.selectedCustomer.value?.balanceLimit?.toString() ?? ""),
                        decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                        textAlign: TextAlign.center,
                        enabled: false,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Obx(() {
                    if (controller.selectedCustomer.value == null) return const SizedBox.shrink();
                    return Material(
                      color: Colors.transparent,
                      child: IconButtonWidget(
                        icon: Icons.edit,
                        onPressed: () {
                          controller.updateCustomer();
                        },
                      ),
                    );
                  }),
                  Material(
                    color: Colors.transparent,
                    child: IconButtonWidget(
                      icon: Icons.camera_alt,
                      onPressed: () => controller.uploadCustomerPhoto(),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: IconButtonWidget(
                      icon: Icons.slideshow,
                      onPressed: () {
                        if(controller.selectedCustomer.value == null){
                          showPopupText(text: 'يجب اختيار عميل ') ;
                          return ;
                        }
                        if(controller.selectedCustomer.value!.imgMeasure == null){
                          showPopupText(text:  'لا يوجد صورة للعميل') ;
                          return ;
                        }
                        Get.dialog(const ShowCustomerImageDialog());

                      },
                    ),
                  ),
                ],
              );
            })));
  }
}
