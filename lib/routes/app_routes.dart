import 'package:get/get.dart';
import 'package:unavu_villa_project/view/addOrder_page.dart';
import 'package:unavu_villa_project/view/login_page.dart';
import 'package:unavu_villa_project/view/orderTabletView.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: '/', page: () => LoginPage()),
    GetPage(name: '/dashboard', page: () => DashboardView()),
    GetPage(name: '/addorder', page: () => AddOrderWidget()),
  ];
}
