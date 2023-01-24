

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../home/controllers/home_controller.dart';

class OffersController extends GetxController {
  final isLoading = false.obs ;
  final selectedOfferType = 0.obs;
  final galleries = <GalleryResponse>[].obs;
  RxList <GalleryResponse> selectedGalleries = RxList();
  Rxn<DateTime> startDate = Rxn();
  Rxn<DateTime> endDate = Rxn();
  final offerValue = TextEditingController();


  @override
  onInit(){
    galleries.assignAll(Get.find<HomeController>().galleries);
    selectNewDeliveryplace(["تحديد الكل"]);
    super.onInit();
  }



  selectNewDeliveryplace(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedGalleries.any((element) => element.name == "تحديد الكل")) {
      selectedGalleries.clear();
    } else if (!selectedGalleries.any((element) => element.name == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedGalleries.assignAll(galleries);
    } else {
      if (values.length < selectedGalleries.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedGalleries.assignAll(galleries.where((element) => values.contains(element.name)));
    }
  }


}