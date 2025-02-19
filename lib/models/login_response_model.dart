// ignore_for_file: prefer_typing_uninitialized_variables

class LoginResponseModel {
  final bool status;
  final String accessToken;
  final String refreshToken;
  final UserData data;
  final String message;

  LoginResponseModel({
    required this.status,
    required this.accessToken,
    required this.refreshToken,
    required this.data,
    required this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      data: UserData.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class UserData {
  final String userId;
  final String phoneNumber;
  final String name;
  final String role;
  final int branchId;
  final DateTime createdAt;
  final dynamic deletedAt; // Can be null
  final int id;
  final String password; // Consider not storing passwords in plain text
  final String mobileToken;
  final List<int> floorId;
  final bool accountActive;
  final DateTime updatedAt;
  final bool isDeleted;

  UserData({
    required this.userId,
    required this.phoneNumber,
    required this.name,
    required this.role,
    required this.branchId,
    required this.createdAt,
    this.deletedAt,
    required this.id,
    required this.password,
    required this.mobileToken,
    required this.floorId,
    required this.accountActive,
    required this.updatedAt,
    required this.isDeleted,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userid'],
      phoneNumber: json['phonenumber'],
      name: json['name'],
      role: json['role'],
      branchId: json['branchid'],
      createdAt: DateTime.parse(json['created_at']),
      deletedAt: json['deleted_at'], // This can be null
      id: json['id'],
      password:
          json['password'], // Consider not storing passwords in plain text
      mobileToken: json['mobile_token'],
      floorId: List<int>.from(json['floorid']),
      accountActive: json['account_active'],
      updatedAt: DateTime.parse(json['updated_at']),
      isDeleted: json['is_deleted'],
    );
  }
}
