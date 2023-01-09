import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/get_delivery_place_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/get_delivery_place_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/purchases_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/purchases_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';

class ItemsSalesByCustomersController extends GetxController{
  // final galleries = <GalleryResponse>[].obs;
  // final selectedGalleries = RxList<GalleryResponse>();
  final List<PurchaseBySupplier> purchases = [];
  final purchasesGroups = RxList<PurchaseBySupplierGroup>();
  String? error;
  final isLoading = false.obs;
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  final deliveryPlaces = <GalleryResponse>[].obs;
  RxList <GalleryResponse> selectedDeliveryPlace = RxList();


  @override
  onInit(){
    super.onInit();
    getDeliveryPlaces();
  }

  // getGalleries() async {
  //   isLoading(true);
  //   error =null;
  //   InvoiceRepository().getGalleries(GalleryRequest(branchId: UserManager().branchId,id: UserManager().id),
  //   onSuccess: (data){
  //     data.insert(0, GalleryResponse(name: "تحديد الكل"));
  //     galleries.assignAll(data);
  //     selectedGalleries.assignAll(data);
  //   },
  //   onError: (e)=> error=e,
  //   onComplete:()=> isLoading(false),
  //
  //   );
  // }

  getPurchases() async {
    isLoading(true);
    error =null;
    final request = PurchasesRequest(
        gallaryList: selectedDeliveryPlace.map((e) => DtoList(id: e.id)).toList(),
        branchId: UserManager().branchId,
        dateFrom: dateFrom.value,
        dateTo: dateTo.value,
        invoiceType: 4,
        frompaymentType: -2,
        topaymentType: -2,
    );
    ReportsRepository().getPurchases(request,
      onSuccess: (data){
        purchases.assignAll(data);
        purchasesGroups.clear();
        for(final purchase in purchases){
          if(purchasesGroups.any((element) => element.name == purchase.organizationSiteName)){
            purchasesGroups.singleWhere((element) => element.name == purchase.organizationSiteName).purchases.add(purchase);
          } else{
            purchasesGroups.add(PurchaseBySupplierGroup(name: purchase.organizationSiteName.toString(), purchases: List.from([purchase],growable: true)));
          }
        }
      },
      onError: (e)=> showPopupText(text: e.toString()),
      onComplete:()=> isLoading(false),
    );
  }



  pickFromDate() async {
    dateFrom(await _pickDate(
        initialDate: dateFrom.value,
        firstDate: DateTime(2019),
        lastDate: dateTo.value
    ));
  }

  pickToDate() async {
    dateTo(await _pickDate(
        initialDate: dateTo.value,
        firstDate: dateFrom.value,
        lastDate: DateTime.now()
    ));
  }

  _pickDate({required DateTime initialDate,required DateTime firstDate,required DateTime lastDate}){
    return showDatePicker(
        context: Get.overlayContext!,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate
    );
  }

  // void selectNewGalleries(List<String> values) {
  //   selectedGalleries.clear();
  //   selectedGalleries.addAll(galleries.where((element) => values.contains(element.name)));
  //
  // }
  Future<void> getDeliveryPlaces() {
    return InvoiceRepository().getGalleries(
      GalleryRequest(branchId: UserManager().branchId, id: UserManager().id),
      onSuccess: (data) {
        data.insert(0, GalleryResponse(name: "تحديد الكل"));
        deliveryPlaces.assignAll(data);
        if (deliveryPlaces.isNotEmpty) {
          // selectedDeliveryPlace(deliveryPlaces.first);
        }
      },
      onError: (error) => showPopupText(text: error.toString()),
    );
  }
  selectNewDeliveryplace(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedDeliveryPlace.any((element) => element.name == "تحديد الكل")) {
      selectedDeliveryPlace.clear();
    } else if (!selectedDeliveryPlace.any((element) => element.name == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedDeliveryPlace.assignAll(deliveryPlaces);
    } else {
      if (values.length < selectedDeliveryPlace.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedDeliveryPlace.assignAll(deliveryPlaces.where((element) => values.contains(element.name)));
    }
  }


}