import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toby_bills/app.dart';
import 'package:toby_bills/app/services/window_listener.dart';
// import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  if (Platform.isWindows) {
    // await WindowManager.instance.ensureInitialized();
    // await windowManager.waitUntilReadyToShow();
    // await windowManager.setTitle("Toby Bills");
    // await windowManager.setPreventClose(true);
    // await windowManager.setSkipTaskbar(false);
    // await windowManager.setMinimumSize(const Size(1300,700));
    // await windowManager.setSize(WidgetsBinding.instance.window.physicalSize);
    // await windowManager.maximize();
    // windowManager.addListener(MyWindowListener());
  }
  runApp(const MyApp());
}
