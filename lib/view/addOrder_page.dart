// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_icon.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';
import 'package:unavu_villa_project/core/appdimention.dart';
import 'package:unavu_villa_project/models/getMenuItem.dart';
import 'package:unavu_villa_project/models/get_table-Model.dart';
import 'package:unavu_villa_project/models/menu_catagory_list_%20model.dart';
import 'package:unavu_villa_project/viewmodels/add_orderButton_Controller.dart';
import 'package:unavu_villa_project/viewmodels/dashboardController.dart';
import 'package:unavu_villa_project/viewmodels/menuController.dart';
import 'package:unavu_villa_project/widgets/dashboard_appbar.dart';
import 'package:unavu_villa_project/widgets/filterchips.dart';
import 'package:unavu_villa_project/widgets/menuItemCard.dart';
import 'package:unavu_villa_project/widgets/menu_button.dart';
import 'package:unavu_villa_project/widgets/orderDetailswidget.dart';

class AddOrderWidget extends StatefulWidget {
  const AddOrderWidget({super.key});

  @override
  _AddOrderWidgetState createState() => _AddOrderWidgetState();
}

class _AddOrderWidgetState extends State<AddOrderWidget> {
  String selectedCategory = 'Coffee';
  ButtonController buttonController = Get.put(ButtonController());
  final FoodMenuController menuController = Get.put(FoodMenuController());
  final DashboardController dashboardController =
      Get.find<DashboardController>();

  @override
  void initState() {
    super.initState();
    if (!dashboardController.addItemcheck.value) {
      Future.delayed(Duration.zero, () {
        showAlert();
      });
    }
  }

