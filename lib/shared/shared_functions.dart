import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unavu_villa_project/main.dart';

toastify(int type, String message) {
  return Get.snackbar(type == 0 ? "Error" : "Success", message,
      snackPosition: SnackPosition.BOTTOM);
}

Future<void> storeToken(String token) async {
  try {
    await storage.write("token", token);
    print("Token stored successfully.");
  } catch (e) {
    print("Error writing token to storage: $e");
  }
}

// Function to fetch the token
Future<String?> fetchToken() async {
  try {
    String? token = storage.read("token");
    return token;
  } catch (e) {
    print("Error reading token from storage: $e");
    return null;
  }
}

blackLoader() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.black,
    ),
  );
}
