import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';
import 'package:unavu_villa_project/viewmodels/menuController.dart';

class AppSearchBar extends StatelessWidget {
  final ValueChanged<String> onClicked;
  AppSearchBar({super.key, required this.onClicked});

  final DashboardController controller = Get.find<DashboardController>();

  final DashboardController controller =
      Get.find<DashboardController>(); // FIXED: Use existing instance
  String selectedFilter = '';
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
          IconButton(
              onPressed: () {
                _showFilterDialog(context);
              },
              icon: Icon(Icons.filter_list,
                  size: iconSize,
                  color: Colors.grey)), // Replaced Image with Icon
        ],
      ),
    );
  }

  void _showFilterDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Filter Options",
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption("Date", context),
              _buildFilterOption("Ongoing", context),
              _buildFilterOption("Completed", context),
              _buildFilterOption("Cancelled", context),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterOption(String title, context) {
    return ListTile(
      title: Text(title),
      leading: Radio<String>(
        value: title,
        groupValue: selectedFilter,
        onChanged: (value) {
          selectedFilter = value!;

          Navigator.of(context).pop(); // Close dialog after selection
        },
      ),
      onTap: () {
        selectedFilter = title;
        onClicked(selectedFilter);
        Navigator.of(context).pop();
      },
    );
  }
}
