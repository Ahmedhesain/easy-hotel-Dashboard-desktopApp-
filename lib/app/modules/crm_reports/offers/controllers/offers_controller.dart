

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/item/dto/request/get_items_request.dart';
import 'package:toby_bills/app/data/repository/item/item_repository.dart';

import '../../../../core/utils/show_popup_text.dart';
import '../../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../../data/model/item/dto/response/item_response.dart';
import '../../../../data/model/offers/dto/request/add_offer_detail_request.dart';
import '../../../../data/model/offers/dto/request/add_offer_request.dart';
import '../../../../data/model/offers/dto/request/get_offers_request.dart';
import '../../../../data/model/offers/offer_detail_dto.dart';
import '../../../../data/model/offers/offer_dto.dart';
import '../../../../data/model/reports/dto/request/group_list_request.dart';
import '../../../../data/model/reports/dto/response/group_list_response.dart';
import '../../../../data/repository/offers/offers_repository.dart';
import '../../../../data/repository/reports/reports_repository.dart';
import '../../../home/controllers/home_controller.dart';

class OffersController extends GetxController {
  final isLoading = false.obs ;
  final selectedOfferType = 0.obs;
  final active = 0.obs;
  final galleries = <GalleryResponse>[].obs;
  final items = <ItemResponse>[].obs;
  final filteredItems = <ItemResponse>[].obs;
  RxList <GalleryResponse> selectedGalleries = RxList();
  RxList <ItemResponse> addedItems = RxList();
  RxList <ItemResponse> excludedItems = RxList();
  // RxList <ItemResponse> selectedFilteredItems = RxList();
  Rxn<DateTime> startDate = Rxn(DateTime.now());
  Rxn<DateTime> endDate = Rxn(DateTime.now());
  final offerValue = TextEditingController();
  final maxPrice = TextEditingController();
  final itemsFilterController = TextEditingController();
  final sellPrice = TextEditingController();
  final itemNameController = TextEditingController();
  final offerNameController = TextEditingController();

  final itemNameFocusNode = FocusNode();

  Rxn<ItemResponse> selectedItem = Rxn();

  final groups = <GroupListResponse>[].obs;
  final offersList = <OfferDTO>[].obs;
  Rxn<OfferDTO> selectedOffer = Rxn();
  Rxn<GroupListResponse> selectedGroup = Rxn();
  final addedOrExcluded = 0.obs ;
  final user = UserManager();


  @override
  onInit(){
    super.onInit();
    getGroupList();
    getOffers();
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

  getOffers(){
    isLoading(true);
    final request = GetOfferRequest(branchId: user.branchId , companyId: user.companyId);
    OfferRepository().getAllOffer( request,
        onSuccess: (data) {
          offersList.assignAll(data);
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
        groups.assignAll(data);
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



  saveOffer(){
    if(selectedGroup.value == null){
      showPopupText(text: "يجب ادخال فئه للعرض");
      return ;
    }
    if(startDate.value == null || endDate.value == null){
      showPopupText(text: "يجب ادخال تاريخ بدء و انتهاء");
      return ;
    }
    if(maxPrice.text.isEmpty){
      showPopupText(text: "يجب ادخال اعلي سعر للعرض");
      return ;
    }
    if(offerNameController.text.isEmpty){
      showPopupText(text: "يجب ادخال اسم للعرض");
      return ;
    }
    if(offerValue.text.isEmpty && sellPrice.text.isEmpty){
      showPopupText(text: "يجب ادخال قيمة العرض او سعر البيع");
      return ;
    }
    isLoading(true);
    final detailsList = <OfferDetailDTO>[];
   for(ItemResponse item in addedItems){
     final OfferDetailDTO added =
     OfferDetailDTO(
         itemId: item.id!,
         addedOrExcluded: 0,
         branchId: user.branchId,
         companyId:  user.companyId,
         createdBy: user.id,
         parentOfferId: selectedOffer.value?.id ,
     );
     detailsList.add(added);
   }
   for(ItemResponse item in excludedItems){
     final OfferDetailDTO excluded =
     OfferDetailDTO(
         itemId: item.id!,
         addedOrExcluded: 1,
         branchId: user.branchId,
         companyId:  user.companyId,
         createdBy: user.id,
         parentOfferId: selectedOffer.value?.id ,
     );
     detailsList.add(excluded);
   }
   final request = OfferDTO(
     branchId: user.branchId,
     createdBy: user.id,
     name: offerNameController.text,
     companyId: user.companyId,
     dateTo: endDate.value,
     dateFrom: startDate.value,
     details: detailsList,
     groupId: selectedGroup.value?.id,
     offerMax: double.tryParse(maxPrice.text),
     offerType: selectedOfferType.value,
     offerValue: double.tryParse(offerValue.text),
     sellPrice: double.tryParse(sellPrice.text),
     id: selectedOffer.value?.id
   );

    OfferRepository().saveOffer(
        request,
        onComplete: () => isLoading(false),
        onSuccess: (data){
          if(data.msg != null && data.msg!.isNotEmpty){
            showPopupText(text: data.msg! , type: MsgType.error);
            return ;
          }
          showPopupText(text: "تم الحفظ بنجاح" , type: MsgType.success);
          getOffers();
        },
      onError: (e) => showPopupText(text: e.toString())
    );
  }


  onSelectOffer(dynamic selectedOfferValue){
     selectedOffer(selectedOfferValue);
     offerNameController.text = selectedOffer.value?.name ?? "";
     endDate(selectedOffer.value?.dateTo);
     startDate(selectedOffer.value?.dateFrom);
     final int groupIndex = groups.indexWhere((group) => group.id == (selectedOffer.value?.groupId ?? -1));
     selectedGroup(groupIndex!= -1 ? groups[groupIndex] : null);
     maxPrice.text = selectedOffer.value?.offerMax.toString() ?? "";
     selectedOfferType(selectedOffer.value?.offerType);
     offerValue.text = selectedOffer.value?.offerValue.toString() ?? "" ;
     sellPrice.text=selectedOffer.value?.sellPrice.toString() ?? ""  ;
     addedItems(items.where((item) =>
         selectedOffer.value?.details?.indexWhere((detail) =>
         detail.itemId == item.id && detail.addedOrExcluded == 0 ) != -1).toList());
     excludedItems(items.where((item) =>
         selectedOffer.value?.details?.indexWhere((detail) =>
         detail.itemId == item.id && detail.addedOrExcluded == 1 ) != -1).toList());
     active(selectedOffer.value?.active);
  }


}