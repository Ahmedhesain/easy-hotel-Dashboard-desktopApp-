import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../components/button_widget.dart';
import '../../../../components/date_field_widget.dart';
import '../../../../components/dropdown_widget.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../controllers/daily_attach_search_controller.dart';


class DailySearchSearchWidget extends GetView<DailyAttachSearchController> {
  const DailySearchSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const space = SizedBox(
      width: 20,
    );
    const spaceV = SizedBox(
      height: 20,
    );
    return Container(
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Card(
            color: AppColors.backGround,
            child:
                Padding(padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: SizedBox(
                                      width: size.width * 0.06,
                                      child: const TextWidget(
                                        'المعرض', size: 15 , weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * .21,
                                    height: size.height * 0.06,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      color: AppColors.appGreyLight,
                                      // border: Border.all(color: Colors.grey)
                                    ),
                                    child: Obx(() {
                                      return DropDownWidget<GalleryResponse>(
                                        items: controller.galleries.map((e) =>
                                            DropdownMenuItem<GalleryResponse>(value: e,child: TextWidget(e.name!) ,)).toList(),
                                        value : controller.selectedGallery.value,
                                        hideBorder: true ,
                                        onChanged: (val) => controller.selectedGallery.value = val,
                                      );
                                    }),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                        spaceV,
                        SizedBox(
                          width: size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                  width: size.width * 0.06,
                                  child: const TextWidget(
                                    "الفتره",
                                    size: 15,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              space,
                              Container(
                                width: size.width * 0.1,
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.appGreyLight,
                                ),
                                child: DateFieldWidget(
                                  date: controller.dateFrom.value,
                                  label: "من",
                                  hideBorder: true,
                                  onComplete: (DateTime date) {
                                    controller.dateFrom.value = date;
                                  },
                                ),
                              ),
                              space,
                              Container(
                                width: size.width * 0.1,
                                height: size.height * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.appGreyLight,
                                ),
                                child: DateFieldWidget(
                                  date: controller.dateTo.value,
                                  label: "الي",
                                  hideBorder: true,
                                  onComplete: (DateTime date) {
                                    controller.dateTo.value = date;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        spaceV,
                        SizedBox(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonWidget(
                                text: "بحث", onPressed: () => controller.search(),  contentPadding: const EdgeInsets.all(15),),
                              space,
                              ButtonWidget(
                                text: "رجوع", onPressed: () => Get.back(), buttonColor: Colors.redAccent, contentPadding: const EdgeInsets.all(15),)

                            ],
                          ),
                        )
                      ],
                    ))));
  }
}
