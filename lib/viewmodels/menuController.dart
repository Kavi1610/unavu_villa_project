import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/core/app_icon.dart';
import 'package:unavu_villa_project/models/menuItem.dart';

class FoodMenuController extends GetxController {
  var menuItems = <MenuItem>[].obs;
  var cartItems = <MenuItem>[].obs;
  var itemQuantities = <MenuItem, int>{}.obs;
  var takeOrder = false.obs;

  double get subTotal => cartItems.fold(
      0, (sum, item) => sum + (item.price * (itemQuantities[item] ?? 1)));

  double get tax => subTotal * 0.10; // 10% GST
  double get roundOff => (subTotal + tax) - (subTotal + tax).floor();
  double get total => (subTotal + tax).floor().toDouble();

  // Function to add item to cart
  void addToCart(MenuItem item) {
    if (itemQuantities.containsKey(item)) {
      itemQuantities.update(item, (value) => value + 1);
    } else {
      cartItems.add(item);
      itemQuantities[item] = 1;
    }
    update();
  }

  // Increment quantity
  void increment(MenuItem item) {
    itemQuantities.update(item, (value) => value + 1, ifAbsent: () => 1);
    update();
  }

  // Decrement quantity
  void decrement(MenuItem item) {
    if (itemQuantities.containsKey(item) && itemQuantities[item]! > 1) {
      itemQuantities.update(item, (value) => value - 1);
    } else {
      cartItems.remove(item);
      itemQuantities.remove(item);
    }
    update();
  }

  void takeOrderNow() {
    takeOrder.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    loadMenuItems();
  }

  void loadMenuItems() {
    menuItems.addAll([
      MenuItem(
          title: "Grill Sandwich",
          imageUrl: AppIcons.productImage,
          price: 30.00,
          isVeg: true),
      MenuItem(
          title: "Chicken Burger",
          imageUrl: AppIcons.productImage,
          price: 50.00,
          isVeg: false),
      MenuItem(
          title: "Paneer Wrap",
          imageUrl: AppIcons.productImage,
          price: 40.00,
          isVeg: true),
      MenuItem(
          title: "Cheese Pizza",
          imageUrl: AppIcons.productImage,
          price: 80.00,
          isVeg: true),
      MenuItem(
          title: "Chicken Pizza",
          imageUrl: AppIcons.productImage,
          price: 90.00,
          isVeg: false),
      MenuItem(
          title: "Veg Biryani",
          imageUrl: AppIcons.productImage,
          price: 70.00,
          isVeg: true),
      MenuItem(
          title: "Chicken Biryani",
          imageUrl: AppIcons.productImage,
          price: 120.00,
          isVeg: false),
    ]);
  }
}
