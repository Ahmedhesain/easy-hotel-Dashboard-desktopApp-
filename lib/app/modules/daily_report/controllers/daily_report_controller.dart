import 'package:get/get.dart';
import 'package:toby_bills/app/core/extensions/date_ext.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/core/utils/user_manager.dart';
import 'package:toby_bills/app/data/model/gallery_expenses/dto/GalleryExpensesDTO.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/safe_account_statement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/safe_account_statement_response.dart';
import 'package:toby_bills/app/data/repository/reports/reports_repository.dart';
import '../../../core/utils/daily_printing_helper.dart';
import '../../../data/model/gallery_expenses/dto/request/getGalleryExpensesListRequest.dart';
import '../../../data/repository/gallery_expenses_repository/gallery_expenses_repository.dart';
import '../../home/controllers/home_controller.dart';

class DailyReportController extends GetxController {
  final galleries = <GalleryResponse>[].obs;
  final selectedGalleries = RxList<GalleryResponse>();
  final banks = <GlPayDTO>[].obs;
  final selectedBanks = RxList<GlPayDTO>();
  final statements = RxList<BankStatement>();
  final isLoading = false.obs;
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  final treasuries = <TreasuryModel>[].obs;
  final expenses = <GalleryExpensesDTO>[].obs;
  final user = UserManager();
  final treasuriesTotal = 0.0.obs;
  final treasuriesNetTotal = 0.0.obs;
  final treasuriesPreviousTotal = 0.0.obs;
  final expensesTotal = 0.0.obs;
  final netBank = 0.0.obs;
  final netTamaraBank = 0.0.obs;
  final transfersBank = 0.0.obs;

  @override
  onInit() {
    isLoading(true);
    super.onInit();
    galleries.assignAll(Get.find<HomeController>().galleries);
    galleries.insert(0, GalleryResponse(name: "تحديد الكل"));
    selectNewDeliveryplace(["تحديد الكل"]);
    Future.wait([getBanks()]).whenComplete(() => isLoading(false));
  }

  Future getBanks() async {
    isLoading(true);
    banks([]);
    selectedBanks([]);
    ReportsRepository().getAllGlPayGallaries(
      AllInvoicesGAllariesRequest(
        id: user.id,
        branchId: user.branchId,
        invInventoryDtoList:
            selectedGalleries.map((e) => DtoList(id: e.id)).toList(),
      ),
      onSuccess: (data) {
        banks.assignAll(data);
        banks.insert(0, GlPayDTO(name: "تحديد الكل"));
        selectNewBank(["تحديد الكل"]);
      },
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false),
    );
  }

  getReport(bool previous) async {
    isLoading(true);
    final request = SafeAccountStatementRequest(
      glBankDTOListSelected: selectedBanks,
      glYearSelected: {"id": 73},
      branchId: UserManager().branchId,
      dateFrom: previous
          ? dateFrom.value.subtract(const Duration(days: 1))
          : dateFrom.value,
      dateTo: previous
          ? dateTo.value.subtract(const Duration(days: 1))
          : dateTo.value,
      invoiceType: 4,
      dataType: 3,
    );
    ReportsRepository().getSafeAccountStatement(
      request,
      onSuccess: (data) {
        if (!previous) {
          statements.assignAll(data);
          treasuries.clear();
          for (final statement in statements) {
            if (treasuries
                .any((element) => element.bankName == statement.bankName)) {
              treasuries
                  .singleWhere(
                      (element) => element.bankName == statement.bankName)
                  .statements
                  .add(statement);
            } else {
              treasuries.add(TreasuryModel(
                  bankName: statement.bankName,
                  statements: List.from([statement], growable: true)));
            }
            addTotalByCash(statement.cash ?? 0 , statement.debitAmount?.toDouble() ?? 0.0);
          }
          for (var element in treasuries) {
            treasuriesTotal(treasuriesTotal.value +
                (element.statements.first.totalDebit ?? 0));
          }
          treasuries.refresh();
          getGalleryExpensesList();
          getReport(true);
        } else {
          treasuriesPreviousTotal.value =
              data.first.totalDebit?.toDouble() ?? 0.0;
          treasuriesNetTotal.value =
              (treasuriesPreviousTotal.value + treasuriesTotal.value) -
                  expensesTotal.value;
        }
      },
      onError: (e) => showPopupText(text: e.toString()),
    );
  }

  getGalleryExpensesList() {
    isLoading(true);
    expenses.clear();
    expensesTotal(0.0);
    for (int i = 0; i < selectedGalleries.length; i++) {
      final request = GetGalleryExpensesListRequest(
          galleryId: selectedGalleries[i].id!,
          dateFrom: dateFrom.value.dayFromStart,
          dateto: dateTo.value.dayToEnd);
      GalleryExpensesRepository().getExpensesList(request,
          onComplete:
              i == selectedGalleries.length - 1 ? () => isLoading(false) : null,
          onError: (e) => showPopupText(text: e.toString()),
          onSuccess: (data) => data.forEach((e) {
                expenses.add(e);
                expensesTotal.value += (e.value ?? 0);
              }));
    }
  }

  selectNewBank(List<String> values) {
    if (!values.contains("تحديد الكل") &&
        selectedBanks.any((element) => element.name == "تحديد الكل")) {
      selectedBanks.clear();
    } else if (!selectedBanks.any((element) => element.name == "تحديد الكل") &&
        values.contains("تحديد الكل")) {
      selectedBanks.assignAll(banks);
    } else {
      if (values.length < selectedBanks.length &&
          values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedBanks
          .assignAll(banks.where((element) => values.contains(element.name)));
    }
    selectedBanks.refresh();
  }

  selectNewDeliveryplace(List<String> values) {
    if (!values.contains("تحديد الكل") &&
        selectedGalleries.any((element) => element.name == "تحديد الكل")) {
      selectedGalleries.clear();
    } else if (!selectedGalleries
            .any((element) => element.name == "تحديد الكل") &&
        values.contains("تحديد الكل")) {
      selectedGalleries.assignAll(galleries);
    } else {
      if (values.length < selectedGalleries.length &&
          values.contains("تحديد الكل")) {
        values.remove("تحديد الكل");
      }
      selectedGalleries.assignAll(
          galleries.where((element) => values.contains(element.name)));
    }
    getBanks();
  }

  addTotalByCash(int cash, double? value) {
    switch (cash) {
      case 0:
        break;
      case 1:
        netBank.value += (value ?? 0.0);
        break;
      case 2:
        transfersBank.value += (value ?? 0.0);
        break;
      case 3:
        netTamaraBank.value += (value ?? 0.0);
        break;
      default:
        break;
    }
  }

}
