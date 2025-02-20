import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/enums.dart';
import 'package:unavu_villa_project/models/addItempayDetail_model.dart';
import 'package:unavu_villa_project/models/order_list_response_model.dart';
import 'package:unavu_villa_project/models/paybill_model.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';
import 'package:unavu_villa_project/viewmodels/menuController.dart';
import 'package:unavu_villa_project/widgets/order_itemRow.dart';
import 'package:unavu_villa_project/widgets/payment_widget.dart';
import '../models/orderDetaul.dart';
import 'package:jiffy/jiffy.dart';

class OrderCard extends StatelessWidget {
  final Items order;

  OrderCard({Key? key, required this.order}) : super(key: key);

  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    controller.updateDeviceType(context);
    final isMobile = controller.deviceType.value == DeviceType.mobile;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        final double padding = screenWidth * 0.04;
        //final double fontSizeHeader = screenWidth * 0.04;
        //final double fontSizeBody = screenWidth * 0.035;

        return Card(
          color: Colors.white,
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: order.status == 0
                      ? Colors.amber
                      : (order.status == 1 || order.status == 4)
                          ? Colors.green
                          : Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: isMobile ? 50 : 70,
                      width: isMobile ? 50 : 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          '${order.tableid ?? "-"}',
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: order.status == 0
                                ? Colors.amber
                                : (order.status == 1 || order.status == 4)
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${order.orderid ?? "-"}',
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            'Dine-in',
                            style: GoogleFonts.dmSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      Jiffy.parse(order.createdAt!,
                              pattern: "yyyy-MM-ddThh:mm:ssZ")
                          .format(pattern: "dd/MM/yyyy"),
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  children: [
                    Text(
                      'From: ${Jiffy.parse(order.createdAt!, pattern: "yyyy-MM-ddThh:mm:ssZ").format(pattern: "hh:mm a")}',
                      style: GoogleFonts.dmSans(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'To: ${Jiffy.parse(order.items![order.items!.length - 1].updatedAt!, pattern: "yyyy-MM-ddThh:mm:ssZ").format(pattern: "hh:mm a")}',
                      style: GoogleFonts.dmSans(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Divider(color: Colors.grey.shade400),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Qty',
                              style: GoogleFonts.dmSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            Text(
                              'Food Name',
                              style: GoogleFonts.dmSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Actions',
                          style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.004),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: order.items!.length,
                      itemBuilder: (context, index) {
                        final item = order.items![index];
                        return OrderItemRow(
                          item: item,
                          orderId: order.id.toString(),
                          index: index,
                          onMarkDelivered: controller.markItemAsDelivered,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Divider(color: Colors.grey.shade400),
              ),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child:
                      // order.status == 0
                      //     ?
                      Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.onAdditemSelected(true);
                          // InvoicePay payBill = InvoicePay(
                          //   totalAmount: subTotal(),
                          //   discountAmount: order.discountamount,
                          //   grandTotal: order.totalamount,
                          //   roundOff: roundOff(order.discountamount),
                          //   tax: tax(),
                          // );
                          // controller.addItemBill(payBill);
                          Get.toNamed('/addorder');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: isMobile ? 10 : 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: order.status == 1
                                ? Colors.green
                                : order.status == 2
                                    ? Colors.amber
                                    : Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              'Add Items',
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          final Map<String, dynamic> requestBody = {
                            "email": order.email ?? "",
                            "tableid": int.tryParse(
                                    order.tableid?.toString() ?? '0') ??
                                0, // Prevent errors
                            "orderid": int.tryParse(
                                    order.orderid?.toString() ?? '0') ??
                                0,
                            "status": 2,
                            "updated_at": order.updatedAt ??
                                DateTime.now().toIso8601String(),
                            "branchid": int.tryParse(
                                    order.branchid?.toString() ?? '0') ??
                                0,
                            "location": order.location ?? "",
                            "ordertype": int.tryParse(
                                    order.ordertype?.toString() ?? '0') ??
                                0,
                            "floorid": int.tryParse(
                                    order.floorid?.toString() ?? '0') ??
                                0,
                            "address": order.address ?? "",
                            "deleted_at": order.deletedAt?.toString() ??
                                null, // Keep null if needed
                            "numberofpeople": order.numberofpeople
                                .toString(), // Convert to string explicitly
                            "printerid": 0,
                            "customerGSTIN": order.customerGSTIN ?? "",
                            "is_deleted": order.isDeleted ?? false,
                            "discountamount": double.tryParse(
                                    order.discountamount?.toString() ??
                                        '0.0') ??
                                0.0,
                            "captainname": order.captainname ?? "",
                            "order_by": int.tryParse(
                                    order.orderBy?.toString() ?? '0') ??
                                0,
                            "paymentmethod": 0,
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
                            "id":
                                int.tryParse(order.id?.toString() ?? '0') ?? 0,
                            "billno": order.billno?.toString() ?? "",
                            "created_at": order.createdAt ??
                                DateTime.now().toIso8601String(),
                          };

                          controller.cancelBillload(requestBody);

                          controller.cancelOrder(order.id.toString());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: isMobile ? 10 : 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              'Cancel   ',
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.dialog(OrderPaymentPage(order: order));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 13, vertical: isMobile ? 10 : 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF2E6E76),
                          ),
                          child: Center(
                            child: Text(
                              'Pay Bill ',
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  // : order.status == 2
                  //     ? Expanded(
                  //         child: InkWell(
                  //           onTap: () => controller
                  //               .cancelOrder(order.id!.toString()),
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(
                  //                 vertical: isMobile ? 12 : 21),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: Color(0XFFD0A127),
                  //             ),
                  //             child: Center(
                  //               child: Text(
                  //                 'Order Cancelled',
                  //                 style: GoogleFonts.dmSans(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.w600,
                  //                   fontSize: 16,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : Expanded(
                  //         child: InkWell(
                  //           onTap: () => controller
                  //               .cancelOrder(order.id!.toString()),
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(
                  //                 vertical: isMobile ? 12 : 21),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: Color(0XFF2D62B5),
                  //             ),
                  //             child: Center(
                  //               child: Text(
                  //                 'Order Completed',
                  //                 style: GoogleFonts.dmSans(
                  //                   color: Colors.white,
                  //                   fontWeight: FontWeight.w600,
                  //                   fontSize: 16,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  // )
                  ),
            ],
          ),
        );
      },
    );
  }

  double tax() {
    return order.items!.fold(0.0, (sum, item) {
      //if (item.isChecked.value) return sum; // ✅ Skip unchecked items

      try {
        // Assuming item.dineintax is a string like "TAX_5"
        String taxRateString =
            item.taxType ?? ''; // Default to empty string if null
        double taxRate = 0.0;

        // Extract the numeric part of the tax rate
        if (taxRateString.startsWith("TAX_")) {
          String rateString =
              taxRateString.substring(4); // Get the part after "TAX_"
          taxRate = double.tryParse(rateString) ??
              0.0; // Convert to double, default to 0.0 if parsing fails
        }

        // Safely parse item.price
        double itemPrice = double.tryParse(item.price) ??
            0.0; // Default to 0.0 if parsing fails
        int quantity =
            int.parse(item.quantity) ?? 1; // Default to 1 if not found

        // Calculate the tax based on the extracted rate and item price
        double itemTax = itemPrice * (taxRate / 100) * quantity;

        // Add the individual item tax to the total sum
        return sum + itemTax;
      } catch (e) {
        print("Error calculating tax for item ${item.itemname}: $e");
        return sum; // Return sum unchanged in case of error
      }
    });
  }

  double subTotal() {
    return order.items!.fold(0.0, (sum, item) {
      //if (item.isChecked.value) return sum; // ✅ Skip unchecked items

      // Ensure item.price is a valid number
      double itemPrice =
          double.tryParse(item.price) ?? 0.0; // Default to 0.0 if parsing fails
      int quantity = int.parse(item.quantity) ?? 1; // Default to 1 if not found

      return sum + (itemPrice * quantity);
    });
  }

  double roundOff(double disValue) {
    return (subTotal() + tax() - disValue) -
        (subTotal() + tax() - disValue).floor();
  }
}
