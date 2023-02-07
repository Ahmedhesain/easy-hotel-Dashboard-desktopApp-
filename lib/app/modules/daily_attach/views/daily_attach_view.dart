import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/modules/daily_attach/views/widgets/add_widget.dart';
import 'package:toby_bills/app/modules/daily_attach/views/widgets/images_widget.dart';
import '../../../components/app_loading_overlay.dart';
import '../../../components/text_widget.dart';
import '../../../core/values/app_colors.dart';
import '../controllers/daily_attach_controller.dart';

class DailyAttachView extends GetView<DailyAttachController> {
  const DailyAttachView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoadingOverlay(
          isLoading: controller.isLoading.value,
          child: Scaffold(
            appBar: AppBar(
              title: const TextWidget(
                "مرفقات اليوميه", textColor: Colors.black,),
              centerTitle: true,
              elevation: 2,
              backgroundColor: AppColors.backGround,
            ),
            backgroundColor: AppColors.appGreyLight,
            body: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: const [
                  DailySearchWidget(),
                  ImagesWidget()
                ],
              ),
            ),
          ));
    });
  }
}
