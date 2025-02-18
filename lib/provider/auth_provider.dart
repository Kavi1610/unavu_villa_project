import 'package:unavu_villa_project/models/login_response_model.dart';
import 'package:unavu_villa_project/provider/base_provider.dart';
import 'package:unavu_villa_project/shared/api_endpoints.dart';

import '../models/loginModel.dart';

class AuthRepo extends BaseProvider {
  Future<LoginResponseModel> doLogin({required UserModel request}) async {
    try {
      final response = await post(ApiEndpoints.login, request.toString());
      if (response.hasError) {
        return Future.error("Something Went Wrong");
      } else {
        return LoginResponseModel.fromJson(response.body);
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }
}
