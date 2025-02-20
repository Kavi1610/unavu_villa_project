import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';
import 'package:unavu_villa_project/models/getMenuItem.dart';
import 'package:unavu_villa_project/models/get_table-Model.dart';
import 'package:unavu_villa_project/models/menuItem.dart';
import 'package:unavu_villa_project/models/menu_catagory_list_%20model.dart';
import 'package:unavu_villa_project/models/takeOrderModel.dart';
import 'package:unavu_villa_project/provider/getMenuProvider.dart';
import 'package:unavu_villa_project/provider/get_catagory_filter_item.dart';
import 'package:unavu_villa_project/provider/get_menu_item_provider.dart';
import 'package:unavu_villa_project/provider/get_table_data_provider.dart';
import 'package:unavu_villa_project/provider/orderTake_provider.dart';
import 'package:unavu_villa_project/provider/search_menu_provider.dart';

class FoodMenuController extends GetxController {
  RxList menuItems = <MenuItem>[].obs;
  RxList cartItems = <MenuItem>[].obs;
  var menuCatagoryItem = <MenuCategory>[].obs;
  var itemQuantities = <MenuItem, int>{}.obs;
  RxList orderItem = <OrderItemModel>[].obs;
  var takeOrder = false.obs;
  RxString searchQuery = ''.obs;
  var isLoading = true.obs;
  RxString orderNote = ''.obs;
  RxString selectedCategory = ''.obs;
  final RxString inputText = ''.obs;
  RxString selectTable = ''.obs;
  RxString selectTableId = ''.obs;
  var BranchtableDataList = <TableItem>[].obs;
  var nameErrorText = ''.obs;
  var discountController = TextEditingController();
  var discountPercentage = 0.0.obs;
  var discountAmount = 0.0.obs;
  var countNumberPeople = ''.obs;
  List<String> tableDataList = ["Option 1", "Option 2", "Option 3"];
  double get subTotal {
    return cartItems.fold(0.0, (sum, item) {
      // Ensure item.price is a valid number
      double itemPrice =
          double.tryParse(item.price) ?? 0.0; // Default to 0.0 if parsing fails
      int quantity = itemQuantities[item] ?? 1; // Default to 1 if not found
      return sum + (itemPrice * quantity);
    });
  }

