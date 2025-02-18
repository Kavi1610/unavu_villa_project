import 'package:get/get.dart';
import 'package:unavu_villa_project/data/repository/auth_repostiory.dart';
import 'package:unavu_villa_project/models/loginModel.dart';

class LoginViewModel extends GetxController {
  var usernameController = ''.obs;
  var passwordController = ''.obs;
  var isLoading = false.obs;

  var selectedRole = 'User'.obs; // Default role
  var selectedBranch = 'New York'.obs; // Default branch

  final AuthRepository authRepository = AuthRepository();

  Future<void> login() async {
    isLoading.value = true;

    bool success = await authRepository.login(
      UserModel(
        username: usernameController.value,
        password: passwordController.value,
      ),
    );

    isLoading.value = false;

    if (success) {
      Get.snackbar("Success", "Login Successful",
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed('/dashboard');
    } else {
      Get.snackbar("Error", "Invalid Credentials",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
