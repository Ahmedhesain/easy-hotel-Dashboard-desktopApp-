
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_manger/app/components/text_widget.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/data/provider/api_provider.dart';
import 'package:hotel_manger/app/routes/app_pages.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({Key? key, required this.name,required this.image, required this.appId, required this.imageIn}) : super(key: key);
  final String name;
  final String image;
  final String imageIn;
  final int appId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(appId==1){
          Get.toNamed(Routes.RESTRAUNT);
        }
          else if(appId==2){
          Get.toNamed(Routes.RESTRAUNT);
        }
        else if(appId==3){
          Get.toNamed(Routes.CARS);
        }
        else if(appId==4){
          Get.toNamed(Routes.SPA);
        }
        else if(appId==5){
          Get.toNamed(Routes.HOUSEKEEPING);
        }
        else if(appId==6){
          Get.toNamed(Routes.HALLS);
        }
        else if(appId==7){
          Get.toNamed(Routes.ROOMS);
        }
        else if(appId==8){
          Get.toNamed(Routes.POLMAN);
        }
      } ,
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20.00)),
            color: AppColors.appGreyLight,
            image: DecorationImage(
                image: AssetImage(image), fit: BoxFit.cover)),
        clipBehavior: Clip.antiAlias,
        child: DecoratedBox(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextWidget(
                    name,
                    textColor: Colors.white,
                    weight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    size: 17,
                  ),
                ))),
      ),
    );
  }
}
