import 'package:flutter/material.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';

class MyDropdown extends StatefulWidget {
  final String title;
  final List<String> items; // List of items for the dropdown

  MyDropdown({required this.title, required this.items});

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  String? selectedValue; // Variable to hold the selected value

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the dropdown button
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
          widget.title,
          style: AppTextStyles.heading.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0XFFC2C2C2),
          ),
        ),
        value: selectedValue,
        isExpanded: true, // Make the dropdown take the full width
        icon: Icon(Icons.arrow_forward_ios, size: 16),
        underline: SizedBox(), // Remove the underline
        dropdownColor: Colors.white, // Background color of the dropdown menu
        items: widget.items.map((String item) {
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
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue; // Update the selected value
          });
        },
      ),
    );
  }
}
