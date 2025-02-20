import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unavu_villa_project/core/app_colors.dart';
import 'package:unavu_villa_project/core/app_textstyle.dart';
import 'package:unavu_villa_project/core/enums.dart';
import 'package:unavu_villa_project/models/addItempayDetail_model.dart';
import 'package:unavu_villa_project/models/getMenuItem.dart';
import 'package:unavu_villa_project/models/orderDetaul.dart';
import 'package:unavu_villa_project/models/order_list_response_model.dart';
import 'package:unavu_villa_project/models/paybill_model.dart';
import 'package:unavu_villa_project/models/report_response_model.dart';
import 'package:unavu_villa_project/provider/cancelorder_provider.dart';
import 'package:unavu_villa_project/provider/dashboard_provider.dart';
import 'package:unavu_villa_project/provider/food_items_provider.dart';
import 'package:unavu_villa_project/provider/generate_bill_provider.dart';
import 'package:unavu_villa_project/provider/search_menu_provider.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';
import 'package:unavu_villa_project/viewmodels/orderController.dart';

class DashboardController extends GetxController {
  final OrderProvider orderProvider = Get.put(OrderProvider());
  final FoodItemsProvider foodItemProvider = FoodItemsProvider();
  RxString searchQuery = ''.obs;
  RxInt selectedTabIndex = 0.obs;
  RxInt selectedFilterIndex = 0.obs;
  RxString selectedFiltermenu = ''.obs;
  RxString selectedCategory = ''.obs;
  var paymentMode = 0.obs;
  var nvoicePay = InvoicePay(
    totalAmount: 0.0,
    tax: 0.0,
    discountAmount: 0.0,
    roundOff: 0.0,
    grandTotal: 0.0,
  ).obs;
  var selectedPrinter = ''.obs;
  List<String> printers = ['Dine In'];
  Rx<DeviceType> deviceType = DeviceType.tablet.obs;
  DashboardProvider dashboardProvider = DashboardProvider();
  OrderListResponse orderList = OrderListResponse();
  ReportResponseModel reportData = ReportResponseModel();
  RxBool isLoading = true.obs;
  List<String> get filterOptions => ['Dine In'];
  var addItemcheck = false.obs;
  List<String> get filterOrderScreen => [
        'All',
        'Veg',
        'Non Veg',
      ];
  @override
  void onInit() {
    debugPrint("initState workss");
    super.onInit();
    fetchAllOrders();
    ever(deviceType, (_) => update());
  }

  fetchAllOrders() async {
    isLoading(true);
    String branchId = "101";
    await dashboardProvider.fetchOrderList(branchId).then((val) {
      if (val.status == true) {
        orderList = val;

        fetchReport();
        debugPrint("theee resposs : ${orderList.toJson()}");
      } else {
        isLoading(true);
      }
    });
  }

  void fetchReport() async {
    await dashboardProvider.fetchReport().then((val) {
      reportData = val;
      isLoading(false);
    });
  }

  void updateDeviceType(BuildContext context) {
    // Determine device type based on width
    if (MediaQuery.of(context).size.width < 600) {
      deviceType.value = DeviceType.mobile;
    } else {
      deviceType.value = DeviceType.tablet;
    }
  }

  List<Order> get allOrders => orderProvider.orders;
  List<Order> get pendingOrders => orderProvider.orders
      .where((o) => o.status == OrderStatus.pending)
      .toList();

  List<Order> get inProgressOrders => orderProvider.orders
      .where((o) => o.status == OrderStatus.inProgress)
      .toList();

  List<Order> get completedOrders => orderProvider.orders
      .where((o) => o.status == OrderStatus.completed)
      .toList();

  void markOrderAsCompleted(String id) {
    orderProvider.updateOrderStatus(id, OrderStatus.completed);
  }

  void cancelOrder(String id) {
    orderProvider.updateOrderStatus(id, OrderStatus.cancelled);
  }

  void markItemAsDelivered(String orderId, int itemIndex, int status) async {
    debugPrint(
        "theee order id is : $orderId , $itemIndex and the status is : $status");

    int? temp;
    // orderProvider.markItemAsDelivered(orderId, itemIndex);
    for (int i = 0; i < orderList.data!.items!.length; i++) {
      debugPrint("comess : $i");
      if (orderId == orderList.data!.items![i].orderid.toString()) {
        debugPrint("dcjdvbf matchess");
        temp = i;
      }
    }
    debugPrint("temenr : $temp");
    String timestamp =
        orderList.data!.items![temp!].items![itemIndex].createdAt!;
    debugPrint("theee stfr 1 : $timestamp");
    // Parse the timestamp to DateTime
    DateTime givenTime = DateTime.parse(timestamp);
    debugPrint("theee stfr 2 : $givenTime");
    // Get the current time
    DateTime currentTime = DateTime.now();
    debugPrint("theee stfr 3 : $currentTime");
    // Calculate the difference in minutes
    int differenceInMinutes = currentTime.difference(givenTime).inMinutes;
    debugPrint("theee stfr 4 : $differenceInMinutes");
    debugPrint(
        "the request bodiess are : ${orderList.data!.items![temp].items![itemIndex].id!} , $status and $differenceInMinutes");
    await foodItemProvider
        .updateItemStatus(orderList.data!.items![temp].items![itemIndex].id!,
            status, differenceInMinutes)
        .then((val) {
      if (val == true) {
        fetchAllOrders();
        toastify(1, "Item Updated Successfully");
      }
    }).catchError((e) {
      debugPrint("theee error is : $e");
    });
  }

  void setFilterIndex(int index, String name) {
    selectedFilterIndex.value = index;
    selectedFiltermenu.value = name;
  }

  void onCategorySelected(String category) {
    selectedCategory.value = category;
  }

  void onAdditemSelected(bool ichecked) {
    addItemcheck.value = ichecked;
    print("The value is:${addItemcheck.value}");
  }

  void addItemBill(InvoicePay billData) {
    nvoicePay.value = billData;
  }

  void addPaymentMode(int bill) {
    paymentMode.value = bill;
  }

  void setSelectedTabIndex(int index) {
    selectedTabIndex.value = index;
    debugPrint("thee setter value is : $selectedTabIndex");
  }

  void generateBillload(Map<String, dynamic> bill) async {
    try {
      final fetchedItems = await GenerateBillProvider().billOrder(order: bill);

      Get.back();
    } catch (e) {
      print("The values Arun :$e");
      Get.snackbar("Error", "Failed to load menu items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void cancelBillload(Map<String, dynamic> bill) async {
    try {
      final fetchedItems = await CancelBillProvider().billOrder(order: bill);
      fetchAllOrders();
      orderCancelAlert();
    } catch (e) {
      print("The values Arun :$e");
      Get.snackbar("Error", "Failed to load menu items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void orderCancelAlert() {
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
