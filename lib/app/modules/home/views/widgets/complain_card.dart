
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:toby_bills/app/components/text_widget.dart';
import 'package:toby_bills/app/core/values/app_colors.dart';

class UserCardWidget extends StatelessWidget {
  const UserCardWidget({Key? key, required this.title, required this.subtitle}) : super(key: key);
  final String title ;
  final String subtitle ;


  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return GestureDetector(
      onTap:(){

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Row(
          children: [
            Icon(Icons.person,size: 30,color: AppColors.blue,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(title,size: 15,weight:FontWeight.bold,textColor: AppColors.font,),
                    TextWidget(subtitle,size: 15,textColor: AppColors.font,),
                  ],
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.fromLTRB(0,0,10,0),
              child:  TextWidget("اظهار التقاصيل",size: 15,textColor: AppColors.blue,),

            )
          ],
        ),
      ),
    );

  }
}