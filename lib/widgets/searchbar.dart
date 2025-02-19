import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';
import 'package:unavu_villa_project/viewmodels/menuController.dart';

class AppSearchBar extends StatelessWidget {
  AppSearchBar({Key? key}) : super(key: key);

  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    controller.updateDeviceType(context);
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    double height = isMobile ? 50 : 60; // Adjusted for better sizing
    double iconSize = isMobile ? 20 : 24;

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Icon(Icons.search,
              size: iconSize, color: Colors.grey), // Replaced Image with Icon
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search order by number...',
                border: InputBorder.none,
                hintStyle: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF9E9E9E),
                ),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
                if (value.length > 2) {
                  controller.loadFilterMenuSearch(value);
                }
              },
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.filter_list,
              size: iconSize, color: Colors.grey), // Replaced Image with Icon
        ],
      ),
    );
  }
}
