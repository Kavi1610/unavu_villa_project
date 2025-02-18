import 'package:unavu_villa_project/models/loginModel.dart';

class AuthRepository {
  Future<bool> login(UserModel user) async {
    await Future.delayed(const Duration(seconds: 2));
    return user.username == "test" && user.password == "123456";
  }
}