  double get tax {
    return cartItems.fold(0.0, (sum, item) {
      try {
        // Assuming item.dineintax is a string like "TAX_5"
        String taxRateString =
            item.dineintax ?? ''; // Default to empty string if null
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
        int quantity = itemQuantities[item] ?? 1; // Default to 1 if not found

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

  // Discount //
  void updateDiscount(String value) {
    double parsedValue = double.tryParse(value) ?? 0.0;
    discountPercentage.value =
        parsedValue.clamp(0, 100); // Ensure valid percentage
    update(); // Update UI
  }

  double get discountAmountall =>
      (subTotal + tax) * (discountPercentage.value / 100);

// Calculate Round Off
  double get roundOff =>
      (subTotal + tax - discountAmount.value) -
      (subTotal + tax - discountAmount.value).floor();

// Calculate Total
  double get total =>
      ((subTotal + tax - discountAmountall) + roundOff).floor().toDouble();

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

  void decrement(MenuItem item) {
    // Check if the item exists in the quantities map
    if (itemQuantities.containsKey(item)) {
      // Get the current quantity
      int currentQuantity = itemQuantities[item]!;

      // If the quantity is greater than 1, decrement it
      if (currentQuantity > 1) {
        itemQuantities.update(item, (value) => value - 1);
      } else {
        // If the quantity is 1, remove the item from the cart
        cartItems.removeWhere(
            (cartItem) => cartItem.id == item.id); // Ensure correct comparison
        itemQuantities.remove(item); // Remove the item from quantities as well
      }
    }

    // Notify UI update (if using GetX)
    update();
  }

  void takeOrderNow() {
    takeOrder.value = true;
  }

  void orderNoteValue(String value) {
    orderNote.value = value;
  }

  void selectsTable(String value) {
    selectTable.value = value;
  }

  void checkErrorMessage(String value) {
    if (value.isEmpty) {
      nameErrorText.value = "Please enter customar name.";
    } else {
      nameErrorText.value = "";
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadFloor();
    loadMenuItems();
    loadCatMenuItems();
  }

  @override
  void onClose() {
    discountController.dispose();
    super.onClose();
  }

  void loadMenuItems() async {
    try {
      isLoading.value = true;
      final fetchedItems = await MenuService().fetchMenuItems();
      menuItems.addAll(fetchedItems);
      print("Laod Complted");
    } catch (e) {
      Get.snackbar("Error", "Failed to load menu items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void loadFilterMenuItems(String categoryId, String categoryName) async {
    try {
      isLoading.value = true;
      final fetchedItems = await GetCatagoryFilterItem()
          .fetcfilterhMenuItems(categoryName, categoryId);
      // Clear existing items and add the new items
      menuItems.clear(); // Clear existing items
      menuItems.addAll(fetchedItems); // Add new items
    } catch (e) {
      Get.snackbar("Error", "Failed to load menu items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void loadCatMenuItems() async {
    try {
      final fetchedItems = await MenuCategoryList().fetchMenuCategories();
      // Clear existing items and add the new items
      menuItems.clear(); // Clear existing items

      menuCatagoryItem.addAll(fetchedItems);
    } catch (e) {
      Get.snackbar("Error", "Failed to load menu items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void createOrder(OrderModel orderDetail) async {
    try {
      // Call the createOrder method from OrderRepo
      final fetchedItems = await OrderRepo().createOrder(order: orderDetail);

      // Handle the response as needed
      if (fetchedItems != null) {
        // Process the successful response
        Get.snackbar("Success", "Order created successfully!");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to create order: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void loadFilterMenuSearch(String categoryName) async {
    try {
      isLoading.value = true;
      final fetchedItems =
          await SearchMenuService().searchMenuItems(categoryName);
      // Clear existing items and add the new items
      menuItems.clear(); // Clear existing items
      menuItems.addAll(fetchedItems);
      print("The values :$menuItems"); // Add new items
    } catch (e) {
      print("The values Arun :$e");
      Get.snackbar("Error", "Failed to load menu items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void loadFloor() async {
    try {
      final fetchedItems = await TableMasterProvider().fetchFloorMasterList();

      // Clear existing items and add the new items
      BranchtableDataList.clear(); // Clear existing items

      // Ensure you are accessing the correct property
      BranchtableDataList.addAll(
          fetchedItems.data.items); // Add the list of items
    } catch (e) {
      Get.snackbar("Error", "Failed to load menu items: $e");
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }

  void showAlertDialog() {
    Get.defaultDialog(
      titleStyle: AppTextStyles.heading,
      middleTextStyle: AppTextStyles.icontext,
      buttonColor: AppColors.orange,
      title: "Invalid Input",
      middleText: "Please enter a number between 1 and 10.",
      textConfirm: "OK",
      onConfirm: () {
        Get.back(); // Close the dialog
      },
    );
  }

  void showAlertDialogOrder() {
    takeOrder.value = true;
    Get.defaultDialog(
      titleStyle: AppTextStyles.heading,
      middleTextStyle: AppTextStyles.icontext,
      buttonColor: AppColors.orange,
      title: "Order Upadte",
      middleText: "Order Created Sucessfully",
      textConfirm: "OK",
      onConfirm: () {
        Get.toNamed('/dashboard');
      },
    );
  }

  void showAlertDialogOrderCancel() {
    takeOrder.value = true;
    Get.defaultDialog(
      titleStyle: AppTextStyles.heading,
      middleTextStyle: AppTextStyles.icontext,
      buttonColor: AppColors.orange,
      title: "Order Upadte",
      middleText: "Order Cancelled ",
      textConfirm: "OK",
      onConfirm: () {
        Get.back();
      },
    );
  }
}
