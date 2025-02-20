import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';
import 'package:unavu_villa_project/models/paybill_model.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';

class OrderPaymentPage extends StatelessWidget {
  final Bill bills;
  DashboardController controller = Get.find<DashboardController>();

  OrderPaymentPage({super.key, required this.bills});

  final TextEditingController amountController = TextEditingController();
  final List<String> paymentMethods = [
    "assets/Iconcash.png",
    "assets/Iconmaster.png",
    "assets/Visa credit card.png",
    "assets/Icongift.png"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isTablet = width > 600; // Check if it's a tablet

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: isTablet ? 400 : double.infinity,
        padding: EdgeInsets.all(isTablet ? 20 : 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order Payment",
                  style: GoogleFonts.dmSans(
                    fontSize: isTablet ? 20 : 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),

            SizedBox(height: isTablet ? 16 : 12),

            // Payment Method
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment Method",
                style: GoogleFonts.dmSans(
                    fontSize: isTablet ? 16 : 14, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 8),
            paymentMethodGrid(isTablet),
            SizedBox(height: 16),
            // Select Printer
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Printer",
                style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontSize: isTablet ? 14 : 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 8),

            Obx(() {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.textFiled, width: 1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 8),
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(24),
                    hint: Text(
                      "Select Printer",
                      style: AppTextStyles.heading.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFC2C2C2),
                      ),
                    ),
                    value: controller.selectedPrinter.value.isEmpty
                        ? null
                        : controller.selectedPrinter.value, // Corrected value
                    isExpanded: true,
                    icon: Icon(Icons.arrow_forward_ios, size: 16),
                    underline: SizedBox(),
                    dropdownColor: Colors.white,
                    items: controller.printers.map((String item) {
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
                      controller.selectedPrinter.value =
                          newValue!; // Fixed typo
                    },
                  ),
                ),
              );
            }),

            // Action Buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: isTablet ? 18 : 12),
                    ),
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.white, fontSize: isTablet ? 16 : 14),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.generateBillload(bills);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.orange,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: isTablet ? 18 : 12),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.orange, fontSize: isTablet ? 16 : 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Payment Method Grid
  Widget paymentMethodGrid(bool isTablet) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: paymentMethods.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 3.5, // Adjust based on size
      ),
      itemBuilder: (context, index) {
        return paymentMethodButton(paymentMethods[index], isTablet);
      },
    );
  }

  // Payment Method Button
  Widget paymentMethodButton(String iconPath, bool isTablet) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: isTablet ? 12 : 8),
      child: Center(
        child: Image.asset(iconPath, height: isTablet ? 40 : 30),
      ),
    );
  }

  // Number Pad
  Widget numberPad(bool isTablet) {
    List<String> keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "X",
      "C",
      "0",
      "Add"
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        return numberKey(keys[index], isTablet);
      },
    );
  }

  // Keypad Button
  Widget numberKey(String value, bool isTablet) {
    return GestureDetector(
      onTap: () {
        if (value == "X") {
          if (amountController.text.isNotEmpty) {
            amountController.text = amountController.text
                .substring(0, amountController.text.length - 1);
          }
        } else if (value == "C") {
          amountController.clear();
        } else if (value == "Add") {
          // Add logic here
        } else {
          amountController.text += value;
        }
      },
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: value == "X" ? Colors.red : Colors.grey[200],
        ),
        child: Center(
          child: Text(
            value,
            style: GoogleFonts.dmSans(
              fontSize: isTablet ? 18 : 14,
              fontWeight: FontWeight.bold,
              color: value == "X" ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  // Option Buttons (Tip Amount, Gift Receipt, Email)
  Widget optionButton(String title, bool isTablet) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 20 : 16, vertical: isTablet ? 12 : 8),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: isTablet ? 14 : 12),
      ),
    );
  }
}
