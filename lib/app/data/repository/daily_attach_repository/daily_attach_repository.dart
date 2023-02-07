import '../../model/daily_attach/dto/daily_attach_dto.dart';
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
}