import '../../model/daily_attach/dto/daily_attach_dto.dart';
import '../../model/daily_attach/dto/request/daily_attach_search_request.dart';
import '../../model/daily_attach/dto/request/delete_daily_request.dart';
import '../../provider/api_provider.dart';

class DailyAttachRepository {

  save(
      DailyAttachDTO request, {
        Function()? onComplete,
        Function(DailyAttachDTO data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<DailyAttachDTO,Map<String , dynamic>>('dailyAttach/saveDailyAttach',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: DailyAttachDTO.fromJson,
      );


  search(
      DailyAttachSearchRequest request, {
        Function()? onComplete,
        Function(List<DailyAttachDTO> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<DailyAttachDTO>,List<dynamic>>('dailyAttach/findDailyAttachList',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: DailyAttachDTO.fromList,
      );


  deleteDaily(
      DeleteDailyRequest request, {
        Function()? onComplete,
        Function(void data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<void,Map<String,dynamic>>('dailyAttach/deleteDailyAttach',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: (_){},
      );

  deleteDailyImage(
      DeleteDailyRequest request, {
        Function()? onComplete,
        Function(void data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<void,Map<String,dynamic>>('dailyAttach/deleteDailyAttachImage',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: (_){},
      );
}