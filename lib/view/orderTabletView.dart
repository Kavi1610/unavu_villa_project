// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';
import 'package:unavu_villa_project/view/addOrder_page.dart';
import 'package:unavu_villa_project/viewmodels/add_orderButton_Controller.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';
import 'package:unavu_villa_project/widgets/dashboard_appbar.dart';
import 'package:unavu_villa_project/widgets/searchbar.dart';
import 'package:unavu_villa_project/widgets/filterchips.dart';
import 'package:unavu_villa_project/widgets/ordercard.dart';
import 'package:unavu_villa_project/widgets/bottom_bar.dart';
import 'package:unavu_villa_project/core/enums.dart' as core;

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final DashboardController controller = Get.put(DashboardController());
  ButtonController buttonController = Get.put(ButtonController());
  @override
  Widget build(BuildContext context) {
    controller.updateDeviceType(context);
    final bool isMobile =
        MediaQuery.of(context).size.width < 600; // Adjust threshold as needed

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: DashboardAppBar(
        onClick: (val) {
          controller.selectedTabIndex.value = val;
        },
      ),
      body: RefreshIndicator(
        onRefresh: () {
          controller.fetchAllOrders();
          return Future.value();
        },
        child: Expanded(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isMobile
                          ? Column(
                              children: [
                                AppSearchBar(
                                  onClicked: (val) {},
                                ),
                                SizedBox(height: 10),
                                FilterChips(isTablet: false),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  // Make Card take available space
                                  child: Card(
                                    elevation: 2,
                                    color: Colors.white,
                                    child: Expanded(
                                        child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 21.0),
                                      child: AppSearchBar(
                                        onClicked: (val) {},
                                      ),
                                    )),
                                  ),
                                ),
                                SizedBox(width: 10), // Adjust spacing
                                InkWell(
                                  onTap: () {
                                    controller.onAdditemSelected(false);
                                    buttonController.makebuttontrue();
                                    Get.toNamed('/addorder');
                                  },
                                  child: Container(
                                    height: 48,
                                    width: MediaQuery.sizeOf(context).width / 9,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      color: AppColors.primary,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Add Order",
                                        style: GoogleFonts.dmSans(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                Obx(() => controller.isLoading.value
                    ? blackLoader()
                    : controller.selectedTabIndex.value == 2
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < 3; i++)
                                    Container(
                                      width: Get.width / 3.5,
                                      height: Get.height / 7,
                                      margin: const EdgeInsets.only(left: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                            ),
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            i == 0
                                                ? "Today Sales"
                                                : i == 1
                                                    ? "Today Order Completed"
                                                    : "Today Order Cancelled",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            i == 0
                                                ? "${controller.reportData.data!.orderCompletedToday}"
                                                : i == 1
                                                    ? "${controller.reportData.data!.orderCompletedToday}"
                                                    : "${controller.reportData.data!.orderCancelledToday}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < 3; i++)
                                    Container(
                                      width: Get.width / 3.5,
                                      height: Get.height / 7,
                                      margin: const EdgeInsets.only(left: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                            ),
                                          ]),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            i == 0
                                                ? "This Week Sales"
                                                : i == 1
                                                    ? "This Week Order Completed"
                                                    : "Today Week Order Cancelled",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            i == 0
                                                ? "${controller.reportData.data!.orderCompletedWeek}"
                                                : i == 1
                                                    ? "${controller.reportData.data!.orderCompletedWeek}"
                                                    : "${controller.reportData.data!.orderCancelledWeek}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          )
                        : Obx(() {
                            if (controller.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (controller.orderList.data!.items!.isEmpty) {
                              return Center(child: Text("No items available"));
                            }

                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12, right: 12, left: 12, bottom: 8),
                                child: StaggeredGridView.countBuilder(
                                  crossAxisCount: 3,
                                  itemCount:
                                      controller.orderList.data!.items!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          OrderCard(
                                    order: controller
                                        .orderList.data!.items![index],
                                  ),
                                  staggeredTileBuilder: (int index) {
                                    int itemCount = controller.orderList.data!
                                        .items![index].items!.length;

                                    // Use a mapping function to determine the height
                                    double heightFactor =
                                        getHeightFactor(itemCount);

                                    return StaggeredTile.count(1, heightFactor);
                                  },

                                  mainAxisSpacing: 12.0,
                                  crossAxisSpacing: 12.0,
                                  physics:
                                      BouncingScrollPhysics(), // Allows natural scrolling
                                ),
                              ),
                            );
                          }))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: isMobile ? BottomNavBar() : null,
    );
  }

  double getHeightFactor(int itemCount) {
    if (itemCount <= 1) return 1.1;
    if (itemCount == 2) return 1.18;
    if (itemCount == 3) return 1.28;
    if (itemCount == 4) return 1.49;
    if (itemCount == 5) return 1.68;
    if (itemCount == 6) return 1.79;
    if (itemCount == 7) return 1.89;
    if (itemCount == 8) return 1.96;
    if (itemCount == 9) return 2.53;
    if (itemCount == 10) return 2.64;
    if (itemCount == 11) return 2.75;
    if (itemCount == 12) return 2.88;
    if (itemCount == 13) return 2.95;
    if (itemCount == 14) return 3.0;
    if (itemCount >= 15) return 3.3; // Max height for large orders
    return 1.1; // Default value
  }
}
