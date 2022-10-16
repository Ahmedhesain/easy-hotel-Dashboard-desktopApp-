import 'package:get/get.dart';
import 'package:toby_bills/app/data/model/invoice/dto/request/invoice_status_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/invoice_status_response.dart';
import 'package:toby_bills/app/data/repository/invoice/invoice_repository.dart';

class InvoiceStatusController extends GetxController {

  final List<InvoiceStatusResponse> reports = [];
  final isLoading = true.obs;

  getStatements(int gallaryId,int branchId,int serial,) async {
    isLoading(true);
    InvoiceRepository().getInvoiceStatus(InvoiceStatusRequest());
    isLoading(false);
  }

}
