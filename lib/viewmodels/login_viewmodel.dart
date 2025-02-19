import 'package:get/get.dart';
import 'package:unavu_villa_project/data/repository/auth_repostiory.dart';
import 'package:unavu_villa_project/models/loginModel.dart';
import 'package:unavu_villa_project/provider/auth_provider.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';

import '../main.dart';

class LoginViewModel extends GetxController {
  var usernameController = ''.obs;
  var passwordController = ''.obs;
  var isLoading = false.obs;

  var selectedRole = 'User'.obs; // Default role
  var selectedBranch = 'New York'.obs; // Default branch
  var captainName = ''.obs;
  final AuthRepository authRepository = AuthRepository();
  final AuthRepo authRepo = AuthRepo();

  Future<void> login() async {
    isLoading.value = true;

    UserModel loginRequest = UserModel(
        username: usernameController.value, password: passwordController.value);

    try {
      final val = await authRepo.doLogin(request: loginRequest);

      captainName.value = val.data!.name.toString() ?? "";
      String? token = val.accessToken; // Get the token from the response

      await storeToken(token!);

      isLoading.value = false; // Move this here
      if (val.status == true) {
        toastify(1, "Login Successfully");
        Get.toNamed('/dashboard');
      } else {
        toastify(0, val.message!);
      }
    } catch (e) {
      isLoading.value = false; // Add this line
      toastify(0, e.toString());
    }
  }
}
