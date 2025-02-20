import 'dart:convert';
import 'package:get/get.dart';
import 'package:unavu_villa_project/models/paybill_model.dart';
import 'package:unavu_villa_project/models/takeOrderModel.dart';
import 'package:unavu_villa_project/models/takeorderresponsemodel.dart';
import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';

class CancelBillProvider extends BaseProvider {
  Future<dynamic> billOrder({required Bill order}) async {
    try {
      String? token = await fetchToken();
      if (order == null) {
        return Future.error("Invalid order request.");
      }

      // Create the request body as a Map
      final Map<String, dynamic> requestBody = {
        "ordertype": order.orderType,
        "status": order.status,
        "tableid": order.tableId,
        "numberofpeople": order.numberOfPeople,
        "captainname": order.captainName,
        "waitername": order.waiterName,
        "customername": order.captainName,
        "customermobile": order.customerMobile,
        "email": order.email,
        "location": order.location,
        "address": order.address,
        "customerGSTIN": order.customerGSTIN,
        "order_by": order.orderBy,
        "paymentmethod": order.paymentMethod,
        "knotes": order.notes,
        "branchid": order.branchId,
        "floorid": order.floorId,
        "printerid": order.printerId,
        "discountamount": order.discountAmount,
        "totalamount": order.totalAmount,
        "grandtotal": order.grandTotal,
        "is_deleted": order.isDeleted,
        "customemobile": order.customerMobile,
        "id": order.id,
        "billno": order.billNo,
        "created_at": order.createdAt
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
