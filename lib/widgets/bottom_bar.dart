import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: controller.selectedTabIndex.value,
                onTap: controller.setSelectedTabIndex,
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      color: controller.selectedTabIndex.value == 0
                          ? Colors.orange
                          : Colors.grey,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.article_outlined,
                      color: controller.selectedTabIndex.value == 1
                          ? Colors.orange
                          : Colors.grey,
                    ),
                    label: 'Orders',
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(width: 30),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.access_time,
                      color: controller.selectedTabIndex.value == 3
                          ? Colors.orange
                          : Colors.grey,
                    ),
                    label: 'History',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.article_outlined,
                      color: controller.selectedTabIndex.value == 4
                          ? Colors.orange
                          : Colors.grey,
                    ),
                    label: 'Orders',
                  ),
                ],
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 28,
              top: -20,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your FAB action here
                  },
                  backgroundColor: Colors.red,
                  child: Icon(Icons.add, size: 32),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ));
  }
}
