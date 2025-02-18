import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unavu_villa_project/main.dart';

toastify(int type, String message) {
  return Get.snackbar(type == 0 ? "Error" : "Success", message,
      snackPosition: SnackPosition.BOTTOM);
}

Future<String> fetchToken() async {
  // String token = await storage.read("token");
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyIiwiZXhwIjoxNzcxNDYxNzY1fQ.ylXm0YekyE38UhdxRQTFZTTeEoK0Bhbb1c8-gizfWd4";
  return token;
}

blackLoader() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.black,
    ),
  );
}
