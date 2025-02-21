import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';
import 'package:unavu_villa_project/core/appdimention.dart';
import 'package:unavu_villa_project/models/floor_master_model.dart';
import 'package:unavu_villa_project/widgets/app_TextFiled.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  final LoginViewModel controller = Get.put(LoginViewModel());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context); // Initialize dimensions

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/Background.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(AppDimensions.padding),
                padding: EdgeInsets.all(AppDimensions.padding),
                width: AppDimensions.containerWidth,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 9,
                        width: MediaQuery.of(context).size.height / 5,
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Center(child: Text("Login", style: AppTextStyles.heading)),
                    const SizedBox(height: 15),
                    Center(
                      child: Text(
                        "CELEBRATE FLAVOUR AND TOGETHERNESS IN EVERY MEAL",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.subheading1,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // -------- Username Field --------
                    Text(
                      "Username",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subheading1
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: "Enter username",
                      icon: Image.asset(
                        'assets/Vector.png',
                        height: 21,
                        width: 21,
                      ),
                      onChanged: (value) =>
                          controller.usernameController.value = value,
                    ),
                    const SizedBox(height: 16),

                    // -------- Password Field --------
                    Text(
                      "Password",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subheading1
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      hintText: "Enter password",
                      icon: Image.asset(
                        'assets/lock-close.png',
                        height: 21,
                        width: 21,
                      ),
                      isObscure: true,
                      onChanged: (value) =>
                          controller.passwordController.value = value,
                    ),

                    const SizedBox(height: 16),
                    // --------- First Drop-down -----------
                    Text(
                      "Branch Id",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subheading1
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: AppColors.textFiled, width: 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 12, right: 8),
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(24),
                            hint: Text(
                              "Select Branch",
                              style: AppTextStyles.heading.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFFC2C2C2),
                              ),
                            ),
                            value: controller.selectedRole.value.isEmpty
                                ? null
                                : controller
                                    .selectedRole.value, // Corrected value
                            isExpanded: true,
                            icon: Icon(Icons.arrow_forward_ios, size: 16),
                            underline: SizedBox(),
                            dropdownColor: Colors.white,
                            items: controller.RoletableDataList.toList()
                                .map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item,
                                    style: AppTextStyles.heading.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    )),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              controller
                                  .selelctRoles(newValue ?? ""); // Fixed typo
                            },
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 16),

                    // --------- Second Drop-down -----------
                    Text(
                      "Select Floor",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subheading1
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: AppColors.textFiled, width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 12, right: 8),
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(24),
                              hint: Text(
                                "Select Floor Id",
                                style: AppTextStyles.heading.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0XFFC2C2C2),
                                ),
                              ),
                              value: controller.selectedBranchId.value.isEmpty
                                  ? null
                                  : controller.selectedBranchId
                                      .value, // Corrected value
                              isExpanded: true,
                              icon: Icon(Icons.arrow_forward_ios, size: 16),
                              underline: SizedBox(),
                              dropdownColor: Colors.white,
                              // Assuming Item has a property called floorname
                              items: controller.BranchtableDataList.map<
                                  DropdownMenuItem<String>>((Item item) {
                                return DropdownMenuItem<String>(
                                  value: item.id
                                      .toString(), // Use the floorname property
                                  child: Text(
                                      item.floorname!, // Display the floorname
                                      style: AppTextStyles.heading.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      )),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  // Find the item by ID
                                  final selectedItem =
                                      controller.BranchtableDataList.firstWhere(
                                    (item) => item.id.toString() == newValue,
                                    orElse: () => Item(
                                        id: 0,
                                        floorname:
                                            ""), // Fallback with empty values
                                  );

                                  if (selectedItem.id != 0) {
                                    controller.selectedBranchId.value =
                                        newValue; // Store ID
                                    controller.selectedBranch.value =
                                        selectedItem
                                            .floorname!; // Store floorname
                                  }
                                }
                              },
                            ),
                          ),
                        )),
                    const SizedBox(height: 16),

                    // --------- Login Button -----------
                    Obx(() => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.login(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: Size(
                                double.infinity, AppDimensions.buttonHeight),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(58)),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                                  color: AppColors.buttonText)
                              : Text("Login Now", style: AppTextStyles.button),
                        )),
                    const SizedBox(height: 56),

                    Center(
                        child:
                            Text("Made in India", style: AppTextStyles.body)),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
