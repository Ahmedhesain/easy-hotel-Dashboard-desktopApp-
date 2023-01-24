

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_items_request.dart';
import 'package:toby_bills/app/data/repository/item/item_repository.dart';

import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../../data/model/item/dto/response/item_response.dart';
import '../../../home/controllers/home_controller.dart';

class OffersController extends GetxController {
  final isLoading = false.obs ;
  final selectedOfferType = 0.obs;
  final galleries = <GalleryResponse>[].obs;
  final items = <ItemResponse>[].obs;
  RxList <GalleryResponse> selectedGalleries = RxList();
  RxList <ItemResponse> selectedItems = RxList();
  Rxn<DateTime> startDate = Rxn();
  Rxn<DateTime> endDate = Rxn();
  final offerValue = TextEditingController();


  @override
  onInit(){
    super.onInit();
    getItems();
    galleries.assignAll(Get.find<HomeController>().galleries);
    selectNewDeliveryplace(["تحديد الكل"]);
  }


 getItems(){
    isLoading(true);
    ItemRepository().getAllItems(
      GetItemRequest(branchId: UserManager().branchId),
      onSuccess: (data) {
        items.assignAll(data);
        selectedItems.assignAll(items);
      } ,
      onComplete: () => isLoading(false)
    );
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

  selectNewItems(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedItems.any((element) => element.name == "تحديد الكل")) {
      selectedItems.clear();
    } else if (!selectedItems.any((element) => element.name == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedItems.assignAll(items);
    } else {
      if (values.length < selectedItems.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedItems.assignAll(items.where((element) => values.contains(element.name)));
    }
  }


}