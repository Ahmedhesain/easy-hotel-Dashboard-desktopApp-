import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/invoice_statement_by_case_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_statement_by_case_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';

class InvoiceStatementByCaseController extends GetxController {

  final galleries = <GalleryResponse>[];
  final selectedGalleries = RxList<GalleryResponse>();
  final invoices = RxList<InvoiceStatementByCaseResponse>();
  String? error;
  final isLoading = false.obs;
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  final selectedStatus = 4.obs;
  final statusList = [
    "بالمشغل",
    "ارسال للمعرض",
    "استلام بالمعرض",
    "تسليم للعميل",
    "بالمعرض",
  ];

  @override
  onInit(){
    super.onInit();
    getGalleries();
  }

  getGalleries() async {
    isLoading(true);
    error = null;
    InvoiceRepository().getGalleries(GalleryRequest(branchId: UserManager().branchId,id: UserManager().id),
      onSuccess: (data){
        galleries.assignAll(data);
        selectedGalleries.assignAll(data);
      },
      onError: (e) => error=e,
      onComplete:() => isLoading(false),

    );
  }

  getInvoices(BuildContext context) async {
    isLoading(true);

    final request = InvoiceStatementByCaseRequest(
      gallaryList: selectedGalleries,
      dateTo: dateTo.value,
      dateFrom: dateFrom.value,
      branchId: UserManager().branchId,
      dayNumber: 4,
      selectedStatus: selectedStatus.value
    );
    ReportsRepository().getInvoiceStatementByCase(request,
      onSuccess: invoices.assignAll,
      onError: (e) => showPopupText(text: e.toString()),
      onComplete:() => isLoading(false),
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
