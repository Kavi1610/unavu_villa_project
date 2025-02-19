import 'package:get/get.dart';
import 'package:unavu_villa_project/models/getMenuItem.dart';
import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';
import 'dart:convert';

class GetCatagoryFilterItem extends BaseProvider {
  Future<List<MenuItem>> fetcfilterhMenuItems(
      String categoryId, String categoryName) async {
    try {
      // Fetch the token directly
      String? token = await fetchToken();

      // Make the API call
      final response = await get(
        ApiEndpoints.getCategoryMenuFiter(categoryName, categoryId),
        headers: {"Authorization": "Bearer $token"},
      );

      // Check for a successful response
      if (response.statusCode == 200) {
        // Check if the response body is already a Map
        final jsonData = response.body is String
            ? json.decode(response.body) as Map<String, dynamic>
            : response.body as Map<String, dynamic>;

        print("The menu items fetched successfully: ${response.body}");

        // Check if the API call was successful
        if (jsonData['status'] == false) {
          throw Exception("API call failed: ${jsonData['message']}");
        }

        // Safely access the items
        final List<dynamic>? items =
            jsonData['data'] is List ? jsonData['data'] : [];

        // Check if items is empty
        if (items!.isEmpty) {
          return []; // Return an empty list if there are no items
        }

        // Map the items to MenuItem objects
        return items!
            .map((item) {
              try {
                return MenuItem.fromJson(item);
              } catch (e) {
                print("Error parsing menu item: $e");
                return null; // Return null for items that fail to parse
              }
            })
            .where((item) => item != null)
            .cast<MenuItem>()
            .toList(); // Filter out nulls
      } else {
        throw Exception(
            "Failed to load menu items: Status ${response.statusCode}");
      }
    } catch (e) {
      print("Exception caught: $e");
      throw Exception("Error loading menu items: $e");
    }
  }
}
