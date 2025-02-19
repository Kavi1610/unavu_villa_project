import 'package:unavu_villa_project/models/menu_catagory_list_%20model.dart';
import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';
import 'dart:convert';

class MenuCategoryList extends BaseProvider {
  Future<List<MenuCategory>> fetchMenuCategories() async {
    try {
      // Fetch the token directly
      String? token = await fetchToken();

      // Make the API call
      final response = await get(
        ApiEndpoints.getcatagoryMenu, // Ensure this is the correct endpoint
        headers: {"Authorization": "Bearer $token"},
      );
      print("Invalid category item: ${response.body['data']}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.body;
        print("Invalid category item: ${jsonData['data']}");

        // Assuming 'data' is a list of strings
        List<MenuCategory> categories = (jsonData['data'] as List)
            .map((item) {
              // Check if item is null or not a string
              if (item != null && item is String) {
                return MenuCategory(item); // Create MenuCategory if valid
              } else {
                print("Invalid category item: $item"); // Log invalid item
                return null; // Return null for invalid items
              }
            })
            .where((category) => category != null) // Filter out nulls
            .cast<MenuCategory>() // Cast to List<MenuCategory>
            .toList();
        return categories;
      } else {
        throw Exception(
            'Failed to load menu categories: Status ${response.statusCode}');
      }
    } catch (e) {
      print("Exception caught: $e");
      throw Exception("Error loading menu categories: $e");
    }
  }
}
