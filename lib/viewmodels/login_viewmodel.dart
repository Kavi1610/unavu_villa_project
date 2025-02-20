import 'package:get/get.dart';
import 'package:unavu_villa_project/data/repository/auth_repostiory.dart';
import 'package:unavu_villa_project/models/floor_master_model.dart';
import 'package:unavu_villa_project/models/loginModel.dart';
import 'package:unavu_villa_project/provider/auth_provider.dart';
import 'package:unavu_villa_project/provider/floor_master_provider.dart';
import 'package:unavu_villa_project/shared/shared_functions.dart';

import '../main.dart';

class LoginViewModel extends GetxController {
  var usernameController = ''.obs; // Observable for username
  var passwordController = ''.obs; // Observable for password
  var isLoading = false.obs; // Observable for loading state

  var selectedRole = ''.obs; // Observable for selected role
  var selectedBranch = ''.obs; // Observable for selected branch
  var captainName = ''.obs; // Observable for captain name
  var waiterName = ''.obs; // Observable for captain name
  var selectTab = 0; // Current selected tab for roles
  var branchselectTab = 1; // Current selected tab for branches
  var selectedBranchId = ''.obs;
  var captainID = ''.obs;
  // Sample data for roles and branches
  var RoletableDataList = ["Una Villa Restaurant & Bakery,Nungambakkam"];
  var BranchtableDataList = <Item>[].obs;
  final AuthRepository authRepository = AuthRepository();
  final AuthRepo authRepo = AuthRepo();

  @override
  void onInit() {
    super.onInit();

    loadFloor();
  }

  Future<void> login() async {
    isLoading.value = true;

    UserModel loginRequest = UserModel(
        username: usernameController.value, password: passwordController.value);

    try {
      final val = await authRepo.doLogin(usernameController.value,
          passwordController.value, int.parse(selectedBranchId.value));

      if (val.data!.role.toLowerCase() == 'Captain'.toLowerCase()) {
        captainName.value = val.data!.userId.toString() ?? "";
      } else if (val.data!.role.toLowerCase() == 'Waiter'.toLowerCase()) {
        waiterName.value = val.data!.userId.toString() ?? "";
      }
      captainID.value = val.data!.id.toString();
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

  void selelctRoles(String calue) {
    selectedRole.value = calue;
  }

  void selelctBranch(String val) {
    selectedBranch.value = val;
  }

  void loadFloor() async {
    try {
      final fetchedItems = await FloorMasterProvider().fetchFloorMasterList();

      // Clear existing items and add the new items
      BranchtableDataList.clear(); // Clear existing items

      // Ensure you are accessing the correct property
      BranchtableDataList.addAll(
          fetchedItems.data.items); // Add the list of items
    } catch (e) {
      Get.snackbar("Error", "Failed to load menu items: $e");
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }
}
