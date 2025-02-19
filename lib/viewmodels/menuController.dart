import 'package:get/get.dart';
import 'package:unavu_villa_project/models/getMenuItem.dart';
import 'package:unavu_villa_project/models/menuItem.dart';
import 'package:unavu_villa_project/models/menu_catagory_list_%20model.dart';
import 'package:unavu_villa_project/models/takeOrderModel.dart';
import 'package:unavu_villa_project/provider/getMenuProvider.dart';
import 'package:unavu_villa_project/provider/get_catagory_filter_item.dart';
import 'package:unavu_villa_project/provider/get_menu_item_provider.dart';
import 'package:unavu_villa_project/provider/orderTake_provider.dart';

class FoodMenuController extends GetxController {
  var menuItems = <MenuItem>[].obs;
  var cartItems = <MenuItem>[].obs;
  var menuCatagoryItem = <MenuCategory>[].obs;
  var itemQuantities = <MenuItem, int>{}.obs;
  var orderItem = <OrderItemModel>[].obs;
  var takeOrder = false.obs;
  var isLoading = true.obs;
  RxString orderNote = ''.obs;

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

        // Debugging output
        print(
            "Item: ${item.itemname}, Price: $itemPrice, Tax Rate: $taxRate%, Tax: $itemTax");

        // Add the individual item tax to the total sum
        return sum + itemTax;
      } catch (e) {
        print("Error calculating tax for item ${item.itemname}: $e");
        return sum; // Return sum unchanged in case of error
      }
    });
  }

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

  @override
  void onInit() {
    super.onInit();
    print("Laod started");
    loadMenuItems();
    loadCatMenuItems();
  }

  void loadMenuItems() async {
    try {
      isLoading.value = true;
      final fetchedItems = await MenuService().fetchMenuItems();
      menuItems.addAll(fetchedItems);
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
      isLoading.value = true;
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
      isLoading.value = true;

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
}
