import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/core/enums.dart';
import 'package:unavu_villa_project/models/orderDetaul.dart';
import 'package:unavu_villa_project/models/order_list_response_model.dart';
import 'package:unavu_villa_project/provider/dashboard_provider.dart';
import 'package:unavu_villa_project/viewmodels/orderController.dart';

class DashboardController extends GetxController {
  final OrderProvider orderProvider = Get.put(OrderProvider());

  RxString searchQuery = ''.obs;
  RxInt selectedTabIndex = 0.obs;
  RxInt selectedFilterIndex = 0.obs;
  Rx<DeviceType> deviceType = DeviceType.tablet.obs;
  DashboardProvider dashboardProvider = DashboardProvider();
  OrderListResponse orderList = OrderListResponse();
  RxBool isLoading = true.obs;
  List<String> get filterOptions =>
      ['All', 'Dine In', 'Takeaway', 'Room Service', 'Delivery'];
  List<String> get filterOrderScreen =>
      ['All', 'Chicken', 'Seafood', 'Pasta', 'Rice bowl'];
  @override
  void onInit() {
    debugPrint("initState workss");
    super.onInit();
    fetchAllOrders();
    ever(deviceType, (_) => update());
  }

  fetchAllOrders() async {
    await dashboardProvider.fetchOrderList().then((val) {
      if (val.status == true) {
        orderList = val;
        debugPrint("theee resposs : ${orderList.toJson()}");
        isLoading(false);
      } else {
        isLoading(true);
      }
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

  void setFilterIndex(int index) {
    selectedFilterIndex.value = index;
  }

  void setSelectedTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}
