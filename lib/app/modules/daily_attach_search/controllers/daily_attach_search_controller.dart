
import 'package:get/get.dart';
import 'package:toby_bills/app/core/extensions/date_ext.dart';
import '../../../core/enums/toast_msg_type.dart';
import '../../../core/utils/show_popup_text.dart';
import '../../../core/utils/user_manager.dart';
import '../../../data/model/daily_attach/dto/daily_attach_dto.dart';
import '../../../data/model/daily_attach/dto/request/daily_attach_search_request.dart';
import '../../../data/model/daily_attach/dto/request/delete_daily_request.dart';
import '../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../data/repository/daily_attach_repository/daily_attach_repository.dart';
import '../../home/controllers/home_controller.dart';

class DailyAttachSearchController extends GetxController {
  final isLoading = false.obs;

  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  Rxn<GalleryResponse> selectedGallery = Rxn();
  final dailyList = <DailyAttachDTO>[].obs;
  final galleries = <GalleryResponse>[].obs;
  final user = UserManager();

  @override
  void onInit() {
    super.onInit();
    galleries.assignAll(Get.find<HomeController>().galleries);
    if (galleries.any((element) => element.id == user.galleryId)) {
      selectedGallery(
          galleries.singleWhere((element) => element.id == user.galleryId));
    }
  }

  search() async {
    if (selectedGallery.value == null) {
      showPopupText(text: 'يجب اختيار معرض');
      return;
    }
    if (dateFrom.value == null || dateTo.value == null) {
      showPopupText(text: 'يجب ادخال تاريخ');
      return;
    }
    isLoading(true);
    final request = DailyAttachSearchRequest(
        gallaryId: selectedGallery.value?.id,
        branchId: user.branchId,
        dateFrom: dateFrom.value.dayFromStart,
        dateTo: dateTo.value.dayToEnd);

    DailyAttachRepository().search(request,
        onSuccess: (data) => dailyList.assignAll(data),
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false));
  }


  delete(int id  ,int index) async {
    isLoading(true);
    final request = DeleteDailyRequest(id: id );
    DailyAttachRepository().deleteDaily(request,
        onSuccess: (data){
          showPopupText(text: "تم الحذف بنجاح" , type: MsgType.success);
          dailyList.removeAt(index);
        },
        onError: (e) => showPopupText(text: e.toString()),
        onComplete: () => isLoading(false));
  }
}
