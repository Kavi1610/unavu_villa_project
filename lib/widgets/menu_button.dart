import 'package:flutter/material.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';

class CategoryIcon extends StatelessWidget {
  final String icon;
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const CategoryIcon({
    super.key,
    required this.icon,
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: selected
              ? LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xffFFAB18), Color(0xffFF2197)],
                )
              : null,
          color: selected
              ? null
              : Colors.transparent, // Default color when not selected
        ),
        child: Center(
          child: Column(
            // spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                color: selected ? Colors.white : Colors.grey,
                height: 30,
                width: 30,
              ),
              Text(
                text,
                style: AppTextStyles.icontext.copyWith(
                  color: selected ? Colors.white : AppColors.iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
