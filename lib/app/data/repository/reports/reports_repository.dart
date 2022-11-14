import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/categories_items_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/categories_totals_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/clients_no_movement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/find_custome_balance_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/group_list_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/inv_item_dto_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/invoice_movement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/invoice_statement_by_case_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/items_balances_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/journal_document_dialy_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/production_stages_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/purchases_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/quantity_items_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/safe_account_statement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/saled_for_period_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/sales_of_items_by_company_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/balance_galary_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/balance_galary_unpaid_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_items_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_totals_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/client_no_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_sales_value_added_details_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_sales_value_added_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_statement_of_bonds_by_branch_report_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/group_list_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/inv_item_dto_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_statement_by_case_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoices_without_sewing_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/item_balances_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/journal_document_dialy_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/production_stages_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/purchases_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/quantity_items_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/safe_account_statement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/sales_of_items_by_company_response.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';
import 'package:toby_bills/app/modules/reports/item_sales_by_customers/bindings/item_sales_by_customers_binding.dart';
import 'package:toby_bills/app/modules/reports/journal_document_dialy/bindings/journal_document_dialy_binding.dart';
import 'package:toby_bills/app/modules/reports/safe_account_statement/controllers/safe_account_statement_controller.dart';

import '../../model/invoice/dto/request/gallery_request.dart';
import '../../model/reports/dto/request/items_sales_request.dart';
import '../../model/reports/dto/response/items_sales_response.dart';

class ReportsRepository {


