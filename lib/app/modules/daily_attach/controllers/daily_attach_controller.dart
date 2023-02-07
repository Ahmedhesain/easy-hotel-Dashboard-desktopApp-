



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
  @override
  void onInit() {
    super.onInit();
    galleries.assignAll(Get.find<HomeController>().galleries);
    if (galleries.any((element) => element.id == user.galleryId)) {
      selectedGallery(
          galleries.singleWhere((element) => element.id == user.galleryId));
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
          daily(data);
          date(daily.value?.date);
          selectedGallery(galleries.firstWhereOrNull((gal) => gal.id == daily.value?.id));
          images(daily.value?.dailyAttachDetailDTOList?.first.dailyAttachDetailDetailDTOList);
          showPopupText(text: "تم الحفظ بنجاح" , type: MsgType.success) ;
        }
      );

    }else{
      isLoading(false);
    }

}

}