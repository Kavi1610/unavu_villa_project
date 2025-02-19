import 'package:flutter/material.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';

class CategoryIcon extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const CategoryIcon({
    super.key,
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
          borderRadius: BorderRadius.circular(6),
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
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            // spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Text(
                  text.toUpperCase(),
                  style: AppTextStyles.icontext.copyWith(
                    color: selected ? Colors.white : AppColors.background,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
