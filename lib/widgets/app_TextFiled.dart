import 'package:flutter/material.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Image icon; // Accepting an Image widget directly
  final bool isObscure;
  final Function(String) onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        obscureText: isObscure,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0), // Adjust padding if needed
            child: icon, // Directly passing the Image widget
          ),
          hintText: hintText,
          hintStyle: AppTextStyles.subheading1.copyWith(
              color: AppColors.textFiled1,
              fontWeight: FontWeight.w400,
              fontSize: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(58),
            borderSide: BorderSide(color: AppColors.textFiled, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(58),
            borderSide: BorderSide(color: AppColors.textFiled, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(58),
            borderSide: BorderSide(color: AppColors.textFiled, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(58),
            borderSide: BorderSide(color: AppColors.textFiled, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(58),
            borderSide: BorderSide(color: AppColors.errorText, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(58),
            borderSide: BorderSide(color: AppColors.errorText, width: 1),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
