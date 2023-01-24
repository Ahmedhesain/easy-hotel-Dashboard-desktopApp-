


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/core/enums/toast_msg_type.dart';

import '../../../../core/utils/show_popup_text.dart';
import '../../../../core/utils/user_manager.dart';
import '../../../../data/model/crm_reports/dto/request/add_coupon_request.dart';
import '../../../../data/model/customer/dto/request/find_customer_request.dart';
import '../../../../data/model/customer/dto/response/find_customer_response.dart';
import '../../../../data/repository/crm_reports/crm_reports_repository.dart';
import '../../../../data/repository/customer/customer_repository.dart';

class CouponsController extends GetxController {
  final isLoading = false.obs ;
  final selectedCouponType = 0.obs ;

  final couponCodeController = TextEditingController();
  final couponValueController = TextEditingController();
  final customerController = TextEditingController();


  final customerFieldFocusNode = FocusNode();



  final customers = <FindCustomerResponse>[].obs;


  Rxn<FindCustomerResponse> selectedCustomer = Rxn();
  Rxn<DateTime> startDate = Rxn();
  Rxn<DateTime> endDate = Rxn();



  getCustomersByCode() {
    isLoading(true);
    customerFieldFocusNode.unfocus();
    final request =
    FindCustomerRequest(code: customerController.text, branchId: UserManager().branchId, gallaryIdAPI: UserManager().galleryId);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          customerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }


  saveCoupon(){
    isLoading(true);
    final request = AddCouponRequest(
        code: couponCodeController.text,
        discountType: selectedCouponType.value,
        discountValue: double.tryParse(couponValueController.text)!,
        customerId: selectedCustomer.value,
        endDate: endDate.value ,
        startDate: startDate.value,
        createdBy: UserManager().id,
        branchId: UserManager().branchId,
        companyId: UserManager().companyId
    );
    CrmReportsRepository().addCoupon(
        request,
      onComplete: () => isLoading(false),
      onError: (e) => showPopupText(text: e.toString()),
      onSuccess: (_) =>   showPopupText(text: "تم الحفظ بنجاح" , type: MsgType.success)
    );
  }


}