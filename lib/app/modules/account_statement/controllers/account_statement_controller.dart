import 'package:get/get.dart';
import 'package:toby_bills/app/core/extensions/string_ext.dart';
import 'package:toby_bills/app/data/model/customer/dto/request/account_statement_request.dart';
import 'package:toby_bills/app/data/model/customer/dto/response/account_statement_response.dart';
import 'package:toby_bills/app/data/repository/customer/customer_repository.dart';
import 'package:toby_bills/app/modules/home/controllers/home_controller.dart';

import '../../../core/utils/show_popup_text.dart';

class AccountStatementController extends GetxController {


  final List<AccountStatementResponse> reports = [];
  final isLoading = true.obs;


  @override
  void onInit() {
    super.onInit();
    getStatements();
  }

  getStatements() async {
    isLoading(true);
    final request = AccountStatementRequest(id: Get.find<HomeController>().selectedCustomer.value!.id!);
    CustomerRepository().getCustomerAccountStatement(request,
        onSuccess: (data) {
          if (data.isNotEmpty) {
            data.first.balance = data.first.sub;
          }
          for (var i = 1; i < data.length; i++) {
            data[i].balance = data[i].sub + data[i-1].balance;
          }
          reports.assignAll(data);
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false)
    );
  }


}
