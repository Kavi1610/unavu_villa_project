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
                    "Select Floor",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subheading1
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => DropdownButtonFormField<String>(
                        value: controller.selectedRole.value,
                        style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.errorText, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        items: ["Admin", "User", "Guest"]
                            .map((role) => DropdownMenuItem(
                                value: role, child: Text(role)))
                            .toList(),
                        onChanged: (value) {
                          controller.selectedRole.value = value!;
                        },
                      )),
                  const SizedBox(height: 16),

                  // --------- Second Drop-down -----------
                  Text(
                    "Select Branch",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subheading1
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => DropdownButtonFormField<String>(
                        style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        value: controller.selectedBranch.value,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.errorText, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        items: ["New York", "Los Angeles", "Chicago"]
                            .map((branch) => DropdownMenuItem(
                                value: branch, child: Text(branch)))
                            .toList(),
                        onChanged: (value) {
                          controller.selectedBranch.value = value!;
                        },
                      )),
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

                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Forgot password?",
                          style: AppTextStyles.errorText),
                    ),
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
