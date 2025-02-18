// ignore_for_file: prefer_typing_uninitialized_variables

class LoginResponseModel {
  bool? status;
  Data? data;
  String? accessToken;
  String? refreshToken;
  String? message;

  LoginResponseModel(
      {this.status,
      this.data,
      this.accessToken,
      this.refreshToken,
      this.message});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['message'] = message;
    return data;
  }
}

class Data {
  String? name;
  String? email;
  var phonenumber;
  var mobileToken;
  String? role;
  bool? notificationEnabled;
  String? createdAt;
  var deletedAt;
  int? id;
  String? password;
  String? signintype;
  var profilepic;
  bool? accountActive;
  String? updatedAt;
  bool? isDeleted;

  Data(
      {this.name,
      this.email,
      this.phonenumber,
      this.mobileToken,
      this.role,
      this.notificationEnabled,
      this.createdAt,
      this.deletedAt,
      this.id,
      this.password,
      this.signintype,
      this.profilepic,
      this.accountActive,
      this.updatedAt,
      this.isDeleted});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    mobileToken = json['mobile_token'];
    role = json['role'];
    notificationEnabled = json['notification_enabled'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    id = json['id'];
    password = json['password'];
    signintype = json['signintype'];
    profilepic = json['profilepic'];
    accountActive = json['account_active'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phonenumber'] = phonenumber;
    data['mobile_token'] = mobileToken;
    data['role'] = role;
    data['notification_enabled'] = notificationEnabled;
    data['created_at'] = createdAt;
    data['deleted_at'] = deletedAt;
    data['id'] = id;
    data['password'] = password;
    data['signintype'] = signintype;
    data['profilepic'] = profilepic;
    data['account_active'] = accountActive;
    data['updated_at'] = updatedAt;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
