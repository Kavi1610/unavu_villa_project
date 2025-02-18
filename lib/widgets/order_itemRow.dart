import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/enums.dart';
import 'package:unavu_villa_project/models/orderItem.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';

class OrderItemRow extends StatelessWidget {
  final OrderItem item;
  final String orderId;
  final int index;
  final Function(String, int) onMarkDelivered;

  OrderItemRow({
    Key? key,
    required this.item,
    required this.orderId,
    required this.index,
    required this.onMarkDelivered,
  }) : super(key: key);

  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    controller.updateDeviceType(context);
    final isMobile = controller.deviceType.value == DeviceType.mobile;

    double textSize = isMobile ? 16.0 : 18.0;
    double iconSize = isMobile ? 24.0 : 36.0;

    return Padding(
      padding: EdgeInsets.only(bottom: 8.0,top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.quantity.toString(),
            style: GoogleFonts.dmSans(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: textSize,
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              item.name,
              style: GoogleFonts.dmSans(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: textSize,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              item.isDelivered ? Icons.check_circle : Icons.cancel,
              color: item.isDelivered ? AppColors.green : AppColors.red,
              size: iconSize,
            ),
          ),
          if (!item.isDelivered)
            IconButton(
              icon: Icon(Icons.check, color: AppColors.green),
              onPressed: () => onMarkDelivered(orderId, index),
              iconSize: iconSize,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
