import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/categories_totals_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/group_list_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/invoice_statement_by_case_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/production_stages_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/purchases_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/quantity_items_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/safe_account_statement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_totals_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/group_list_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_statement_by_case_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/production_stages_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/purchases_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/quantity_items_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/safe_account_statement_response.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';
import 'package:toby_bills/app/modules/reports/item_sales_by_customers/bindings/item_sales_by_customers_binding.dart';
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
}
