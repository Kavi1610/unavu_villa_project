import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/core/enums.dart';
import 'package:unavu_villa_project/models/orderDetaul.dart';
import 'package:unavu_villa_project/models/orderItem.dart';

class OrderProvider extends GetxController {
  RxList<Order> orders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() {
    // In a real app, this would be an API call
    orders.value = [
      Order(
        id: '01',
        date: DateTime.now(),
        tableNumber: '01',
        startTime: TimeOfDay(hour: 4, minute: 48),
        endTime: TimeOfDay(hour: 5, minute: 48),
        items: [
          OrderItem(name: 'Veg Cheese Pizza', quantity: 1),
          OrderItem(name: 'Mushroom Pizza', quantity: 1),
          OrderItem(name: 'Coke/Lemonade', quantity: 1),
        ],
        status: OrderStatus.pending,
        type: 'Table number',
      ),
      Order(
        id: '01',
        date: DateTime.now(),
        tableNumber: '01',
        startTime: TimeOfDay(hour: 4, minute: 48),
        endTime: TimeOfDay(hour: 5, minute: 48),
        items: [
          OrderItem(name: 'Veg Cheese Pizza', quantity: 1, isDelivered: true),
          OrderItem(name: 'Mushroom Pizza', quantity: 1, isDelivered: true),
          OrderItem(name: 'Coke/Lemonade', quantity: 1, isDelivered: true),
        ],
        status: OrderStatus.inProgress,
        type: 'Table number',
      ),
      Order(
        id: '02',
        date: DateTime.now(),
        tableNumber: '02',
        startTime: TimeOfDay(hour: 4, minute: 48),
        endTime: TimeOfDay(hour: 5, minute: 48),
        items: [
          OrderItem(name: 'Veg Cheese Pizza', quantity: 1, isDelivered: true),
          OrderItem(name: 'Mushroom Pizza', quantity: 1, isDelivered: true),
          OrderItem(name: 'Coke/Lemonade', quantity: 1, isDelivered: true),
        ],
        status: OrderStatus.inProgress,
        type: 'Table number',
      ),
      Order(
        id: '03',
        date: DateTime.now(),
        tableNumber: '03',
        startTime: TimeOfDay(hour: 4, minute: 48),
        endTime: TimeOfDay(hour: 5, minute: 48),
        items: [
          OrderItem(name: 'Veg Cheese Pizza', quantity: 1, isDelivered: true),
          OrderItem(name: 'Mushroom Pizza', quantity: 1, isDelivered: true),
          OrderItem(name: 'Coke/Lemonade', quantity: 1, isDelivered: true),
        ],
        status: OrderStatus.cancelled,
        type: 'Table number',
      ),
      Order(
        id: '01',
        date: DateTime.now(),
        tableNumber: '01',
        startTime: TimeOfDay(hour: 4, minute: 48),
        endTime: TimeOfDay(hour: 6, minute: 0),
        items: [
          OrderItem(name: 'Veg Cheese Pizza', quantity: 1, isDelivered: true),
          OrderItem(name: 'Mushroom Pizza', quantity: 1, isDelivered: true),
          OrderItem(name: 'Coke/Lemonade', quantity: 1, isDelivered: true),
        ],
        status: OrderStatus.completed,
        type: 'Table number',
      ),
    ];
  }

  void updateOrderStatus(String id, OrderStatus status) {
    final index = orders.indexWhere((order) => order.id == id);
    if (index != -1) {
      // Create a new order with updated status
      final updatedOrder = Order(
        id: orders[index].id,
        date: orders[index].date,
        tableNumber: orders[index].tableNumber,
        startTime: orders[index].startTime,
        endTime: orders[index].endTime,
        items: orders[index].items,
        status: status,
        type: orders[index].type,
      );

      // Update the list
      orders[index] = updatedOrder;
      orders.refresh();
    }
  }

  void markItemAsDelivered(String orderId, int itemIndex) {
    final orderIndex = orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1 && itemIndex < orders[orderIndex].items.length) {
      final order = orders[orderIndex];
      final updatedItems = List<OrderItem>.from(order.items);

      // Create new item with updated delivery status
      updatedItems[itemIndex] = OrderItem(
        name: order.items[itemIndex].name,
        quantity: order.items[itemIndex].quantity,
        isDelivered: true,
      );

      // Create new order with updated items
      orders[orderIndex] = Order(
        id: order.id,
        date: order.date,
        tableNumber: order.tableNumber,
        startTime: order.startTime,
        endTime: order.endTime,
        items: updatedItems,
        status: order.status,
        type: order.type,
      );

      orders.refresh();
    }
  }
}
