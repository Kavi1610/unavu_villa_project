import 'dart:convert';
import 'package:get/get.dart';
import 'package:unavu_villa_project/models/paybill_model.dart';
import 'package:unavu_villa_project/models/takeOrderModel.dart';
import 'package:unavu_villa_project/models/takeorderresponsemodel.dart';
import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';

class GenerateBillProvider extends BaseProvider {
  Future<dynamic> billOrder({required Map<String, dynamic> order}) async {
    try {
      String? token = await fetchToken();
      if (order == null) {
        return Future.error("Invalid order request.");
      }

      final response = await post(
        ApiEndpoints.createOrder, // Replace with your actual endpoint
        headers: {"Authorization": "Bearer $token"},
        jsonEncode(order), // Encode the Map to JSON
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
