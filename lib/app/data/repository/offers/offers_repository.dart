

import '../../model/offers/dto/request/add_offer_request.dart';
import '../../model/offers/dto/response/add_offer_response.dart';
import '../../provider/api_provider.dart';

class OfferRepository {

  saveOffer(
      AddOfferRequest request, {
        Function()? onComplete,
        Function(AddOfferResponse data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<AddOfferResponse,Map<String,dynamic>>('offers/addOffer',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: AddOfferResponse.fromJson,
      );

}