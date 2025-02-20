// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/view/login_page.dart';
import 'routes/app_routes.dart';
import 'package:get_storage/get_storage.dart';

final storage = GetStorage();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UNA VILLA',
      initialRoute: '/',
      getPages: AppRoutes.pages,
      home: LoginPage(),
    );
  }
}
