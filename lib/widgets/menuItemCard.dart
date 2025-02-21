import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
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
    return InkWell(
      onTap: () {
        final menuController = Get.find<FoodMenuController>();
        menuController.addToCart(item);
      },
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(AppIcons.productImage,
                  height: AppDimensions.screenHeight / 7,
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
                        width: AppDimensions.screenWidth / 7.5,
                        child: Text(
                          item.itemname,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow
                              .ellipsis, // This will apply the ellipsis
                          maxLines: 1, // Limit to one line
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "\₹.${item.price}",
                            style: GoogleFonts.dmSans(
                                fontSize: 14,
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
                              fontWeight: FontWeight.w500,
                              color: item.itemtype == 'V'
                                  ? Color(0XFF20F639)
                                  : Color(0XFFF62020),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 28,
                    width: 28,
                    margin: EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.orange,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
