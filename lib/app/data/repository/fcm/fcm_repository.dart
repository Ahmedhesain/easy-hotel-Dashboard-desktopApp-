import 'package:toby_bills/app/data/model/fcm/dto/request/send_fcm_request.dart';
import 'package:toby_bills/app/data/provider/api_provider.dart';

class FCMRepository{

  send(
      SendFcmRequest request, {
        Function()? onComplete,
        Function(void)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<void,dynamic>('https://fcm.googleapis.com/fcm/send',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: request.toJson(),
        header: {
        "Authorization": "key=AAAAeoIbnTY:APA91bEGFoUp2hwM1xcv2JAxQIfceVpS-r3SWHOqzsRUvBE_xeeyh1H5O75neYMKM4jSt0BtisthYpn3mhj1jc0tkb4aIBdCKECJtQMOESSx_IjrI4zUjkYs-_FnVHblaftn2PdrtxsD"
        },
        onError: onError,
        convertor: (_) {  },
      );

}