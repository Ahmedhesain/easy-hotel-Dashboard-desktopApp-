

import '../../model/offers/dto/request/add_offer_request.dart';
import '../../model/offers/dto/request/get_offers_request.dart';
import '../../model/offers/dto/response/add_offer_response.dart';
import '../../model/offers/offer_dto.dart';
import '../../provider/api_provider.dart';

class OfferRepository {

  saveOffer(
      OfferDTO request, {
        Function()? onComplete,
        Function(OfferDTO data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<OfferDTO,Map<String,dynamic>>('offers/addOffer',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: OfferDTO.fromJson,
      );

  getAllOffer(
      GetOfferRequest request, {
        Function()? onComplete,
        Function(List<OfferDTO> data)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<OfferDTO>,List<dynamic>>('offers/allOffers',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: OfferDTO.fromList,
      );

}