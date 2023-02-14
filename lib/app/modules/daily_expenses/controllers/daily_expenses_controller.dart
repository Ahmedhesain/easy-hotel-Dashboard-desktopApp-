import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/data/model/gallery_expenses/dto/GalleryExpensesDTO.dart';

import '../../../core/utils/user_manager.dart';
import '../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../data/repository/gallery_expenses_repository/gallery_expenses_repository.dart';
import '../../home/controllers/home_controller.dart';

class DailyExpensesController extends GetxController {
  final isLoading = false.obs;

  Rxn<GalleryResponse> selectedGallery = Rxn();
  final galleries = <GalleryResponse>[].obs;
  final user = UserManager();
  var valueController = TextEditingController();
  var remarksController = TextEditingController();
  final Rxn<GalleryExpensesDTO> galleryExpensesDto = Rxn() ;
  @override
  void onInit() {
    super.onInit();
    galleries.assignAll(Get.find<HomeController>().galleries);
    galleryExpensesDto(Get.arguments);
    if (galleryExpensesDto.value == null && galleries.any((element) => element.id == user.galleryId)) {
      selectedGallery(
          galleries.singleWhere((element) => element.id == user.galleryId));
    }else if(galleries.any((element) => element.id == user.galleryId)){
      selectedGallery(
          galleries.singleWhere((element) => element.id == user.galleryId));
    }
    valueController.text = galleryExpensesDto.value?.value?.toString() ?? ""  ;
    remarksController.text = galleryExpensesDto.value?.remarks?.toString() ?? ""  ;
  }

  add(){
    isLoading(true);
    final request = GalleryExpensesDTO(
      createdBy: user.id ,
      value: double.tryParse(valueController.text) ?? 0.0 ,
      remarks: remarksController.text,
      galleryId: selectedGallery.value?.id,
      id: galleryExpensesDto.value?.id,
      modifiedBy: galleryExpensesDto != null ? user.id : null,
      createdDate: galleryExpensesDto.value?.createdDate
    );

    GalleryExpensesRepository().save(request,
    onSuccess: (e) => showPopupText(text: "تم الحفظ بنجاح" , type: MsgType.success),
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false)
    );
  }

  reset(){
    selectedGallery(
        galleries.singleWhere((element) => element.id == user.galleryId));
    valueController.clear();
    remarksController.clear();
    galleryExpensesDto.value = null;
    galleryExpensesDto.refresh();
  }
}
