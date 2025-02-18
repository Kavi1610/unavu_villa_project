import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_icon.dart';
import 'package:unavu_villa_project/core/appdimention.dart';
import 'package:unavu_villa_project/models/getMenuItem.dart';
import 'package:unavu_villa_project/models/menuItem.dart';
import 'package:unavu_villa_project/viewmodels/menuController.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItem item;

  const MenuItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(AppIcons.productImage,
                height: AppDimensions.screenHeight / 9,
                fit: BoxFit.cover,
                width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 6, top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppDimensions.screenWidth / 4.9,
                      child: Text(
                        item.itemname,
                        style: GoogleFonts.dmSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "\₹.${item.price}",
                          style: GoogleFonts.dmSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0XFFF67F20)),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.circle,
                            color: item.itemtype == 'V'
                                ? Color(0XFF20F639)
                                : Color(0XFFF62020),
                            size: 10),
                        Text(
                          item.itemtype == 'V' ? " Veg" : " Non Veg",
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: item.itemtype == 'V'
                                ? Color(0XFF20F639)
                                : Color(0XFFF62020),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      final menuController = Get.find<FoodMenuController>();
                      menuController.addToCart(item); // Add item to cart
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.all(8),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
