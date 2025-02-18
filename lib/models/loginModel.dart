class UserModel {
  String username;
  String password;
  String? role;
  String? branch;
  UserModel(
      {required this.username, required this.password, this.role, this.branch});
}
