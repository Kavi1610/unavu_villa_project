import 'dart:convert';
import 'package:get/get.dart';
import 'package:unavu_villa_project/models/login_response_model.dart';
import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';
import '../models/loginModel.dart';

class AuthRepo extends BaseProvider {
  Future<LoginResponseModel> doLogin({required UserModel request}) async {
    try {
      if (request == null) {
        return Future.error("Invalid login request.");
      }

      // Create the request body as a Map
      final Map<String, dynamic> requestBody = {
        "branchid": 101,
        "floorid": 1,
        "userid": "admin1",
        "password": "admin"
      };

      final response = await post(
        ApiEndpoints.login,
        jsonEncode(requestBody), // Encode the Map to JSON
      );

      if (response.hasError) {
        return Future.error(response.statusText ?? "Something went wrong.");
      } else {
        return LoginResponseModel.fromJson(response.body);
      }
    } catch (exception) {
      return Future.error("Login failed: ${exception.toString()}");
    }
  }
}
