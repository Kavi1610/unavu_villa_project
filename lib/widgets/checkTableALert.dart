import 'package:flutter/material.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';

class TableDetailsDialog extends StatelessWidget {
  const TableDetailsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Table Details",
              style: AppTextStyles.heading.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF19191c)),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: "Select table",
            hintStyle: AppTextStyles.heading.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0XFFC2C2C2)),
            suffixIcon: Icon(Icons.arrow_forward_ios, size: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            hintText: "Number of people",
            hintStyle: AppTextStyles.heading.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0XFFC2C2C2)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                side: BorderSide(color: AppColors.orange),
              ),
              child: Text(
                "Cancel",
                style: AppTextStyles.heading.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.orange,
                ),
              ),
            )),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                ),
                child: Text("Add Items",
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.screenbackground,
                    )),
              ),
            ),
          ],
        )
      ],
    );
  }
}
