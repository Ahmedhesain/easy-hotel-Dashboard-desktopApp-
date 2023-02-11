import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';

import '../../../../../components/button_widget.dart';
import '../../../../../components/date_field_widget.dart';
import '../../../../../components/dropdown_widget.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_colors.dart';
import '../../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../controllers/branches_report_controller.dart';

class BranchesReportSearchWidget extends GetView<BranchesReportController> {
  const BranchesReportSearchWidget({Key? key}) : super(key: key);

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
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: SizedBox(
                                      width: size.width * 0.06,
                                      child: const TextWidget(
                                        'المعرض الثاني', size: 15 , weight: FontWeight.bold,
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
                                        value : controller.selectedGallery2.value,
                                        hideBorder: true ,
                                        onChanged: (val) => controller.selectedGallery2.value = val,
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
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: SizedBox(
                                      width: size.width * 0.06,
                                      child: const TextWidget(
                                        'الفئات', size: 15 , weight: FontWeight.bold,
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
                                      return SizedBox(
                                        width: size.width * 0.15,
                                        child: DropDownMultiSelect(
                                          key: UniqueKey(),
                                          options: controller.groups.map((e) => e.name ?? "").toList(),
                                          selectedValues: controller.selectedGroups.map((e) => e.name ?? "").toList(),
                                          onChanged: controller.selectNewGroups,
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                                            border: InputBorder.none
                                          ),
                                          childBuilder: (List<String> values) {
                                            return Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  values.isEmpty ? "يرجى تحديد فئة على الاقل" : values.where((element) => element != "تحديد الكل").join(', '),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
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
                                text: "بحث", onPressed: () => controller.search(), buttonColor: Colors.green, contentPadding: const EdgeInsets.all(15),),
                              // space,
                              // ButtonWidget(text: "طباعة",
                              //   onPressed: (){},
                              //   contentPadding: const EdgeInsets.all(15),),
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
