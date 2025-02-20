import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/enums.dart';
import 'package:unavu_villa_project/models/order_list_response_model.dart';
import 'package:unavu_villa_project/models/paybill_model.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';
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
                        onTap: () {},
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
                          Bill bill = Bill(
                            address: order.address!,
                            branchId: order.branchid!,
                            captainName: order.captainname!,
                            createdAt: order.createdAt!,
                            customerMobile: order.customemobile!,
                            customerName: order.customername!,
                            discountAmount: order.discountamount!,
                            floorId: order.floorid!,
                            grandTotal: order.grandtotal!,
                            id: order.id!,
                            isDeleted: order.isDeleted!,
                            location: order.location!,
                            numberOfPeople: order.numberofpeople!,
                            orderBy: order.orderBy!,
                            orderId: order.orderid!,
                            orderType: order.ordertype!,
                            paymentMethod: 0,
                            printerId: 0,
                            status: 2,
                            tableId: order.tableid!,
                            totalAmount: order.totalamount!,
                            updatedAt: order.updatedAt!,
                            waiterName: order.waitername!,
                            billNo: order.billno!,
                            customerGSTIN: order.customerGSTIN!,
                            deletedAt: order.deletedAt!,
                            email: order.email!,
                            notes: order.knotes!,
                          );
                          controller.cancelBillload(bill);

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
                          Bill bill = Bill(
                            address: order.address!,
                            branchId: order.branchid!,
                            captainName: order.captainname!,
                            createdAt: order.createdAt!,
                            customerMobile: order.customemobile!,
                            customerName: order.customername!,
                            discountAmount: order.discountamount!,
                            floorId: order.floorid!,
                            grandTotal: order.grandtotal!,
                            id: order.id!,
                            isDeleted: order.isDeleted!,
                            location: order.location!,
                            numberOfPeople: order.numberofpeople!,
                            orderBy: order.orderBy!,
                            orderId: order.orderid!,
                            orderType: order.ordertype!,
                            paymentMethod: 0,
                            printerId: 1,
                            status: 4,
                            tableId: order.tableid!,
                            totalAmount: order.totalamount!,
                            updatedAt: order.updatedAt!,
                            waiterName: order.waitername!,
                            billNo: order.billno!,
                            customerGSTIN: order.customerGSTIN!,
                            deletedAt: order.deletedAt!,
                            email: order.email!,
                            notes: order.knotes!,
                          );
                          Get.dialog(OrderPaymentPage(bills: bill));
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
}
