import 'dart:convert';
import 'package:get/get.dart';
import 'package:unavu_villa_project/models/takeOrderModel.dart';
import 'package:unavu_villa_project/models/takeorderresponsemodel.dart';
import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';

class OrderRepo extends BaseProvider {
  Future<OrderResponseModel> createOrder({required OrderModel order}) async {
    try {
      String? token = await fetchToken();
      if (order == null) {
        return Future.error("Invalid order request.");
      }

      // Create the request body as a Map
      final Map<String, dynamic> requestBody = {
        "ordertype": order.ordertype,
        "status": order.status,
        "tableid": order.tableid,
        "numberofpeople": order.numberofpeople,
        "captainname": order.captainname,
        "waitername": order.waitername,
        "customername": order.customername,
        "customermobile": order.customermobile,
        "email": order.email,
        "location": order.location,
        "address": order.address,
        "customerGSTIN": order.customerGSTIN,
        "items": order.items
            .map((item) => {
                  "itemcode": item.itemcode,
                  "itemname": item.itemname,
                  "quantity": item.quantity,
                  "price": item.price,
                  "comp": item.comp,
                  "total": item.total,
                  "is_deleted": item.isDeleted,
                })
            .toList(),
        "order_by": order.orderBy,
        "paymentmethod": order.paymentMethod,
        "knotes": order.knotes,
      };

      final response = await post(
        ApiEndpoints.createOrder, // Replace with your actual endpoint
        headers: {"Authorization": "Bearer $token"},
        jsonEncode(requestBody), // Encode the Map to JSON
      );

      if (response.hasError) {
        return Future.error(response.statusText ?? "Something went wrong.");
      } else {
        return OrderResponseModel.fromJson(response.body); // Parse the response
      }
    } catch (exception) {
      return Future.error("Order creation failed: ${exception.toString()}");
    }
  }
}
