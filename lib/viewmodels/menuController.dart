import 'package:get/get.dart';
import 'package:unavu_villa_project/models/getMenuItem.dart';
import 'package:unavu_villa_project/models/menuItem.dart';
import 'package:unavu_villa_project/models/menu_catagory_list_%20model.dart';
import 'package:unavu_villa_project/provider/getMenuProvider.dart';
import 'package:unavu_villa_project/provider/get_menu_item_provider.dart';

class FoodMenuController extends GetxController {
  var menuItems = <MenuItem>[].obs;
  var cartItems = <MenuItem>[].obs;
  var menuCatagoryItem = <MenuCategory>[].obs;
  var itemQuantities = <MenuItem, int>{}.obs;
  var takeOrder = false.obs;
  var isLoading = true.obs;

  double get subTotal => cartItems.fold(
      0,
      (sum, item) =>
          sum + (int.parse(item.price) * (itemQuantities[item] ?? 1)));

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

  void loadCatMenuItems() async {
    try {
      isLoading.value = true;
      final fetchedItems = await MenuCategoryList().fetchMenuCategories();
      menuCatagoryItem.addAll(fetchedItems);
    } catch (e) {
      Get.snackbar("Error", "Failed to load menu items: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
