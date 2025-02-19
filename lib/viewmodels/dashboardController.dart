import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/core/enums.dart';
import 'package:unavu_villa_project/models/orderDetaul.dart';
import 'package:unavu_villa_project/models/order_list_response_model.dart';
import 'package:unavu_villa_project/models/report_response_model.dart';
import 'package:unavu_villa_project/provider/dashboard_provider.dart';
import 'package:unavu_villa_project/viewmodels/orderController.dart';

class DashboardController extends GetxController {
  final OrderProvider orderProvider = Get.put(OrderProvider());

  RxString searchQuery = ''.obs;
  RxInt selectedTabIndex = 0.obs;
  RxInt selectedFilterIndex = 0.obs;
  RxString selectedFiltermenu = ''.obs;
  RxString selectedCategory = ''.obs;

  Rx<DeviceType> deviceType = DeviceType.tablet.obs;
  DashboardProvider dashboardProvider = DashboardProvider();
  OrderListResponse orderList = OrderListResponse();
  ReportResponseModel reportData = ReportResponseModel();
  RxBool isLoading = true.obs;
  List<String> get filterOptions => ['Dine In'];
  List<String> get filterOrderScreen => [
        'All',
        'Veg',
        'Non Veg',
      ];
  @override
  void onInit() {
    debugPrint("initState workss");
    super.onInit();
    fetchAllOrders();
    ever(deviceType, (_) => update());
  }

  fetchAllOrders() async {
    String branchId = "101";
    await dashboardProvider.fetchOrderList(branchId).then((val) {
      if (val.status == true) {
        orderList = val;
        fetchReport();
        debugPrint("theee resposs : ${orderList.toJson()}");
      } else {
        isLoading(true);
      }
    });
  }

  void fetchReport() async {
    await dashboardProvider.fetchReport().then((val) {
      reportData = val;
      isLoading(false);
    });
  }

  void updateDeviceType(BuildContext context) {
    // Determine device type based on width
    if (MediaQuery.of(context).size.width < 600) {
      deviceType.value = DeviceType.mobile;
    } else {
      deviceType.value = DeviceType.tablet;
    }
  }

  List<Order> get allOrders => orderProvider.orders;
  List<Order> get pendingOrders => orderProvider.orders
      .where((o) => o.status == OrderStatus.pending)
      .toList();

  List<Order> get inProgressOrders => orderProvider.orders
      .where((o) => o.status == OrderStatus.inProgress)
      .toList();

  List<Order> get completedOrders => orderProvider.orders
      .where((o) => o.status == OrderStatus.completed)
      .toList();

  void markOrderAsCompleted(String id) {
    orderProvider.updateOrderStatus(id, OrderStatus.completed);
  }

  void cancelOrder(String id) {
    orderProvider.updateOrderStatus(id, OrderStatus.cancelled);
  }

  void markItemAsDelivered(String orderId, int itemIndex) {
    orderProvider.markItemAsDelivered(orderId, itemIndex);
  }

  void setFilterIndex(int index, String name) {
    selectedFilterIndex.value = index;
    selectedFiltermenu.value = name;
  }

  void onCategorySelected(String category) {
    selectedCategory.value = category;
  }

  void setSelectedTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}
