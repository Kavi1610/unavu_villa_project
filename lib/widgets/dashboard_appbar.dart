import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_icon.dart';
import 'package:unavu_villa_project/core/appresponsive.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ValueChanged<int>? onClick;
  DashboardAppBar({super.key, this.onClick});

  final DashboardController controller = Get.put(DashboardController());

  @override
  Size get preferredSize =>
      Size.fromHeight(AppResponsive.isMobile(Get.context!) ? 56.0 : 72.0);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppResponsive.isMobile(context);
    final bool isTablet = AppResponsive.isTablet(context);

    if (isMobile) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 56.0,
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 32.0),
            const SizedBox(width: 8.0),
          ],
        ),
        leading: Builder(
          builder: (context) => SizedBox(
            height: 36.0,
            width: 36.0,
            child: Image.asset('assets/drawer.png', height: 24.0),
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 18.0,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: AssetImage('assets/profile.png'),
          ),
          const SizedBox(width: 16.0),
        ],
      );
    } else {
      return Container(
        height: isMobile ? 56.0 : MediaQuery.sizeOf(context).height / 3,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: AppColors.borderclr, width: 1))),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            Image.asset(
              'assets/image 8.png',
              width: isTablet ? 120 : 150,
              height: isTablet ? 80 : 100,
            ),

            // Navigation Buttons (Wrapped for better responsiveness)
            Expanded(
              child: Wrap(
                spacing: 12.0,
                alignment: WrapAlignment.center,
                children: [
                  _buildNavButton(
                    'Order Home',
                    AppIcons.homeIconTab,
                    () {
                      onClick!(0);
                      controller.setSelectedTabIndex(0);
                    },
                  ),
                  _buildNavButton(
                    'Add Order',
                    'assets/note.png',
                    () {
                      onClick!(1);
                      controller.setSelectedTabIndex(1);
                    },
                  ),
                  _buildNavButton(
                    'Reports',
                    'assets/clock.png',
                    () {
                      onClick!(2);
                      controller.setSelectedTabIndex(2);
                    },
                  ),
                  _buildNavButton(
                    'Menu Availability',
                    'assets/receipt.png',
                    () {
                      onClick!(3);
                      controller.setSelectedTabIndex(3);
                    },
                  ),
                ],
              ),
            ),

            // User Info
            Row(
              children: [
                Text(
                  'Hi Sanju',
                  style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: isTablet ? 14.0 : 16.0,
                  ),
                ),
                const SizedBox(width: 8.0),
                CircleAvatar(
                  radius: isTablet ? 20.0 : 24.0,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                const SizedBox(width: 16.0),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _buildNavButton(
      String label, String iconPath, VoidCallback onPressed) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Image.asset(
        iconPath,
        width: 22.0,
        height: 22.0,
      ),
      label: Text(
        label,
        style: GoogleFonts.dmSans(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: const Color(0XFF828487),
        ),
      ),
    );
  }
}
