import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/modules/crm_reports/offers/controllers/offers_controller.dart';

import '../../../../../components/table.dart';
import '../../../../../components/text_widget.dart';

class AddedItemsTable extends GetView<OffersController> {
  const AddedItemsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: TextWidget("الاصناف المضافة الي العرض", size: 17, weight: FontWeight.bold,),
              ),
            ),
            SizedBox(
              height: size.height * 0.3,
              child: Obx(() {
                return TableWidget(
                  header: [
                    "اسم الصنف",
                    ""
                  ].map((e) =>
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Text(e, textAlign: TextAlign.center,),
                      )
                  ).toList(),
                  headerHeight: 40,
                  rows: [
                    ...controller.addedItems
                        .map((e) =>
                    [
                      TextWidget(e.name ?? ''),
                      Container(
                          decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle
                          ),
                          child: IconButton(onPressed: () => controller.removeAdded(e), icon: const Icon(Icons.remove)))
                    ])
                        .toList(),
                  ],
                  minimumCellWidth: size.width * 0.1,
                  rowHeight: 50,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
