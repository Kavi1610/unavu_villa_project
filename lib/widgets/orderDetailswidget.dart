import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_icon.dart';
import 'package:unavu_villa_project/core/appdimention.dart';
import 'package:unavu_villa_project/models/getMenuItem.dart';
import 'package:unavu_villa_project/models/menuItem.dart';
import 'package:unavu_villa_project/models/takeOrderModel.dart';
import 'package:unavu_villa_project/viewmodels/menuController.dart';
import 'package:unavu_villa_project/widgets/userInformation.dart';

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
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: AppColors.iconColor,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        suffixText: "%",
                        suffixStyle: GoogleFonts.dmSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Write your order note here...",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                        hintStyle: GoogleFonts.dmSans(
                            fontSize: 12, color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColors.textFiled, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColors.textFiled, width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: AppColors.textFiled, width: 1),
                        ),
                      ),
                      onChanged: (value) {
                        menuController.orderNoteValue(value);
                      },
                      maxLines: 2,
                    ),
                  ),

                  Divider(),

                  // Pricing Details
                  Obx(() => totalRow(
                      title: 'Total Amount',
                      value:
                          '\₹.${menuController.subTotal.toStringAsFixed(2)}')),
                  SizedBox(
                    height: 4,
                  ),
                  Obx(() => totalRow(
                      title: 'Tax (10%)',
                      value: '\₹.${menuController.tax.toStringAsFixed(2)}')),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Discount",
                          style: GoogleFonts.dmSans(
                              fontSize: 14, color: Colors.grey)),
                      SizedBox(
                        height: 30,
                        width: 90, // Adjust the width as needed
                        child: TextField(
                          controller: menuController.discountController,
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            color: AppColors.iconColor,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            suffixText: "%",
                            suffixStyle: GoogleFonts.dmSans(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            hintStyle: GoogleFonts.dmSans(
                                fontSize: 12, color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: AppColors.textFiled, width: 1),
                            ),
                          ),
                          onChanged: (value) {
                            menuController.updateDiscount(value);
                          },
                        ),
                      )
                    ],
                  ),
                  totalRow(
                      title: 'Discount Amount',
                      value:
                          '\₹.${menuController.discountAmountall.toStringAsFixed(2)}'),
                  SizedBox(
                    height: 4,
                  ), // Placeholder for discount
                  Obx(() => totalRow(
                      title: 'Round off',
                      value: '\₹.${menuController.roundOff.toStringAsFixed(2)}',
                      isHighlighted: true)),
                  SizedBox(
                    height: 4,
                  ),
                  Obx(() => totalRow(
                      title: 'Grand Total',
                      value: '\₹.${menuController.total.toStringAsFixed(2)}',
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
                Obx(() {
                  // Parse item.price to double
                  double itemPrice = double.tryParse(item.price) ??
                      0.0; // Default to 0.0 if parsing fails
                  int quantity = menuController.itemQuantities[item] ??
                      0; // Get the quantity, default to 0 if not found

                  // Calculate the total price
                  double totalPrice = itemPrice * quantity;

                  // Format the total price as a string with two decimal places
                  String formattedPrice = "\₹.${totalPrice.toStringAsFixed(2)}";

                  return Text(
                    formattedPrice,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.orange,
                    ),
                  );
                }),
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
