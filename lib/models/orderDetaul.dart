import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:unavu_villa_project/core/enums.dart';
import 'package:unavu_villa_project/models/orderItem.dart';

class Order {
  final String id;
  final DateTime date;
  final String tableNumber;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<OrderItem> items;
  final OrderStatus status;
  final String type;

  Order({
    required this.id,
    required this.date,
    required this.tableNumber,
    required this.startTime,
    required this.endTime,
    required this.items,
    this.status = OrderStatus.pending,
    this.type = 'Table number',
  });

  String get formattedDate => DateFormat('dd/MM/yyyy').format(date);

  String get formattedStartTime {
    final hour = startTime.hour > 12 ? startTime.hour - 12 : startTime.hour;
    final period = startTime.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} $period';
  }

  String get formattedEndTime {
    final hour = endTime.hour > 12 ? endTime.hour - 12 : endTime.hour;
    final period = endTime.hour >= 12 ? 'PM' : 'AM';
    return '${hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')} $period';
  }

  Color get statusColor {
    switch (status) {
      case OrderStatus.pending:
        return Color(0xFFFBAF03);
      case OrderStatus.inProgress:
        return Color(0xFF10C42F);
      case OrderStatus.completed:
        return Color(0xFFFBAF03);
      case OrderStatus.cancelled:
        return Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  Color get cardColor {
    switch (status) {
      case OrderStatus.pending:
        return Color(0xFFFFF0F0);
      case OrderStatus.inProgress:
        return Color(0xFFF0FFF0);
      case OrderStatus.completed:
        return Color(0xFFFFF8E1);
      default:
        return Colors.white;
    }
  }
}
