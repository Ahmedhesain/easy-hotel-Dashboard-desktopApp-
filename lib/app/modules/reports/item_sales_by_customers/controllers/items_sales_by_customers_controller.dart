import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/purchases_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/purchases_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';

class ItemsSalesByCustomersController extends GetxController{
  final galleries = <GalleryResponse>[].obs;
  final selectedGalleries = RxList<GalleryResponse>();
  final List<PurchaseBySupplier> purchases = [];
  final purchasesGroups = RxList<PurchaseBySupplierGroup>();
  String? error;
  final isLoading = false.obs;
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;


  @override
  onInit(){
    super.onInit();
    getGalleries();
  }

  getGalleries() async {
    isLoading(true);
    error =null;
    InvoiceRepository().getGalleries(GalleryRequest(branchId: UserManager().branchId,id: UserManager().id),
    onSuccess: (data){
      data.insert(0, GalleryResponse(name: "تحديد الكل"));
      galleries.assignAll(data);
      selectedGalleries.assignAll(data);
    },
    onError: (e)=> error=e,
    onComplete:()=> isLoading(false),

    );
  }

  getPurchases() async {
    isLoading(true);
    error =null;
    final request = PurchasesRequest(
        gallaryList: selectedGalleries,
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

  void selectNewGalleries(List<String> values) {
    selectedGalleries.clear();
    selectedGalleries.addAll(galleries.where((element) => values.contains(element.name)));

  }

}