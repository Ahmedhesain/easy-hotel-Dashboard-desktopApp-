

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_items_request.dart';
import 'package:toby_bills/app/data/repository/item/item_repository.dart';

import '../../../../core/utils/show_popup_text.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../../data/model/item/dto/response/item_response.dart';
import '../../../../data/model/reports/dto/request/group_list_request.dart';
import '../../../../data/model/reports/dto/response/group_list_response.dart';
import '../../../../data/repository/reports/reports_repository.dart';
import '../../../home/controllers/home_controller.dart';

class OffersController extends GetxController {
  final isLoading = false.obs ;
  final selectedOfferType = 0.obs;
  final galleries = <GalleryResponse>[].obs;
  final items = <ItemResponse>[].obs;
  final filteredItems = <ItemResponse>[].obs;
  RxList <GalleryResponse> selectedGalleries = RxList();
  RxList <ItemResponse> addedItems = RxList();
  RxList <ItemResponse> excludedItems = RxList();
  // RxList <ItemResponse> selectedFilteredItems = RxList();
  Rxn<DateTime> startDate = Rxn();
  Rxn<DateTime> endDate = Rxn();
  final offerValue = TextEditingController();
  final maxPrice = TextEditingController();
  final itemsFilterController = TextEditingController();
  final sellPrice = TextEditingController();
  final itemNameController = TextEditingController();

  final itemNameFocusNode = FocusNode();

  Rxn<ItemResponse> selectedItem = Rxn();

  final symbols = <GroupListResponse>[].obs;
  final selectedSymbols = <GroupListResponse>[].obs;
  final addedOrExcluded = 0.obs ;
  @override
  onInit(){
    super.onInit();
    getGroupList();
    items.assignAll(Get.find<HomeController>().items);
    galleries.assignAll(Get.find<HomeController>().galleries);
    selectNewDeliveryplace(["تحديد الكل"]);
  }


 getItems(){
    isLoading(true);
    ItemRepository().getAllItemsLocal(
      onSuccess: (data) {
        items.assignAll(data);
      },
      onComplete: () => isLoading(false)
    );
 }

  List<ItemResponse> filterItems(String filter) {
    return items.where((element) => element.code.toString().contains(filter) || element.name.toString().contains(filter)).toList();
  }

  getGroupList() {
    isLoading(true);
    final request = GroupListRequest(branchId: UserManager().branchId, id: UserManager().id);
    ReportsRepository().getGroupList(
      request,
      onSuccess: (data) {
        symbols.assignAll(data);
      },
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false),
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

  addItem(){
    if(selectedItem.value == null){
      showPopupText(text: "اختر صنف");
      return ;
    }
    if(addedOrExcluded.value == 0 && !excludedItems.contains(selectedItem.value) && !addedItems.contains(selectedItem.value)){
      addedItems.add(selectedItem.value!);
    }else if(addedOrExcluded.value == 1 && !addedItems.contains(selectedItem.value) && !excludedItems.contains(selectedItem.value)){
      excludedItems.add(selectedItem.value!);
    }else{
      showPopupText(text: "لا يمكن اضافة الصنف ");
    }
  }


  removeAdded(ItemResponse i){
    addedItems.remove(i);
  }
  removeExcluded(ItemResponse i){
    excludedItems.remove(i);
  }

  selectNewSymbols(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedSymbols.any((element) => element.name == "تحديد الكل")) {
      selectedSymbols.clear();
      // getItems();
    } else if (!selectedSymbols.any((element) => element.name == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedSymbols.assignAll(symbols);
      // getItems();
    } else {
      if (values.length < selectedSymbols.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedSymbols.assignAll(symbols.where((element) => values.contains(element.name)));
      // getItems();
    }
  }


}