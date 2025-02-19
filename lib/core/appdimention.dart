import 'package:flutter/widgets.dart';

class AppDimensions {
  static late double screenWidth;
  static late double screenHeight;
  static late bool isTablet;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    isTablet = screenWidth > 600;
  }

  // Font scaling based on device type
  static double scaleFont(double size) {
    return isTablet ? size * 1.2 : size; // Increase font size for tablets
  }

  static double get containerWidth => isTablet ? 450 : 350;
  static double get buttonHeight => isTablet ? 56 : 48;
  static double get padding => isTablet ? 16 : 16;
}
