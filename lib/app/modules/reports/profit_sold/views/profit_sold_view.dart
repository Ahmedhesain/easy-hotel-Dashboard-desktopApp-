import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:toby_bills/app/components/app_loading_overlay.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/views/widgets/CardShadow.dart';
import 'package:toby_bills/app/modules/reports/items_quantity/views/widgets/search_widget.dart';

import '../controllers/profit_sold_controller.dart';

class ProfitSoldView extends GetView<ProfitSoldController>{
  const ProfitSoldView({super.key});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    final orientation = MediaQuery.of(context).size;
    return Obx((){
      return AppLoadingOverlay(
        isLoading: controller.isLoading.value,
        child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: size.width*0 ,
            title:  Container(width: size.width*.2,
              height: size.height*.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(6.00)),
                color: Colors.blueAccent,
              ),
              child: TextButton(
                child: Center(child: Text("رجوع")),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
            ,
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: orientation.width < 750 ? 10 : 50,
                vertical: orientation.width < 750 ? 10 : 50.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('الاصناف')
                ),
                // Padding(
                //   padding: const EdgeInsets.all(18.0),
                //   child: SearchWidget(
                //     text: controller. query,
                //     hintText: 'اسم العنصر',
                //     // onChanged: (value)=>controller.searchItem(),
                //   ),
                // ),
                const SizedBox(
                  height: 20.0,
                ),
                // Expanded(
                //   child: Obx((){
                //     return GridView.builder(
                //         gridDelegate:
                //         const SliverGridDelegateWithMaxCrossAxisExtent(
                //             maxCrossAxisExtent: 200,
                //             childAspectRatio: 1.1,
                //             crossAxisSpacing: 20,
                //             mainAxisSpacing: 20),
                //         itemCount: controller.reports.length,
                //         itemBuilder: (BuildContext ctx, index) {
                //           return cardDisplay(
                //               itemName: controller.reports[index].itemName!,
                //               itemBalance:
                //               controller.reports[index].balance.toString());
                //         });
                //   }),
                // ),
              ],
            ),
          ),

          ),

        );}
      );
  }

  Widget cardDisplay({required String itemName, required String itemBalance}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: CardShadow(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                flex: 5,
                child: Text(
                  itemName,
                  // style: titleStyle,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  itemBalance,
                  // style: titleStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
