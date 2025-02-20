import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/enums.dart';
import 'package:unavu_villa_project/models/order_list_response_model.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';
import 'package:unavu_villa_project/widgets/order_itemRow.dart';
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
        final double fontSizeHeader = screenWidth * 0.04;
        final double fontSizeBody = screenWidth * 0.035;

        return Card(
          color: Colors.white,
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
          child: SingleChildScrollView(
            // Ensure scrollable content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              fontSize: fontSizeHeader,
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
                              'Table Number',
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: fontSizeHeader,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              'Dine-in',
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: fontSizeHeader,
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
                          fontSize: fontSizeHeader,
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
                          fontSize: fontSizeBody,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'To: ${Jiffy.parse(order.createdAt!, pattern: "yyyy-MM-ddThh:mm:ssZ").format(pattern: "hh:mm a")}',
                        style: GoogleFonts.dmSans(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: fontSizeBody,
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
                                  fontWeight: FontWeight.w400,
                                  fontSize: fontSizeBody,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.05),
                              Text(
                                'Food Name',
                                style: GoogleFonts.dmSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: fontSizeBody,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Actions',
                            style: GoogleFonts.dmSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: fontSizeBody,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.004),
                      ...order.items!.map((item) => OrderItemRow(
                            item: item,
                            orderId: item.id.toString(),
                            index: order.items!.indexOf(item),
                            onMarkDelivered: controller.markItemAsDelivered,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Divider(color: Colors.grey.shade400),
                ),
                Padding(
                    padding: EdgeInsets.all(padding),
                    child: Visibility(
                      visible: order.status == 0,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () =>
                                  controller.cancelOrder(order.id.toString()),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: isMobile ? 12 : 16),
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
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: InkWell(
                              onTap: () =>
                                  controller.cancelOrder(order.id!.toString()),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: isMobile ? 12 : 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFF2E6E76),
                                ),
                                child: Center(
                                  child: Text(
                                    'Pay Bill',
                                    style: GoogleFonts.dmSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
          ),
        );
      },
    );
  }
}
