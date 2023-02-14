import 'package:get/get.dart';
import 'package:toby_bills/app/core/extensions/date_ext.dart';
import 'package:toby_bills/app/core/utils/show_popup_text.dart';
import 'package:toby_bills/app/data/model/gallery_expenses/dto/GalleryExpensesDTO.dart';
import '../../../core/enums/toast_msg_type.dart';
import '../../../core/utils/user_manager.dart';
import '../../../data/model/gallery_expenses/dto/request/deleteGalleryExpensesListRequest.dart';
import '../../../data/model/gallery_expenses/dto/request/getGalleryExpensesListRequest.dart';
import '../../../data/model/invoice/dto/response/gallery_response.dart';
import '../../../data/repository/gallery_expenses_repository/gallery_expenses_repository.dart';
import '../../home/controllers/home_controller.dart';

class DailyExpensesSearchController extends GetxController {
  final isLoading = false.obs;

  Rxn<GalleryResponse> selectedGallery = Rxn();
  final galleries = <GalleryResponse>[].obs;
  final user = UserManager();
  final dateFrom = DateTime.now().obs;
  final dateTo = DateTime.now().obs;
  final reportList = <GalleryExpensesDTO>[].obs ;
  final total = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    galleries.assignAll(Get.find<HomeController>().galleries);
    if (galleries.any((element) => element.id == user.galleryId)) {
      selectedGallery(
          galleries.singleWhere((element) => element.id == user.galleryId));
    }
  }

  search(){
    isLoading(true);
    final request = GetGalleryExpensesListRequest(
      galleryId: selectedGallery.value!.id!,
      dateFrom: dateFrom.value.dayFromStart,
      dateto: dateTo.value.dayToEnd,
    );
    GalleryExpensesRepository().getExpensesList(request,
    onSuccess: (date){
      reportList.assignAll(date);
      reportList.refresh();
      reportList.forEach((element) {
        total.value+=(element.value ?? 0.0);
      });
    } ,
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false)
    );
  }

  delete(int id){
    isLoading(true);
    final request = DeleteGalleryExpensesRequest(
     id : id
    );
    GalleryExpensesRepository().deleteExpenses(request,
    onSuccess: (date){
      showPopupText(text: "تم الحذف بنجاح"  , type: MsgType.success);
      reportList.removeWhere((element) => element.id == id);
    } ,
      onError: (e) => showPopupText(text: e.toString()),
      onComplete: () => isLoading(false)
    );
  }

}
