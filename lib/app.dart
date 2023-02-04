import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toby_bills/main.dart';
import 'app/routes/app_pages.dart';

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Topy Bills",
      debugShowCheckedModeBanner: false,
      initialRoute: windowArgs["route"] ?? AppPages.initialRoute,
      getPages: AppPages.routes,
      locale: const Locale("ar"),
    );
  }
}
