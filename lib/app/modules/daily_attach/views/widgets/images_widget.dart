import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../components/button_widget.dart';
import '../../../../components/content_dialog.dart';
import '../../../../components/date_field_widget.dart';
import '../../../../components/dropdown_widget.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../../data/provider/api_provider.dart';
import '../../controllers/daily_attach_controller.dart';

class ImagesWidget extends GetView<DailyAttachController> {
  const ImagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    const space = SizedBox(
      width: 20,
    );
    const spaceV = SizedBox(
      height: 20,
    );
    return Container(
        width: size.width,
        height: size.height * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Card(
            color: AppColors.backGround,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return GridView.builder(
                    itemCount: controller.images.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: size.width * 0.3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10
                    ),
                    itemBuilder: (BuildContext context, i) {
                      return Stack(
                        children: [
                          SizedBox(
                            width: size.width * 0.3,
                            child: Image.network(
                              ApiProvider.apiUrlImage + controller.images[i].image!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, obj, _) {
                                return const SizedBox(child: Center(
                                  child: Text(
                                      "loading image"),
                                ),);
                              },
                            ),
                          ),
                          Positioned(top: 5, left: 5,
                            child: Container( width : size.width * 0.04 ,
                                decoration : BoxDecoration(color: Colors.red , shape: BoxShape.circle),
                                child: Center(child: IconButton(
                                    onPressed: (){
                                      Get.dialog(ContentDialog(
                                        title: TextWidget("تأكيد" , size: 18, weight: FontWeight.bold,),
                                        content: TextWidget("هل تريد حذف هذا العنصر؟", size: 18, weight: FontWeight.bold,),
                                        actions: [
                                          ButtonWidget(text: "نعم", onPressed: (){
                                            Get.back();
                                            controller.delete(controller.images[i].id! , i);
                                          }),
                                          SizedBox(width: 10,),
                                          ButtonWidget(text: "لا", onPressed: () => Get.back()),

                                        ],));

                                    },
                                    icon: const Icon(Icons.clear , size: 20 ,)))),)
                        ],
                      );
                    });
              }),
            )));
  }
}
