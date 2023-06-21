class LogIn {
  bool? status;
  String? message;
  Data? data;
  String? accessToken;

  LogIn({this.status, this.message, this.data, this.accessToken});

  LogIn.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['access_token'] = this.accessToken;
    return data;
  }
}

class Data {
  int? id;
  String? role;
  String? name;
  Null? lastName;
  String? email;
  Null? phone;
  Null? deviceToken;
  Null? apiToken;
  String? avatar;
  int? gender;
  Null? age;
  Null? emailVerifiedAt;
  Null? emailOtp;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.role,
        this.name,
        this.lastName,
        this.email,
        this.phone,
        this.deviceToken,
        this.apiToken,
        this.avatar,
        this.gender,
        this.age,
        this.emailVerifiedAt,
        this.emailOtp,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    name = json['name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    deviceToken = json['device_token'];
    apiToken = json['api_token'];
    avatar = json['avatar'];
    gender = json['gender'];
    age = json['age'];
    emailVerifiedAt = json['email_verified_at'];
    emailOtp = json['email_otp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['device_token'] = this.deviceToken;
    data['api_token'] = this.apiToken;
    data['avatar'] = this.avatar;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['email_otp'] = this.emailOtp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
