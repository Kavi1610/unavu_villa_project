import 'package:get/get.dart';
import 'package:unavu_villa_project/data/repository/auth_repostiory.dart';
import 'package:unavu_villa_project/models/loginModel.dart';

class LoginViewModel extends GetxController {
  var usernameController = ''.obs;
  var passwordController = ''.obs;
  var isLoading = false.obs;

  final AuthRepository authRepository = AuthRepository();

  Future<void> login() async {
    isLoading.value = true;
    bool success = await authRepository.login(
      UserModel(
          username: usernameController.value,
          password: passwordController.value),
    );

    isLoading.value = false;
    Get.toNamed('/dashboard');
    if (success) {
      Get.snackbar("Success", "Login Successful",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Invalid Credentials",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
