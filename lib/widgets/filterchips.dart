import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';
import 'package:unavu_villa_project/viewmodels/menuController.dart';

class FilterChips extends StatelessWidget {
  final bool isfromaddOrderScreen;
  final bool isTablet;
  FilterChips(
      {super.key, this.isTablet = true, this.isfromaddOrderScreen = false});

  final DashboardController controller = Get.find<DashboardController>();
  final FoodMenuController menuController = Get.put(FoodMenuController());

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;

    return Obx(
      () => Container(
        width: screensize.width / 3,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              isfromaddOrderScreen
                  ? controller.filterOrderScreen.length
                  : controller.filterOptions.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ChoiceChip(
                  label: Text(
                    isfromaddOrderScreen
                        ? controller.filterOrderScreen[index]
                        : controller.filterOptions[index],
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: controller.selectedFilterIndex.value == index
                          ? Colors.white
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  selected: controller.selectedFilterIndex.value == index,
                  selectedColor: AppColors.primary,
                  backgroundColor: Colors.white,
                  showCheckmark: false,
                  side: BorderSide(
                    color: controller.selectedFilterIndex.value == index
                        ? AppColors.primary
                        : AppColors.textFiled,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  onSelected: (selected) {
                    controller.selectedFilterIndex.value = index;
                    controller.selectedFiltermenu.value = isfromaddOrderScreen
                        ? controller.filterOrderScreen[index]
                        : controller.filterOptions[index];
                    menuController.loadFilterMenuItems(
                        controller.selectedFiltermenu.value,
                        controller.selectedCategory.value);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