  void showAlert() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: SizedBox(
          height: AppDimensions.screenHeight / 3.3,
          width: AppDimensions.screenWidth / 2.5,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Table Details",
                    style: AppTextStyles.heading.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF19191c)),
                  ),
                  InkWell(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.close,
                        size: 21,
                      ))
                ],
              ),
              SizedBox(height: 6),
              Divider(height: 0),
              SizedBox(height: 18),
              alertdialogcontent(title: "Select Table", isiconneed: true),
              SizedBox(height: 18),
              alertdialogcontent(title: "Number of people", isiconneed: false),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        side: BorderSide(color: AppColors.orange),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
                    child: Text(
                      "Cancel",
                      style: AppTextStyles.heading.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.orange,
                      ),
                    ),
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      ),
                      child: Text("Add Items",
                          style: AppTextStyles.heading.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.screenbackground,
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Prevents closing by tapping outside
    );
  }

  Container alertdialogcontent({title, isiconneed = false}) {
    return Container(
        height: 48,
        width: AppDimensions.screenWidth / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.grey.shade400,
            )),
        child: isiconneed
            ? Obx(() => Container(
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
                        "Select Table",
                        style: AppTextStyles.heading.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFFC2C2C2),
                        ),
                      ),
                      value: menuController.selectTableId.value.isEmpty
                          ? null
                          : menuController.selectTableId.value,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      underline: SizedBox(),
                      dropdownColor: Colors.white,
                      items: menuController.BranchtableDataList.map<
                          DropdownMenuItem<String>>((TableItem item) {
                        return DropdownMenuItem<String>(
                          value: item.id.toString(),
                          child: Text(
                            item.tableId ?? "Unknown",
                            style: AppTextStyles.heading.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          final selectedItem =
                              menuController.BranchtableDataList.firstWhere(
                            (item) => item.id.toString() == newValue,
                            orElse: () => TableItem(id: 0, tableId: ""),
                          );

                          if (selectedItem.id != 0) {
                            menuController.selectTableId.value = newValue;
                            menuController.selectTable.value =
                                selectedItem.tableId ?? "";
                          }
                        }
                      },
                    ),
                  ),
                ))
            : TextField(
                controller:
                    TextEditingController(text: menuController.inputText.value),
                keyboardType: TextInputType.number,
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  color: AppColors.iconColor,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "Enter People Number",
                  hintStyle: AppTextStyles.heading.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFFC2C2C2),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 8, left: 21),
                ),
                onChanged: (value) {
                  int? number = int.tryParse(value);
                  menuController.countNumberPeople.value = value.toString();
                  if (number != null && (number < 1 || number > 10)) {
                    menuController.showAlertDialog();
                    menuController.inputText.value = '';
                  }
                },
              ));
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery.of(context).size.width < 600; // Adjust threshold as needed
    Size screensize = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;

    double height = isMobile ? 50 : 60; // Adjusted for better sizing
    double iconSize = isMobile ? 20 : 24;

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: DashboardAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: height,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                          right: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, size: iconSize, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search order by number...',
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0XFF9E9E9E),
                              ),
                            ),
                            onChanged: (value) {
                              menuController.searchQuery.value = value;
                              if (value.length > 2) {
                                menuController.loadFilterMenuSearch(value);
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.filter_list,
                            size: iconSize, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: isMobile ? 50 : 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(color: AppColors.borderclr)),
                    ),
                    child: FilterChips(
                      isTablet: true,
                      isfromaddOrderScreen: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: isMobile ? 60 : AppDimensions.screenWidth / 8,
                  child: Obx(() {
                    return sideMenuWidget(menuController.menuCatagoryItem);
                  }),
                ),
                SizedBox(width: 3),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Suggestion menu',
                          style: AppTextStyles.heading.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(() {
                          if (menuController.isLoading.value) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (menuController.menuItems.isEmpty) {
                            return Center(child: Text("No items available"));
                          }

                          return Container(
                            decoration: BoxDecoration(
                              color: Color(0XFFDDDDDD).withOpacity(0.1),
                              border: Border(
                                  right: BorderSide(
                                      color: AppColors.borderclr, width: 1)),
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: menuController.menuItems.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: isMobile ? 2 : 3,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 9,
                                childAspectRatio: 1.99 / 2,
                              ),
                              itemBuilder: (context, index) {
                                var item = menuController.menuItems[index];
                                return MenuItemCard(item: item);
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 3),
                Divider(color: AppColors.borderclr),
                SizedBox(
                  width: isMobile
                      ? screensize.width * 0.3
                      : screensize.width * 0.25,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: OrderDetailsWidget(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container orderDetailsWidget(Size screensize) {
    return Container(
      height: double.infinity,
      width: MediaQuery.sizeOf(context).width / 3,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Details',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Obx(() => Column(
                    children: menuController.cartItems
                        .map((item) => CartItem(item))
                        .toList(),
                  )),
              Divider(),
              Obx(() => total(
                  title: 'Sub Total',
                  value: '\$${menuController.subTotal.toStringAsFixed(2)}')),
              Obx(() => total(
                  title: 'Tax (10%)',
                  value: '\$${menuController.tax.toStringAsFixed(2)}')),
              Obx(() => total(
                  title: 'Total',
                  value: '\$${menuController.total.toStringAsFixed(2)}',
                  istotal: true)),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () => print("Order Placed!"),
                  child:
                      Text("Order Now", style: TextStyle(color: Colors.white)),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row total({title, value, bool istotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey),
        ),
        Text(value,
            style: TextStyle(
                color: istotal ? AppColors.primary : Colors.black,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget CartItem(MenuItem item) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Container(
            height: 74,
            width: 74,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(AppIcons.productImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.itemname,
                    style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 4),
                Text("Price ",
                    style: GoogleFonts.dmSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textFiled)),
                Text("\$${item.price}",
                    style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orange)),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.textFiled1,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () => menuController.decrement(item),
                    icon: Icon(Icons.remove, color: Color(0XFF9C9C9C)),
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
              ),
              SizedBox(width: 6),
              Obx(() => Text(
                    menuController.itemQuantities[item]?.toString() ?? "0",
                    style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              SizedBox(width: 6),
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.textFiled1,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () => menuController.increment(item),
                    icon: Icon(Icons.add, color: Colors.white),
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container sideMenuWidget(List<MenuCategory> menuCategory) {
    final DashboardController dashcontroller = Get.find<DashboardController>();
    return Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          border:
              Border(right: BorderSide(color: AppColors.borderclr, width: 1)),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.all(6),
          itemCount: menuCategory.length,
          separatorBuilder: (context, index) => SizedBox(height: 6),
          itemBuilder: (context, index) {
            final category = menuCategory[index];
            return Obx(() => CategoryIcon(
                  text: category.name,
                  selected:
                      menuController.selectedCategory.value == category.name,
                  onTap: () {
                    dashcontroller.onCategorySelected(category.name);
                    menuController.loadFilterMenuItems(
                        dashcontroller.selectedFiltermenu.value, category.name);
                    menuController.selectedCategory.value = category.name;
                  },
                ));
          },
        ));
  }
}
