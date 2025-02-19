import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';
import 'package:unavu_villa_project/core/appdimention.dart';
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
          Center(
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
                  const SizedBox(height: 20),

                  // --------- First Drop-down -----------
                  Text(
                    "Select Role",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subheading1
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        color: Colors
                            .white, // Background color of the dropdown button
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(24),
                        padding: EdgeInsets.only(left: 12, right: 8),
                        hint: Text(
                          "Select Floor",
                          style: AppTextStyles.heading.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFFC2C2C2),
                          ),
                        ),
                        value: controller.selectedRole.value,
                        isExpanded:
                            true, // Make the dropdown take the full width
                        icon: Icon(Icons.arrow_forward_ios, size: 16),
                        underline: SizedBox(), // Remove the underline
                        dropdownColor: Colors
                            .white, // Background color of the dropdown menu
                        items: ["Admin", "User", "Guest"].map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                                style: AppTextStyles.heading.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0XFFC2C2C2),
                                )),
                          );
                        }).toList(),
                        onChanged: (value) {
                          controller.selectedRole.value = value!;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --------- Second Drop-down -----------
                  Text(
                    "Select Branch",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subheading1
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // Background color of the dropdown button
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(24),
                          padding: EdgeInsets.only(left: 12, right: 8),
                          hint: Text(
                            "Select Branch",
                            style: AppTextStyles.heading.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFFC2C2C2),
                            ),
                          ),
                          value: controller.selectedBranch.value,
                          isExpanded:
                              true, // Make the dropdown take the full width
                          icon: Icon(Icons.arrow_forward_ios, size: 16),
                          underline: SizedBox(), // Remove the underline
                          dropdownColor: Colors
                              .white, // Background color of the dropdown menu
                          items: ["Admin", "User", "Guest"].map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: AppTextStyles.heading.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0XFFC2C2C2),
                                  )),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.selectedBranch.value = value!;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

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

                  // --------- Login Button -----------
                  Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.login(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize:
                              Size(double.infinity, AppDimensions.buttonHeight),
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
                      child: Text("Made in India", style: AppTextStyles.body)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
