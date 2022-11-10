import 'package:toby_bills/app/data/model/customer/dto/request/find_customer_balance_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/invoice/dto/gl_pay_dto.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';
import 'package:toby_bills/app/data/model/notifications/dto/request/delete_notification_request.dart';
import 'package:toby_bills/app/data/model/notifications/dto/request/find_notification_request.dart';
import 'package:toby_bills/app/data/model/notifications/dto/request/save_notification_request.dart';
import 'package:toby_bills/app/data/model/notifications/dto/response/find_notification_response.dart';
import 'package:toby_bills/app/data/model/payments/dto/request/delete_payment_request.dart';
import 'package:toby_bills/app/data/model/payments/dto/request/find_payment_request.dart';
import 'package:toby_bills/app/data/model/payments/payment_model.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/categories_totals_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/clients_no_movement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/edit_bills_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/find_custome_balance_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/group_list_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/invoice_statement_by_case_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/items_balances_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/production_stages_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/profit_of_Items_sold_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/purchases_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/quantity_items_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/safe_account_statement_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/request/sales_of_items_by_company_request.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/categories_totals_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/client_no_movement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_customer_balance_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_sales_value_added_details_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_sales_value_added_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/find_statement_of_bonds_by_branch_report_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/group_list_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoice_statement_by_case_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/invoices_without_sewing_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/item_balances_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/production_stages_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/profit_of_items_sold_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/purchases_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/quantity_items_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/safe_account_statement_response.dart';
import 'package:toby_bills/app/data/model/reports/dto/response/sales_of_items_by_company_response.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';
import 'package:toby_bills/app/modules/reports/item_sales_by_customers/bindings/item_sales_by_customers_binding.dart';
import 'package:toby_bills/app/modules/reports/safe_account_statement/controllers/safe_account_statement_controller.dart';

import '../../model/invoice/dto/request/gallery_request.dart';
import '../../model/reports/dto/request/items_sales_request.dart';
import '../../model/reports/dto/response/items_sales_response.dart';

class PaymentRepository {


  findPaymentBySerial(
      FindPaymentRequest findPaymentRequest, {
        Function()? onComplete,
        Function(PaymentModel data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<PaymentModel,Map<String,dynamic>>('glBankTransaction/findGlBankTransactionSettlmentBySerial',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: findPaymentRequest.toJson(),
        onError: onError,
        convertor: PaymentModel.fromJson,
    );


  findPaymentById(
      FindPaymentRequest findPaymentRequest, {
        Function()? onComplete,
        Function(GlPayDTO data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<GlPayDTO,Map<String,dynamic>>('glBankTransaction/searchGlBankTransactionById',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: findPaymentRequest.toJson(),
        onError: onError,
        convertor: GlPayDTO.fromJson,
    );


  savePayment(
      PaymentModel paymentModel, {
        Function()? onComplete,
        Function(PaymentModel data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<PaymentModel,Map<String,dynamic>>('glBankTransaction/saveSettelMent',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: paymentModel.toJson(),
        onError: onError,
        convertor: PaymentModel.fromJson,
    );


  deletePayment(
      DeletePaymentRequest deletePaymentRequest, {
        Function()? onComplete,
        Function(void data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<void,Map<String,dynamic>>('glBankTransaction/deleteGlBankTransaction',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: deletePaymentRequest.toJson(),
        onError: onError,
        convertor: (_){},
    );

}
