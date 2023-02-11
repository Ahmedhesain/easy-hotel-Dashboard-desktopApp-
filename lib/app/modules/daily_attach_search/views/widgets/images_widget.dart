import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../components/button_widget.dart';
import '../../../../components/content_dialog.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../data/provider/api_provider.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/daily_attach_search_controller.dart';
import 'package:intl/intl.dart' as intl;

class SearchImagesWidget extends GetView<DailyAttachSearchController> {
  const SearchImagesWidget({Key? key}) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: size.height * 0.6,
        child: Obx(() {
          return ListView.separated(
            itemCount: controller.dailyList.length,
            itemBuilder:
                (BuildContext context, int index) {
              var daily = controller.dailyList[index];
              var imagesList = controller.dailyList[index]
                  .dailyAttachDetailDTOList?.first
                  .dailyAttachDetailDetailDTOList ?? [];
              return ExpansionTile(
                backgroundColor: AppColors.backGround,
                  leading: SizedBox(
                    height: size.height * 0.1,
                    width: size.width * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonWidget(text: "تعديل",  onPressed: () => Get.offAndToNamed(Routes.DAILYATTACH , arguments: daily)),
                        ButtonWidget(text: "حذف",
                          onPressed: (){
                          Get.dialog(ContentDialog(
                            title: TextWidget("تأكيد" , size: 18, weight: FontWeight.bold,),
                            content: TextWidget("هل تريد حذف هذا العنصر؟", size: 18, weight: FontWeight.bold,),
                            actions: [
                              ButtonWidget(text: "نعم", onPressed: (){
                                Get.back();
                                controller.delete(daily.id! , index);
                          }),
                              SizedBox(width: 10,),
                              ButtonWidget(text: "لا", onPressed: () => Get.back()),

                            ],));
                        },
                          buttonColor: Colors.red[700],),
                      ],
                    ),
                  ),
                  collapsedBackgroundColor: AppColors.backGround ,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextWidget(daily.gallaryName ?? ""),
                      TextWidget(
                          daily.date != null ? intl.DateFormat("yyyy/MM/dd")
                              .format(daily.date!) : ""),

                    ],
                  ),
                  children: [
                    Container(
                        width: size.width,
                        height: size.height * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Card(
                            color: AppColors.backGround,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                  itemCount: imagesList.length,
                                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: size.width * 0.3,
                                      crossAxisSpacing: 10 ,
                                    mainAxisSpacing: 10
                                  ),
                                  itemBuilder: (BuildContext context, i) {
                                    return Stack(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.3,
                                          child: Image.network(
                                            ApiProvider.apiUrlImage +
                                                imagesList[i].image!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, obj, _) {
                                              return const SizedBox(child: Center(
                                                child: Text(
                                                    "loading image"),
                                              ),);
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ))),
                  ]
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Padding(
              padding: EdgeInsets.all(2.0),
              child: Divider(),
            ),
          );
        }),
      ),
    );
  }
}
