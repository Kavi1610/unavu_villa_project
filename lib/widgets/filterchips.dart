import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';

class FilterChips extends StatelessWidget {
  final bool isfromaddOrderScreen;
  final bool isTablet;
  FilterChips(
      {super.key, this.isTablet = true, this.isfromaddOrderScreen = false});

  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;

    return Obx(
      () => Container(
        width: isTablet
            ? screensize.width / 2.2
            : double
                .infinity, // Limited width for tablets, full width for mobile
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              controller.filterOptions.length,
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
