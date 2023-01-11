


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/app/data/model/common/symbol_model_dto.dart';
import 'package:toby_bills/app/data/model/crm/request/crm_event_request.dart';
import 'package:toby_bills/app/data/model/invoice/dto/response/gallery_response.dart';

import '../../../core/enums/toast_msg_type.dart';
import '../../../core/utils/show_popup_text.dart';
import '../../../core/utils/user_manager.dart';
import '../../../data/model/common/request/symbol_request.dart';
import '../../../data/model/crm/request/follower_request.dart';
import '../../../data/model/crm/response/follower_response.dart';
import '../../../data/model/customer/dto/request/find_customer_request.dart';
import '../../../data/model/customer/dto/response/find_customer_response.dart';
import '../../../data/model/invoice/dto/request/gallery_request.dart';
import '../../../data/repository/crm/crm_repository.dart';
import '../../../data/repository/customer/customer_repository.dart';
import '../../../data/repository/invoice/invoice_repository.dart';

class CrmEventController extends GetxController {

  final galleries = <GalleryResponse>[].obs ;
  final eventTypes = <SymbolDTO>[].obs ;
  final eventPriorityList = <SymbolDTO>[].obs ;
  final followersList = <FollowerResponse>[].obs ;
  final customers = <FindCustomerResponse>[].obs;

  final crmCustomerFieldFocusNode = FocusNode();

  final crmCustomerController = TextEditingController();
  final crmEventAddressController = TextEditingController();
  final crmEventTextController = TextEditingController();

  Rxn<FindCustomerResponse> selectedCrmCustomer = Rxn();
  Rxn<SymbolDTO> selectedEventType = Rxn();
  Rxn<SymbolDTO> selectedEventPriority = Rxn();
  Rxn<FollowerResponse> selectedFollower = Rxn();
  Rxn<GalleryResponse> selectedCrmEventGallery = Rxn();

  final isLoading = false.obs ;

  @override
  onInit(){
    super.onInit();
    getGalleries();
    getEventTypes();
    getFollowersList();
    getPriorityList();
  }

  getCustomersByCodeForInvoice() {
    if(selectedCrmEventGallery.value ==null){
      showPopupText(text: 'يجب اختيار معرض');
      return ;
    }
    isLoading(true);
    crmCustomerFieldFocusNode.unfocus();
    final request =
    FindCustomerRequest(code: crmCustomerController.text, branchId: UserManager().branchId, gallaryIdAPI: selectedCrmEventGallery.value!.id!);
    CustomerRepository().findCustomerByCode(request,
        onSuccess: (data) {
          customers.assignAll(data);
          crmCustomerFieldFocusNode.requestFocus();
        },
        onError: (error) => showPopupText(text: error.toString()),
        onComplete: () => isLoading(false));
  }

  getEventTypes(){
    isLoading(true);
    final request = SymbolRequest(companyId: UserManager().companyId);
    CrmRepository().getEventTypes(request ,
      onComplete: () => isLoading(false),
      onError: (e) => showPopupText(text: e),
      onSuccess: (data){
        eventTypes.assignAll(data);
        if(data.isNotEmpty){
          selectedEventType(data[0]);
        }
      }
    );
  }

  getPriorityList(){
    isLoading(true);
    final request = SymbolRequest(companyId: UserManager().companyId);
    CrmRepository().getPriorityList(request ,
        onComplete: () => isLoading(false),
        onError: (e) => showPopupText(text: e),
        onSuccess: (data){
          eventPriorityList.assignAll(data);
          if(data.isNotEmpty){
            selectedEventPriority(data[0]);
          }
        }
    );
  }

  getFollowersList(){
    isLoading(true);
    final request = FollowerRequest(branchId: UserManager().branchId);
    CrmRepository().getFollowers(request ,
      onComplete: () => isLoading(false),
      onError: (e) => showPopupText(text: e),
      onSuccess: (data){
        for (FollowerResponse element in data) {
          if(followersList.indexWhere((follower) => follower.id == element.id) == -1){
            followersList.add(element);
          }
        }
        if(data.isNotEmpty){
          selectedFollower(data[0]);
        }
      }
    );
  }

  Future<void> getGalleries() {
    isLoading(true);
    return InvoiceRepository().getGalleries(
      GalleryRequest(branchId: UserManager().branchId, id: UserManager().id),
      onSuccess: (data) {
        galleries.assignAll(data);
        if (galleries.any((element) => element.id == UserManager().galleryId)) {
          selectedCrmEventGallery(galleries.singleWhere((element) => element.id == UserManager().galleryId));
        } else if (galleries.isNotEmpty) {
          selectedCrmEventGallery(galleries.first);
        }
      },
      onError: (error) => showPopupText(text: error.toString()),
      onComplete: () => isLoading(false)
    );
  }

  Future<void>  addCRMEvent()async{
    isLoading(true);
    final request = CRMEventRequest(
      companyId: UserManager().companyId,
      branchId: UserManager().branchId,
      assignedToId: selectedFollower.value?.id ,
      crmTypeId: selectedEventType.value?.id,
      statusId:selectedEventType.value?.id,
      customer: selectedCrmCustomer.value?.id ,
      discription: crmEventTextController.text ,
      galleryId: selectedCrmEventGallery.value?.id ,
      periorityId: selectedEventPriority.value?.id ,
      subject: crmEventAddressController.text ,
      createdBy: UserManager().id
    );
   await CrmRepository().addCrmEvent(
        request ,
      onComplete: () => isLoading(false),
      onError: (e) => showPopupText(text: e),
      onSuccess: (data){
          if(data.msg == "success"){
            showPopupText(text: 'تم الحفظ بنجاح' , type: MsgType.success);
            clear();
        }else{
            showPopupText(text: data.msg! , type: MsgType.error);
          }
      }
    );
  }

  clear(){
    selectedCrmCustomer(null);
    crmEventTextController.clear();
    crmEventAddressController.clear();
    crmCustomerController.clear() ;
  }

}