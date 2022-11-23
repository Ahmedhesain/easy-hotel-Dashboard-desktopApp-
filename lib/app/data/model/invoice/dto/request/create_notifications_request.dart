import 'package:toby_bills/app/data/model/notifications/dto/request/save_notification_request.dart';

class CreateNotificationRequest{
  final List<SaveNotificationRequest> notifications;

  CreateNotificationRequest(this.notifications);

  Map<String, dynamic> toJson(){
    return {
      'invNoticeDTOAPIList': notifications.map((e) => e.toJson()).toList()
    };
  }
}
