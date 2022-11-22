import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/gallery_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/safe_account_statement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/safe_account_statement_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';

class SafeAccountStatementController extends GetxController{

  final galleries = <GalleryResponse>[].obs;
  final selectedGalleries = RxList<GalleryResponse>();
  final banks = <GlPayDTO>[].obs;
  final selectedBanks = RxList<GlPayDTO>();
  final statements = RxList<BankStatement>();
  String? error;
  final isLoading = false.obs;
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  final treasuries = List<TreasuryModel>.empty(growable: true);
  final user = UserManager();

  @override
  onInit(){
    super.onInit();
    getBanks();
  }

  getBanks() async {
    isLoading(true);
    error =null;
    ReportsRepository().getAllGlPay(AllInvoicesRequest(id: user.id, branchId: user.branchId),
      onSuccess: (data){
        banks.assignAll([GlPayDTO(bankName: "تحديد الكل")]);
        banks.addAll(data);
        selectedBanks.assignAll(data);
      },
      onError: (e) => error = e,
      onComplete: () => isLoading(false),

    );
  }

  getGalleries() async {
    isLoading(true);
    error =null;
    InvoiceRepository().getGalleries(GalleryRequest(branchId: UserManager().branchId,id: UserManager().id),
      onSuccess: (data){
        galleries.assignAll(data);
        selectedGalleries.assignAll(data);
      },
      onError: (e)=> error=e,
      onComplete:()=> isLoading(false),

    );
  }

  getSales() async {
    isLoading(true);
    error =null;
    final request = SafeAccountStatementRequest(
      glBankDTOListSelected: selectedBanks,
      glYearSelected:{"id": 73},
      branchId: UserManager().branchId,
      dateFrom: dateFrom.value,
      dateTo: dateTo.value,
      invoiceType: 4,
      dataType: 3,
    );
    ReportsRepository().getSafeAccountStatement(request,
      onSuccess: (data){
        statements.assignAll(data);
        treasuries.clear();
        for(final statement in statements){
          if(treasuries.any((element) => element.bankName == statement.bankName)){
            treasuries.singleWhere((element) => element.bankName == statement.bankName).statements.add(statement);
          } else{
            treasuries.add(TreasuryModel(bankName: statement.bankName, statements: List.from([statement],growable: true)));
          }
        }
      },
      onError: (e)=> showPopupText(text: e.toString()),
      onComplete:()=> isLoading(false),
    );
  }

  selectNewBank(List<String> values) {
    if (!values.contains("تحديد الكل") && selectedBanks.any((element) => element.bankName == "تحديد الكل")) {
      selectedBanks.clear();
    } else if (!selectedBanks.any((element) => element.bankName == "تحديد الكل") && values.contains("تحديد الكل")) {
      selectedBanks.assignAll(banks);
    } else {
      if (values.length < selectedBanks.length && values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedBanks.assignAll(banks.where((element) => values.contains(element.bankName)));
    }
  }

  // getYears(BuildContext context) async {
  //   if (!isLoadingGalleries || error != null) {
  //     isLoadingGalleries = true;
  //     error == null;
  //     notifyListeners();
  //   }
  //   try {
  //     final authProvider = context.read<AuthProvider>();
  //     final uri = Uri.parse("${url}glyear/findGlYearForUserByBranch");
  //     final headers = {
  //       "content-type":"application/json",
  //       "charset":"utf-8",
  //     };
  //     final body = {
  //       "id" : authProvider.id,
  //       "branchId":  authProvider.branchId
  //     };
  //     final response = await http.post(uri, body: json.encode(body),headers: headers);
  //     if (response.statusCode == 200) {
  //       final data = utf8.decode(response.bodyBytes);
  //       // galleries.assignAll(gallaryFromJson(utf8.decode(response.bodyBytes)));
  //       // selectedGalleries.assignAll([galleries.first]);
  //     } else {
  //       // error = response.reasonPhrase;
  //     }
  //   } catch (e,s) {
  //     print(s);
  //     error = e.toString();
  //   }
  //   isLoadingGalleries = false;
  //   notifyListeners();
  // }


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
        context:  Get.overlayContext!,
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