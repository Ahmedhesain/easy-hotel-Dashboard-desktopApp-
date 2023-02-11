



import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../../core/enums/toast_msg_type.dart';
import '../../../core/utils/show_popup_text.dart';
import '../../../core/utils/user_manager.dart';
import '../../../data/model/daily_attach/dto/daily_attach_detail_dto.dart';
import '../../../data/model/daily_attach/dto/daily_attach_detail_image_dto.dart';
import '../../../data/model/daily_attach/dto/daily_attach_dto.dart';
import '../../../data/model/daily_attach/dto/request/delete_daily_request.dart';
import '../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../data/repository/daily_attach_repository/daily_attach_repository.dart';
import '../../home/controllers/home_controller.dart';

class DailyAttachController extends GetxController {
  final isLoading = false.obs ;
  final date = DateTime.now().obs;
  Rxn<GalleryResponse> selectedGallery = Rxn();
  Rxn<DailyAttachDTO> daily = Rxn();
  final galleries = <GalleryResponse>[].obs;
  final user = UserManager();
  final images = <DailyAttachDetailImageDTO>[].obs;
  final DailyAttachDTO? arg = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    galleries.assignAll(Get.find<HomeController>().galleries);
    if (galleries.any((element) => element.id == user.galleryId)) {
      selectedGallery(
          galleries.singleWhere((element) => element.id == user.galleryId));
    }
    if(arg != null && arg?.id != null){
      setData(arg!);
    }
  }


  addPhotos() async{
    if(selectedGallery.value == null){
      showPopupText(text: 'يجب اختيار معرض');
      return;
    }
    if(date.value == null){
      showPopupText(text: 'يجب ادخال تاريخ');
      return;
    }
    isLoading(true);
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      for(int i = 0 ; i< result.files.length ; i++){
        File file = File(result.files[i].path!);
        images.add(DailyAttachDetailImageDTO(image: base64Encode(file.readAsBytesSync())));
      }


      final request = DailyAttachDTO(
        branchId: user.branchId,
        gallaryId: selectedGallery.value?.id,
        createdBy: user.id,
        id: daily.value?.id,
        dailyAttachDetailDTOList: List<DailyAttachDetailDTO>.generate(1,
           (index) => DailyAttachDetailDTO(
          id: daily.value?.dailyAttachDetailDTOList?.first.id,
          createdBy: daily.value?.dailyAttachDetailDTOList?.first.createdBy ,
          createdDate: daily.value?.dailyAttachDetailDTOList?.first.createdDate ,
          dailyAttachId: daily.value?.id ,
          dailyAttachDetailDetailDTOList: images,
        )),
        date: date.value,
      );

      DailyAttachRepository().save(
          request,
          onComplete: () => isLoading(false),
        onError: (e) => showPopupText(text: e.toString()),
        onSuccess: (data) {
            setData(data);
          showPopupText(text: "تم الحفظ بنجاح" , type: MsgType.success) ;
        }
      );

    }else{
      isLoading(false);
    }

}


setData(DailyAttachDTO data){
  daily(data);
  date(daily.value?.date);
  selectedGallery(galleries.firstWhereOrNull((gal) => gal.id == daily.value?.id));
  images(daily.value?.dailyAttachDetailDTOList?.first.dailyAttachDetailDetailDTOList);
}


reset(){
  daily(null);
  date(DateTime.now());
  selectedGallery(galleries.singleWhere((element) => element.id == user.galleryId));
  images.clear();
}


  delete(int id  ,int index) async {
    isLoading(true);
    final request = DeleteDailyRequest(id: id );
    DailyAttachRepository().deleteDailyImage(request,
        onSuccess: (data){
          showPopupText(text: "تم الحذف بنجاح" , type: MsgType.success);
          images.removeAt(index);
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false));
  }

}