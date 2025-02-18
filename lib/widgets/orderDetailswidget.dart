import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_icon.dart';
import 'package:unavu_villa_project/core/appdimention.dart';
import 'package:unavu_villa_project/models/getMenuItem.dart';
import 'package:unavu_villa_project/models/menuItem.dart';
import 'package:unavu_villa_project/viewmodels/menuController.dart';

class OrderDetailsWidget extends StatelessWidget {
  final FoodMenuController menuController = Get.find<FoodMenuController>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Obx(() => menuController.takeOrder.value
        ? UserInformation()
        : Container(
            width: screenSize.width * 0.3,
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Orders details',
                    style: GoogleFonts.dmSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Cart Items List
                  Obx(() => Column(
                        children: menuController.cartItems
                            .map((item) => CartItem(item: item))
                            .toList(),
                      )),
                  Divider(),

                  // Order Note
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Write your order note here...",
                        hintStyle: GoogleFonts.dmSans(
                            fontSize: 12, color: AppColors.textFiled),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                width: 1, color: AppColors.textFiled1)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                      ),
                      maxLines: 2,
                    ),
                  ),

                  Divider(),

                  // Pricing Details
                  Obx(() => totalRow(
                      title: 'Total Amount',
                      value:
                          '\$${menuController.subTotal.toStringAsFixed(2)}')),
                  SizedBox(
                    height: 4,
                  ),
                  Obx(() => totalRow(
                      title: 'Tax (10%)',
                      value: '\$${menuController.tax.toStringAsFixed(2)}')),
                  SizedBox(
                    height: 4,
                  ),
                  totalRow(title: 'Discount', value: '%'),
                  SizedBox(
                    height: 4,
                  ), // Placeholder for discount
                  Obx(() => totalRow(
                      title: 'Round off',
                      value: '\$${menuController.roundOff.toStringAsFixed(2)}',
                      isHighlighted: true)),
                  SizedBox(
                    height: 4,
                  ),
                  Obx(() => totalRow(
                      title: 'Grand Total',
                      value: '\$${menuController.total.toStringAsFixed(2)}',
                      isTotal: true)),
                  SizedBox(
                    height: 21,
                  ),
                  // Order Now Button
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        menuController.takeOrderNow();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 21),
                      ),
                      child: Text(
                        "Order now",
                        style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
  }

  // Total Row Widget
  Widget totalRow(
      {required String title,
      required String value,
      bool isTotal = false,
      bool isHighlighted = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.dmSans(fontSize: 14, color: Colors.grey)),
          Text(value,
              style: GoogleFonts.dmSans(
                fontSize: isTotal ? 16 : 14,
                fontWeight: FontWeight.bold,
                color: isTotal
                    ? Colors.orange
                    : (isHighlighted ? Colors.red : Colors.black),
              )),
        ],
      ),
    );
  }

  Widget UserInformation() {
    return Container(
        width: AppDimensions.screenWidth * 0.3,
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Title
          Text(
            'Orders details',
            style: GoogleFonts.dmSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Full name",
                style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.iconColor),
              ),
              SizedBox(
                height: 4,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter name",
                    hintStyle: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFC2C2C2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: AppColors.textFiled, width: 1))),
              ),
              SizedBox(height: 10),
              Text(
                "Phone number",
                style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.iconColor),
              ),
              SizedBox(
                height: 4,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter customer phone number",
                    hintStyle: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFC2C2C2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: AppColors.textFiled, width: 1))),
              ),
              SizedBox(height: 10),
              Text(
                "Address",
                style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.iconColor),
              ),
              SizedBox(
                height: 4,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter customer address",
                    hintStyle: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFC2C2C2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: AppColors.textFiled, width: 1))),
              ),
              SizedBox(height: 10),
              Text(
                "GST Number",
                style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.iconColor),
              ),
              SizedBox(
                height: 4,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter GST number",
                    hintStyle: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFC2C2C2)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: AppColors.textFiled, width: 1))),
              ),
              SizedBox(height: 20),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sub Total",
                      style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.iconColor)),
                  Text('\$${menuController.subTotal.toStringAsFixed(2)}',
                      style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF19191C))),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tax (10%)",
                      style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.iconColor)),
                  Text('\$${menuController.tax.toStringAsFixed(2)}',
                      style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF19191C))),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",
                      style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.iconColor)),
                  Text('\$${menuController.tax.toStringAsFixed(2)}',
                      style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange)),
                ],
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 44),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36)),
                ),
                child: Center(
                  child: Text(
                    "Save and Send to KOT",
                    style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36)),
                ),
                child: Center(
                  child: Text(
                    "Verify KOT",
                    style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  side: BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ),
            ],
          )
        ])));
  }
}

// Cart Item Widget
class CartItem extends StatelessWidget {
  final MenuItem item;
  CartItem({required this.item});

  final FoodMenuController menuController = Get.find<FoodMenuController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(AppIcons.productImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.itemname,
                    style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 2),
                Text("Price",
                    style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textFiled)),
                Obx(() => Text(
                      "\$${(item.price * (menuController.itemQuantities[item] ?? 1))}",
                      style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.orange),
                    )),
              ],
            ),
          ),

          // Quantity Controls
          Row(
            children: [
              // Decrease Button
              QuantityButton(
                icon: Icons.remove,
                onPressed: () => menuController.decrement(item),
                isDisabled: (menuController.itemQuantities[item] ?? 1) <= 1,
              ),
              SizedBox(width: 6),

              // Quantity Display
              Obx(() => Text(
                    menuController.itemQuantities[item]?.toString() ?? "0",
                    style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              SizedBox(width: 6),

              // Increase Button
              QuantityButton(
                icon: Icons.add,
                onPressed: () => menuController.increment(item),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Quantity Button Widget
class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDisabled;

  QuantityButton(
      {required this.icon, required this.onPressed, this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDisabled ? Colors.grey[300] : AppColors.textFiled1,
      ),
      child: Center(
        child: IconButton(
          onPressed: isDisabled ? null : onPressed,
          icon: Icon(icon, color: isDisabled ? Colors.grey : Colors.white),
          iconSize: 18,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ),
    );
  }
}
