import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/appdimention.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle heading = GoogleFonts.dmSans(
    fontSize: AppDimensions.scaleFont(18),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle subheading = GoogleFonts.dmSans(
    fontSize: AppDimensions.scaleFont(16),
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle subheading1 = GoogleFonts.dmSans(
    fontSize: AppDimensions.scaleFont(10),
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle body = GoogleFonts.dmSans(
    fontSize: AppDimensions.scaleFont(16),
    color: AppColors.textPrimary,
  );

  static TextStyle button = GoogleFonts.dmSans(
    fontSize: AppDimensions.scaleFont(16),
    fontWeight: FontWeight.w600,
    color: AppColors.buttonText,
  );

  static TextStyle errorText = GoogleFonts.dmSans(
    fontSize: AppDimensions.scaleFont(14),
    fontWeight: FontWeight.w600,
    color: AppColors.errorText,
  );
  static TextStyle icontext = GoogleFonts.dmSans(
    fontSize: AppDimensions.scaleFont(12),
    fontWeight: FontWeight.w500,
    color: AppColors.iconColor,
  );
}