  getCategoriesTotals(
      CategoriesTotalsRequest categoriesTotalsRequest, {
        Function()? onComplete,
        Function(List<CategoriesTotalsResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<List<CategoriesTotalsResponse>,List<dynamic>>('salesReport/findSummition',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: categoriesTotalsRequest.toJson(),
        onError: onError,
        convertor: CategoriesTotalsResponse.fromList,
    );


  getGroupList(
      GroupListRequest groupListRequest, {
        Function()? onComplete,
        Function(List<GroupListResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<List<GroupListResponse>,List<dynamic>>('group/groupList',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: groupListRequest.toJson(),
        onError: onError,
        convertor: GroupListResponse.fromList,
    );


  getProductionStages(
      ProductionStagesRequest productionStagesRequest, {
        Function()? onComplete,
        Function(List<ProductionStagesResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<ProductionStagesResponse>,List<dynamic>>('proproductionreport/invoiceProductionStages',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: productionStagesRequest.toJson(),
        onError: onError,
        convertor: ProductionStagesResponse.fromList,
      );

  getQuantityItems(
      QuantityItemsRequest quantityItemsRequest, {
        Function()? onComplete,
        Function(List<QuantityItemsResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<QuantityItemsResponse>,List<dynamic>>('items/findItemMinimunLimit',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: quantityItemsRequest.toJson(),
        onError: onError,
        convertor: QuantityItemsResponse.fromList,
      );

  getPurchases(
      PurchasesRequest purchasesRequest, {
        Function()? onComplete,
        Function(List<PurchaseBySupplier> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<PurchaseBySupplier>,List<dynamic>>('purchaseBySupplier/purchaseSearch',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: purchasesRequest.toJson(),
        onError: onError,
        convertor: PurchaseBySupplier.fromList,
      );

  getInvoiceStatementByCase(
      InvoiceStatementByCaseRequest invoiceStatementByCaseRequest, {
        Function()? onComplete,
        Function(List<InvoiceStatementByCaseResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<InvoiceStatementByCaseResponse>,List<dynamic>>('proproductionreport/invoiceStatus',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: invoiceStatementByCaseRequest.toJson(),
        onError: onError,
        convertor: InvoiceStatementByCaseResponse.fromList,
      );

  getSafeAccountStatement(
      SafeAccountStatementRequest safeAccountStatementRequest, {
        Function()? onComplete,
        Function(List<BankStatement> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<BankStatement>,List<dynamic>>('bankBalance/BankBalanceSettlement',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: safeAccountStatementRequest.toJson(),
        onError: onError,
        convertor: BankStatement.fromList,
      );
  getEditBillsStatement(
      EditBillsRequest editBillsRequest, {
        Function()? onComplete,
        Function(List<GlPayDTO> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<GlPayDTO>,List<dynamic>>('glBankTransaction/searchGlBankTransactionNoticerecevable',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: editBillsRequest.toJson(),
        onError: onError,
        convertor: GlPayDTO.fromList,
      );

  getAllBanks(
      AllInvoicesRequest allInvoicesRequest, {
        Function()? onComplete,
        Function(List<GlPayDTO> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<GlPayDTO>,List<dynamic>>('bank/glPayDTOList',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: allInvoicesRequest.toJson(),
        onError: onError,
        convertor: GlPayDTO.fromList,
      );

  saveInvoicesStatement(
      GlBankTransactionApi glBankTransactionApi, {
        Function()? onComplete,
        Function(GlBankTransactionApi data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<GlBankTransactionApi,Map<String, dynamic>>('glBankTransaction/saveGlBankTransaction',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: glBankTransactionApi.toJson(),
        onError: onError,
        convertor: GlBankTransactionApi.fromJson,
      );

  profitSoldStatement(
      ProfitOfItemsSoldRequest profitOfItemsSoldRequest, {
        Function()? onComplete,
        Function(List<ProfitOfItemsSoldResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<ProfitOfItemsSoldResponse>,List<dynamic>>('itemsData/profitOfItemsSold',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: profitOfItemsSoldRequest.toJson(),
        onError: onError,
        convertor: ProfitOfItemsSoldResponse.fromList,
      );

 groupStatement(
      AllGroupsRequest allGroupsRequest, {
        Function()? onComplete,
        Function(List<AllGroupResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<AllGroupResponse>,List<dynamic>>('group/groupList',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: allGroupsRequest.toJson(),
        onError: onError,
        convertor: AllGroupResponse.fromList,
      );
  SalesItemsByCompany(
      SalesOfItemsByCompanyRequest salesOfItemsByCompanyRequest, {
        Function()? onComplete,
        Function(List<SalesOfItemsByCompanyResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<SalesOfItemsByCompanyResponse>,List<dynamic>>('reports/salesOfItemByCompany',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: salesOfItemsByCompanyRequest.toJson(),
        onError: onError,
        convertor: SalesOfItemsByCompanyResponse.fromList,
      );
  ItemsBalances(
      ItemsBalancesRequest itemsBalancesRequest, {
        Function()? onComplete,
        Function(List<ItemsBalanceResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<ItemsBalanceResponse>,List<dynamic>>('reports/ItemBalancesStatements',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: itemsBalancesRequest.toJson(),
        onError: onError,
        convertor: ItemsBalanceResponse.fromList,
      );
  InvoiceWithoutSwing(
      ItemsBalancesRequest itemsBalancesRequest, {
        Function()? onComplete,
        Function(List<CompanyInvoicesWithoutSewingResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<CompanyInvoicesWithoutSewingResponse>,List<dynamic>>('reports/companyInvoicesWithoutSewing',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: itemsBalancesRequest.toJson(),
        onError: onError,
        convertor: CompanyInvoicesWithoutSewingResponse.fromList,
      );
  ClientsNoMovement(
      ClientsNoMovementRequest clientsNoMovementRequest, {
        Function()? onComplete,
        Function(List<ClientsNoMovementResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<ClientsNoMovementResponse>,List<dynamic>>('ClientNoMovement/findClientNoMovement',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: clientsNoMovementRequest.toJson(),
        onError: onError,
        convertor: ClientsNoMovementResponse.fromList,
      );
  FindCustomerBalance(
      FindCustomersBalanceRequest findCustomersBalanceRequest, {
        Function()? onComplete,
        Function(List<FindCustomersBalanceResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<FindCustomersBalanceResponse>,List<dynamic>>('customerBalance/findCustomerBalance',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: findCustomersBalanceRequest.toJson(),
        onError: onError,
        convertor: FindCustomersBalanceResponse.fromList,
      );
  FindStatementOfBondsByBranchReport(
      ItemsBalancesRequest itemsBalancesRequest, {
        Function()? onComplete,
        Function(List<FindStatementOfBondsByBranchReportResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<FindStatementOfBondsByBranchReportResponse>,List<dynamic>>('reports/findStatementOfBondsByBranchReport',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: itemsBalancesRequest.toJson(),
        onError: onError,
        convertor: FindStatementOfBondsByBranchReportResponse.fromList,
      );
  FindValesValueAddedDetails(
      SalesOfItemsByCompanyRequest salesOfItemsByCompanyRequest, {
        Function()? onComplete,
        Function(List<FindSalesValueAddedDetailsResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<FindSalesValueAddedDetailsResponse>,List<dynamic>>('salesValueAdded/FindSalesValueAddedDetails',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: salesOfItemsByCompanyRequest.toJson(),
        onError: onError,
        convertor: FindSalesValueAddedDetailsResponse.fromList,
      );
  FindValesValueAdded(
      SalesOfItemsByCompanyRequest salesOfItemsByCompanyRequest, {
        Function()? onComplete,
        Function(List<FindSalesValueAddedResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<FindSalesValueAddedResponse>,List<dynamic>>('salesValueAdded/FindSalesValueAddedDetails',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: salesOfItemsByCompanyRequest.toJson(),
        onError: onError,
        convertor: FindSalesValueAddedResponse.fromList,
      );
  BalanceGalary(
      SalesOfItemsByCompanyRequest salesOfItemsByCompanyRequest, {
        Function()? onComplete,
        Function(List<BalanceGalaryResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<BalanceGalaryResponse>,List<dynamic>>('reports/unPaidAmountAfterSearch',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: salesOfItemsByCompanyRequest.toJson(),
        onError: onError,
        convertor: BalanceGalaryResponse.fromList,
      );
  BalanceGalaryUnpaid(
      SalesOfItemsByCompanyRequest salesOfItemsByCompanyRequest, {
        Function()? onComplete,
        Function(List<BalanceGalaryUnpaidResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<BalanceGalaryUnpaidResponse>,List<dynamic>>('reports/unPaidAmountAfterSearch',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: salesOfItemsByCompanyRequest.toJson(),
        onError: onError,
        convertor: BalanceGalaryUnpaidResponse.fromList,
      );
  BalanceGalarypaid(
      SalesOfItemsByCompanyRequest salesOfItemsByCompanyRequest, {
        Function()? onComplete,
        Function(List<BalanceGalaryUnpaidResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<BalanceGalaryUnpaidResponse>,List<dynamic>>('reports/GlBankTransactionDetailAfterSearch',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: salesOfItemsByCompanyRequest.toJson(),
        onError: onError,
        convertor: BalanceGalaryUnpaidResponse.fromList,
      );
  InvItem(
      InvItemDtoRequest invItemDtoRequest, {
        Function()? onComplete,
        Function(List<InvItemDtoResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<InvItemDtoResponse>,List<dynamic>>('reports/invItemsReport',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: invItemDtoRequest.toJson(),
        onError: onError,
        convertor: InvItemDtoResponse.fromList,
      );
  CategoriesItems(
      CategoriesItemsRequest categoriesItemsRequest, {
        Function()? onComplete,
        Function(List<CategoriesItemsResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<CategoriesItemsResponse>,List<dynamic>>('reports/FindSalesForPeriod',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: categoriesItemsRequest.toJson(),
        onError: onError,
        convertor: CategoriesItemsResponse.fromList,
      );

  SalesForPeriod(
      SalesForPeriodRequest salesForPeriodRequest, {
        Function()? onComplete,
        Function(List<CategoriesItemsResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<CategoriesItemsResponse>,List<dynamic>>('reports/FindSalesForPeriod',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: salesForPeriodRequest.toJson(),
        onError: onError,
        convertor: CategoriesItemsResponse.fromList,
      );

  InvoiceMovement(
      InvoiceMovementRequest invoiceMovementRequest, {
        Function()? onComplete,
        Function(List<InvoiceMovementResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<InvoiceMovementResponse>,List<dynamic>>('reports/FindinvoiceMovementReport',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: invoiceMovementRequest.toJson(),
        onError: onError,
        convertor: InvoiceMovementResponse.fromList,
      );

  JournalDocumentDaily(
      JournalDocumentDialyRequest journalDocumentDialyRequest, {
        Function()? onComplete,
        Function(List<JournalDocumentDialyResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<JournalDocumentDialyResponse>,List<dynamic>>('reports/findJournalDocumentDaily',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: journalDocumentDialyRequest.toJson(),
        onError: onError,
        convertor: JournalDocumentDialyResponse.fromList,
      );
}
