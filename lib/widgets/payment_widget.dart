import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';
import 'package:unavu_villa_project/models/order_list_response_model.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';

class OrderPaymentPage extends StatelessWidget {
  final Items order;
  final DashboardController controller = Get.find<DashboardController>();

  OrderPaymentPage({super.key, required this.order});

  final TextEditingController amountController = TextEditingController();
  final List<String> paymentMethods = [
    "assets/Iconcash.png",
    "assets/Iconmaster.png",
    "assets/Visa credit card.png",
    "assets/Icongift.png"
  ];

  int selectedIndex = 0;
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
        child: SingleChildScrollView(
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
                      fontSize: isTablet ? 16 : 14,
                      fontWeight: FontWeight.w600),
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
                          : controller.selectedPrinter.value,
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
                        controller.selectedPrinter.value = newValue!;
                      },
                    ),
                  ),
                );
              }),

              SizedBox(height: 16),

              // Action Buttons (Fixed)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final Map<String, dynamic> requestBody = {
                          "email": order.email ?? "",
                          "tableid":
                              int.tryParse(order.tableid?.toString() ?? '0') ??
                                  0, // Prevent errors
                          "orderid":
                              int.tryParse(order.orderid?.toString() ?? '0') ??
                                  0,
                          "status": 4,
                          "updated_at": order.updatedAt ??
                              DateTime.now().toIso8601String(),
                          "branchid":
                              int.tryParse(order.branchid?.toString() ?? '0') ??
                                  0,
                          "location": order.location ?? "",
                          "ordertype": int.tryParse(
                                  order.ordertype?.toString() ?? '0') ??
                              0,
                          "floorid":
                              int.tryParse(order.floorid?.toString() ?? '0') ??
                                  0,
                          "address": order.address ?? "",
                          "deleted_at": order.deletedAt?.toString() ??
                              "", // Keep null if needed
                          "numberofpeople": order.numberofpeople
                              .toString(), // Convert to string explicitly
                          "printerid": 1,
                          "customerGSTIN": order.customerGSTIN ?? "",
                          "is_deleted": order.isDeleted ?? false,
                          "discountamount": double.tryParse(
                                  order.discountamount?.toString() ?? '0.0') ??
                              0.0,
                          "captainname": order.captainname ?? "",
                          "order_by":
                              int.tryParse(order.orderBy?.toString() ?? '0') ??
                                  0,
                          "paymentmethod": int.parse(
                              controller.paymentMode.value.toString()),
                          "totalamount": double.tryParse(
                                  order.totalamount?.toString() ?? '0.0') ??
                              0.0,
                          "waitername": order.waitername ?? "",
                          "customername": order.customername ?? "",
                          "grandtotal": double.tryParse(
                                  order.grandtotal?.toString() ?? '0.0') ??
                              0.0,
                          "knotes": order.knotes ?? "",
                          "customermobile": order.customemobile ??
                              "", // Fixed typo from 'customemobile'
                          "id": int.tryParse(order.id?.toString() ?? '0') ?? 0,
                          "billno": order.billno?.toString() ?? "",
                          "created_at": order.createdAt ??
                              DateTime.now().toIso8601String(),
                        };
                        controller.generateBillload(requestBody);
                      },
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
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
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
        childAspectRatio: 3.5,
      ),
      itemBuilder: (context, index) {
        return Obx(
          () => InkWell(
              onTap: () {
                controller.addPaymentMode(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.paymentMode.value == index
                          ? Colors.orange
                          : Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: isTablet ? 12 : 8),
                child: Center(
                  child: Image.asset(paymentMethods[index],
                      height: isTablet ? 40 : 30),
                ),
              )),
        );
      },
    );
  }
}
