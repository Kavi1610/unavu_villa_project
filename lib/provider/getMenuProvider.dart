import 'package:get/get.dart';
import 'package:unavu_villa_project/models/getMenuItem.dart';
import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';
import 'dart:convert';

class MenuService extends BaseProvider {
  Future<List<MenuItem>> fetchMenuItems() async {
    try {
      // Fetch the token directly
      var token;
      await fetchToken().then((val) {
        token = val;
      });

      // Make the API call
      final response = await get(
        ApiEndpoints.getallMenu,
        headers: {"Authorization": "Bearer $token"},
      );

      // Check for a successful response
      if (response.statusCode == 200) {
        // Check if the response body is already a Map
        final jsonData = response.body is String
            ? json.decode(response.body) as Map<String, dynamic>
            : response.body as Map<String, dynamic>;

        print("The menu items fetched successfully: ${response.body}");

        // Safely access the items
        final List<dynamic>? items = jsonData['data']?['items'];
        if (items == null) {
          throw Exception("Response missing 'items' field");
        }

        // Map the items to MenuItem objects
        return items
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
