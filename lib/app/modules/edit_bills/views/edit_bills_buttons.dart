import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toby_bills/app/components/button_widget.dart';
import 'package:toby_bills/app/components/icon_button_widget.dart';
import 'package:toby_bills/app/modules/edit_bills/controllers/edit_bills_controller.dart';

class EditBillsButtons extends GetView<EditBillsController> {
  const EditBillsButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 250,
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {},
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  hintText: "ابحث عن سند",
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white70,
                  suffixIcon: IconButtonWidget(
                    icon: Icons.search,
                    onPressed: () => controller.getStatements(),
                  )
              ),
              onFieldSubmitted: (_) => controller.getStatements(),
              controller: controller.selectedStatusController,
            ),
          ),
          // const SizedBox(width: 30),
          // const Text("من تاريخ"),
          // const SizedBox(width: 10),
          // MouseRegion(
          //   cursor: SystemMouseCursors.click,
          //   child: Stack(
          //     children: [
          //       GestureDetector(
          //         onTap: () => controller.pickFromDate(),
          //         child: Container(
          //           width: 150,
          //           decoration: BoxDecoration(
          //               border: Border.all(),
          //               borderRadius: BorderRadius.circular(5.0)
          //           ),
          //           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          //           child: Obx(() {
          //             return Center(child: Text(controller.dateFrom.value == null?"----/--/--":DateFormat("yyyy/MM/dd").format(controller.dateFrom.value!)));
          //           }),
          //         ),
          //       ),
          //       Positioned(
          //         left: -2,
          //         top: 0,
          //         bottom: 0,
          //         child: IconButtonWidget(
          //           icon: Icons.clear_rounded,
          //           onPressed: () => controller.dateFrom.value = null,
          //           iconSize: 15,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // const SizedBox(width: 30),
          // const Text("الى تاريخ"),
          // const SizedBox(width: 10),
          // MouseRegion(
          //   cursor: SystemMouseCursors.click,
          //   child: Stack(
          //     children: [
          //       GestureDetector(
          //         onTap: () => controller.pickToDate(),
          //         child: Container(
          //           width: 150,
          //           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          //           decoration: BoxDecoration(
          //               border: Border.all(),
          //               borderRadius: BorderRadius.circular(5.0)
          //           ),
          //           child: Obx(() {
          //             return Center(child: Text(controller.dateTo.value == null?"----/--/--":DateFormat("yyyy/MM/dd").format(controller.dateTo.value!)));
          //           }),
          //         ),
          //       ),
          //       Positioned(
          //         left: -2,
          //         top: 0,
          //         bottom: 0,
          //         child: IconButtonWidget(
          //           icon: Icons.clear_rounded,
          //           onPressed: () => controller.dateTo.value = null,
          //           iconSize: 15,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          const Spacer(),
          Container(
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppColors.appGreyDark),
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ButtonWidget(text: "بحث", onPressed: () => controller.getStatements()),
                const SizedBox(width: 5),
                ButtonWidget(text: "رجوع", onPressed: () => Get.back()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
