import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/appdimention.dart';
import 'package:unavu_villa_project/models/takeOrderModel.dart';
import 'package:unavu_villa_project/viewmodels/login_viewmodel.dart';
import 'package:unavu_villa_project/viewmodels/menuController.dart';

class UserInformation extends StatelessWidget {
  // Create TextEditingControllers for each input field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final FoodMenuController menuController = Get.find<FoodMenuController>();
  final LoginViewModel logmenuController = Get.find<LoginViewModel>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.screenWidth * 0.3,
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

            // Full Name
            _buildTextField("Full name", nameController, "Enter name"),
            // Space between TextField and error message

            Obx(() {
              return Text(
                menuController.nameErrorText.value,
                style: TextStyle(color: Colors.red, fontSize: 12),
              );
            }),
            SizedBox(height: 10),

            // Phone Number
            _buildTextField(
                "Phone number", phoneController, "Enter customer phone number"),
            SizedBox(height: 10),

            // Address
            _buildTextField(
                "Address", addressController, "Enter customer address"),
            SizedBox(height: 10),

            // GST Number
            _buildTextField("GST Number", gstController, "Enter GST number"),
            SizedBox(height: 20),
            Divider(),

            // Subtotal, Tax, Total
            _buildOrderSummary(),

            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Validate name
                menuController.checkErrorMessage(nameController.text);

                // Check if there are any errors
                if (menuController.nameErrorText.value.isEmpty) {
                  // Create a list to hold order items
                  List<OrderItemModel> orderItem = [];

                  // Populate the orderItem list from cartItems
                  for (var cartItem in menuController.cartItems) {
                    orderItem.add(OrderItemModel(
                      itemcode: cartItem.id,
                      itemname: cartItem.itemname,
                      quantity: menuController.itemQuantities[cartItem] ?? 1,
                      price: double.tryParse(cartItem.price) ??
                          0.0, // Use tryParse
                      total: (double.tryParse(cartItem.price) ?? 0.0) *
                          (menuController.itemQuantities[cartItem] ?? 1),
                      comp: cartItem.isChecked.value == false ? false : true,
                      isDeleted: false,
                      status: 0,
                      statustime: 0,
                      tax_type: cartItem.dineintax,
                    ));
                  }

                  // Create the order request using values from the controllers
                  // Create the order request using values from the controllers
                  OrderModel orderRequest = OrderModel(
                    address: addressController.text,
                    ordertype: 0,
                    status: 0,
                    tableid: int.tryParse(menuController.selectTableId.value) ??
                        0, // Use tryParse
                    numberofpeople: menuController.countNumberPeople.value
                        .toString(), // Ensure this is a String
                    captainname: logmenuController.captainName.value.isNotEmpty
                        ? logmenuController.waiterName.value
                        : "",
                    waitername: logmenuController.waiterName.value.isNotEmpty
                        ? logmenuController.waiterName.value
                        : "",
                    customername: nameController.text,
                    customermobile: phoneController.text,
                    email: "", // You can also use a controller for this
                    location: "",
                    customerGSTIN: gstController.text,
                    knotes: menuController.orderNote.value,
                    items: orderItem,
                    orderBy: int.tryParse(
                            logmenuController.captainID.value.toString()) ??
                        0, // Use .value
                    paymentMethod: 0,
                    branchid: 101,
                    discountamount:
                        menuController.discountAmountall, // Use .value
                    floorid: int.tryParse(logmenuController
                            .selectedBranchId.value
                            .toString()) ??
                        0, // Use .value
                    grandtotal: menuController.total, // Use .value
                    printerid: 0,
                    totalamount: menuController.subTotal, // Use .value
                  );

                  // Call the createOrder method
                  menuController.createOrder(orderRequest);
                  menuController.takeOrderNow(false);
                }
              },
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
            // SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Color(0XFFFFF5EE),
            //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 44),
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(58)),
            //   ),
            //   child: Center(
            //     child: Text(
            //       "Verify KOT",
            //       style: GoogleFonts.dmSans(
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //           color: AppColors.orange),
            //     ),
            //   ),
            // ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                menuController.cartItems.clear();
                menuController.showAlertDialogOrderCancel();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFFFFFFFF),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 44),
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: AppColors.orange),
                    borderRadius: BorderRadius.circular(58)),
              ),
              child: Center(
                child: Text(
                  "Cancel",
                  style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.orange),
                ),
              ),
            ),
            // Other buttons...
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(
      String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.dmSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.iconColor),
        ),
        SizedBox(height: 4),
        TextField(
          controller: controller,
          onChanged: (value) {
            if (controller == nameController) {
              menuController.checkErrorMessage(value);
            } else {
              null;
            }
          },
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.iconColor,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0XFFC2C2C2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.textFiled, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: controller == nameController
                      ? menuController.nameErrorText.value.isEmpty
                          ? AppColors.errorText
                          : AppColors.textFiled
                      : AppColors.textFiled,
                  width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.textFiled, width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.textFiled, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  // Method to build order summary
  Widget _buildOrderSummary() {
    return Column(
      children: [
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
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tax ",
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
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Discount",
                style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.iconColor)),
            Text('\$${menuController.discountAmountall.toStringAsFixed(2)}',
                style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF19191C))),
          ],
        ),
        SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total",
                style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.iconColor)),
            Text('\$${menuController.total.toStringAsFixed(2)}',
                style: GoogleFonts.dmSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.orange)),
          ],
        ),
      ],
    );
  }
}
