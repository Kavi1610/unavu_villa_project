import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/core/enums.dart';
import 'package:unavu_villa_project/models/orderDetaul.dart';
import 'package:unavu_villa_project/viewmodels/orderController.dart';

class DashboardController extends GetxController {
  final OrderProvider orderProvider = Get.put(OrderProvider());

  RxString searchQuery = ''.obs;
  RxInt selectedTabIndex = 0.obs;
  RxInt selectedFilterIndex = 0.obs;
  Rx<DeviceType> deviceType = DeviceType.tablet.obs;

  List<String> get filterOptions =>
      ['All', 'Dine In', 'Takeaway', 'Room Service', 'Delivery'];
  List<String> get filterOrderScreen =>
      ['All', 'Chicken', 'Seafood', 'Pasta', 'Rice bowl'];
  @override
  void onInit() {
    super.onInit();
    ever(deviceType, (_) => update());
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
