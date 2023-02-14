import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manger/app/components/text_widget.dart';
import 'package:hotel_manger/app/core/utils/common.dart';
import 'package:hotel_manger/app/core/utils/user_manager.dart';
import 'package:hotel_manger/app/core/values/app_assets.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/core/values/app_strings.dart';
import 'package:hotel_manger/app/modules/cars/controllers/cars_controller.dart';
import 'package:hotel_manger/app/modules/cars/views/widgets/branch.dart';
import 'package:hotel_manger/app/modules/cars/views/widgets/buy_menu_widget.dart';
import 'package:hotel_manger/app/modules/cars/views/widgets/left_tap.dart';
import 'package:hotel_manger/app/modules/cars/views/widgets/percentage_widget.dart';
import 'package:hotel_manger/app/modules/cars/views/widgets/top_bar_widget.dart';
import 'package:hotel_manger/app/modules/cars/views/widgets/user_card.dart';

import 'widgets/service_card.dart';




class HomeView extends GetView<CarsHomeController> {
  const HomeView

  ({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appHallsRed,
          leading:
          GestureDetector(
              onTap: (){
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios)),
          // leadingWidth: 70.h,

          // backgroundColor: AppColors.backgroundColor,
          title: Row(
            children: [
              TextWidget(
                "مرحبا",
                size: 40,
                textColor: AppColors.appHallsRedDark,
                weight: FontWeight.bold,
              ),
              TextWidget(
                "احمد صلاح",
                // UserManager().user!.name!,
                size: 30,
                textColor: AppColors.appHallsRedDark,
                weight: FontWeight.bold,
              ),
            ],
          ),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  value: 1,
                  onTap: () async {
                    await UserManager().logout();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      const Text(AppStrings.logout),
                      const Icon(Icons.logout, color: Colors.black,),

                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),
                // popupmenu item 2
              ],
              offset: const Offset(0, 50),
              color: AppColors.appHallsRedDark,
              elevation: 2,
            ),
          ],
        ),

        body:Column(
          children: [
            SizedBox(height: size.height*.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                ServiceCard(
                      name:"Cars",
                      image: AppAssets.cars,
                      appId:1 ,
                      imageIn:AppAssets.cars,
                    ), ServiceCard(
                      name:"Housekeeping",
                      image: AppAssets.housekeeping,
                      appId:2 ,
                      imageIn:AppAssets.housekeeping,
                    ), ServiceCard(
                      name:"Polman",
                      image: AppAssets.polman,
                      appId:3 ,
                      imageIn:AppAssets.polman,
                    ), ServiceCard(
                      name:"Spa",
                      image: AppAssets.spa,
                      appId:4 ,
                      imageIn:AppAssets.spa,
                    ),
                ],
              ),
            ),
            SizedBox(height: size.height*.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                ServiceCard(
                      name:"Rooms",
                      image: AppAssets.rooms,
                      appId:5 ,
                      imageIn:AppAssets.rooms,
                    ), ServiceCard(
                      name:"Halls",
                      image: AppAssets.halls,
                      appId:6 ,
                      imageIn:AppAssets.rooms,
                    ), ServiceCard(
                      name:"Restraunt",
                      image: AppAssets.restraunt,
                      appId:7 ,
                      imageIn:AppAssets.restraunt,
                    ), ServiceCard(
                      name:"Bar",
                      image: AppAssets.bar,
                      appId:8 ,
                      imageIn:AppAssets.bar,
                    ),
                ],
              ),
            ),
          ],
        )
      //   GridView.builder(
      //   padding: const EdgeInsets.all(20.0),
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 4,
      //     mainAxisSpacing: 50,
      //     crossAxisSpacing: 25,
      //   ),
      //   itemCount: 8,
      //   itemBuilder: (context, index) {
      //     return ServiceCard(
      //       name:"Cars",
      //       image: AppAssets.rooms,
      //       appId:7 ,
      //       imageIn:AppAssets.rooms,
      //     );
      //   },
      //
      // )
    );
  }
}
