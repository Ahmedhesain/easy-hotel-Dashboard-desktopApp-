import 'package:toby_bills/app/data/model/general_journal/dto/request/account_summary_request.dart';
import 'package:toby_bills/app/data/model/general_journal/dto/request/find_general_journal_request.dart';
import 'package:toby_bills/app/data/model/general_journal/dto/response/account_summary_response.dart';
import 'package:toby_bills/app/data/model/general_journal/genraljournal.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';

class GeneralJournalRepository {

  findGeneralJournalById(
      FindGeneralJournalRequest findGeneralJournalRequest, {
        Function()? onComplete,
        Function(GeneralJournalModel data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<GeneralJournalModel,Map<String,dynamic>>('generaljournal/findgeneraljournalById',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: findGeneralJournalRequest.toJson(),
        onError: onError,
        convertor: GeneralJournalModel.fromJson,
    );

  getAccountSummary(
      AccountSummaryRequest accountSummaryRequest, {
        Function()? onComplete,
        Function(List<AccountSummaryResponse> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
    ApiProvider().post<List<AccountSummaryResponse>,List<dynamic>>('generaljournal/subaccountsummaryreport',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: accountSummaryRequest.toJson(),
        onError: onError,
        convertor: AccountSummaryResponse.fromList,
    );

}
