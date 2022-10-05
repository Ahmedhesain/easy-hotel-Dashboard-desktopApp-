import 'package:flutter/foundation.dart';

reportCrash(Object error, StackTrace stackTrace){
  debugPrint(error.toString());
  debugPrint(stackTrace.toString());
}