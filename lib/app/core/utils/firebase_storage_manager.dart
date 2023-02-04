


import 'dart:async';
import 'package:firedart/firedart.dart';


class FirebaseManager {
  static final _manager = FirebaseManager._();
  FirebaseManager._();
  factory FirebaseManager() => _manager;


  // Future uploadNotification(String branchId , NotificationRequestDTO notification)async{
  //  await Firestore.instance.collection('notifications').
  //   document(branchId).collection('branchNotification').add(notification.toJson());
  // }



}