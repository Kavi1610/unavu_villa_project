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
  final AuthRepo authRepo = AuthRepo();

  Future<void> login() async {
    isLoading.value = true;
    Get.toNamed('/dashboard');
    // UserModel loginRequest = UserModel(
    //     username: usernameController.value, password: passwordController.value);
    // await authRepo.doLogin(request: loginRequest).then((val) {
    //   if (val.status == true) {
    //     isLoading.value = false;
    //     toastify(1, "Login Succesfully");
    //   } else {
    //     toastify(0, val.message!);
    //   }
    // }).catchError((e) {
    //   toastify(0, e.toString());
    // });
    // bool success = await authRepo.login(
    //   UserModel(
    //       username: usernameController.value,
    //       password: passwordController.value),
    // );

    // isLoading.value = false;
    // Get.toNamed('/dashboard');
    // if (success) {
    //   Get.snackbar("Success", "Login Successful",
    //       snackPosition: SnackPosition.BOTTOM);
    // } else {
    //   Get.snackbar("Error", "Invalid Credentials",
    //       snackPosition: SnackPosition.BOTTOM);
    // }
  }
}
