import 'dart:convert';
import 'dart:io';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toby_bills/app.dart';
import 'package:toby_bills/app/services/window_listener.dart';
import 'package:window_manager/window_manager.dart';

WindowController? windowController;
Map<String, dynamic> windowArgs = {};

void main(List<String> args) async {
  if (args.isNotEmpty && args.first == 'multi_window'){
    final windowId = int.parse(args[1]);
    windowController = WindowController.fromWindowId(windowId);
    windowArgs = args[2].isEmpty
        ? const {}
        : jsonDecode(args[2]) as Map<String, dynamic>;
  } else {
    WidgetsFlutterBinding.ensureInitialized();
  }
  await GetStorage.init();
  if (Platform.isWindows) {
    await WindowManager.instance.ensureInitialized();
    await windowManager.waitUntilReadyToShow();
    if(windowController == null) {
      await windowManager.setTitle("Toby Bills");
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
      windowManager.addListener(MyWindowListener());
    }
    await windowManager.setMinimumSize(const Size(1300,700));
    await windowManager.setSize(WidgetsBinding.instance.window.physicalSize);
    await windowManager.maximize();
  }
  Firestore.initialize('tobyerp');
  runApp(const MyApp());
}
