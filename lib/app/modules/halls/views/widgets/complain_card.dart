
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotel_manger/app/components/text_widget.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';

class ComplainCardWidget extends StatelessWidget {
  const ComplainCardWidget({Key? key, required this.title, required this.subtitle, required this.color}) : super(key: key);
  final String title ;
  final String subtitle ;
  final Color color ;


  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return GestureDetector(
      onTap:(){

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Container(
          // height: 40,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15.00)),
              border: Border.all(color: AppColors.appGreyDark, width: 1.5),

              color: AppColors.appGreyLight
          ),
          child: Row(
            children: [
              Icon(Icons.account_circle,size: 30,color: color,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(title,size: 15,weight:FontWeight.bold,textColor: AppColors.font,),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.fromLTRB(0,0,10,0),
                child:  TextWidget("اظهار التقاصيل",size: 15,textColor: AppColors.blue,),

              ),
              TextWidget(subtitle,size: 15,textColor: AppColors.appGreyDark,),

            ],
          ),
        ),
      ),
    );

  }
}