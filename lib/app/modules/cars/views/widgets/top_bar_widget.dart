import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:hotel_manger/app/components/text_widget.dart';
import 'package:hotel_manger/app/core/values/app_colors.dart';
import 'package:hotel_manger/app/modules/cars/controllers/cars_controller.dart';


class TopBarWidget extends StatelessWidget {
  const TopBarWidget(this.name, this.value,  {Key? key}) : super(key: key);
  final String? name;
  final double value;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: size.height * .2,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15.00)),
            border: Border.all(color: AppColors.appGreyDark, width: 1.5),

            color: Colors.white
          ),
          child:
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.assignment,size: 50,color: AppColors.appBlue,),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextWidget((value.toStringAsFixed(0)).toString(),size: 30,weight: FontWeight.bold,textColor: AppColors.font,),
                  ),


                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(name!,size: 25,weight: FontWeight.bold,textColor: AppColors.font,),
              )
            ],
          )

        ),
      ),
    );
  }
}
