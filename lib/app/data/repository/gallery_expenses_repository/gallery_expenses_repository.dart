


import '../../model/gallery_expenses/dto/GalleryExpensesDTO.dart';
import '../../model/gallery_expenses/dto/request/deleteGalleryExpensesListRequest.dart';
import '../../model/gallery_expenses/dto/request/getGalleryExpensesListRequest.dart';
import '../../provider/api_provider.dart';

class GalleryExpensesRepository {
  save(
      GalleryExpensesDTO request, {
        Function()? onComplete,
        Function(GalleryExpensesDTO data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<GalleryExpensesDTO,Map<String , dynamic>>('dailyAttach/saveGalleryExpenses'
          '',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: GalleryExpensesDTO.fromJson,
      );

  getExpensesList(
      GetGalleryExpensesListRequest request, {
        Function()? onComplete,
        Function(List<GalleryExpensesDTO> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<GalleryExpensesDTO>,List<dynamic>>('dailyAttach/findGalleryExpenses'
          '',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: GalleryExpensesDTO.fromList,
      );

  deleteExpenses(
     DeleteGalleryExpensesRequest request, {
        Function()? onComplete,
        Function(void)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<void,void>('dailyAttach/deleteGalleryExpenses'
          '',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: (_){},
      );

}