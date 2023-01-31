class AppVersionModels {
  bool? status;
  String? message;
  Data? data;

  AppVersionModels({this.status, this.message, this.data});

  AppVersionModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? androidAppVersion;
  int? androidVersionCheck;
  String? huaweiAppVersion;
  int? huaweiVersionCheck;
  String? iosAppVersion;
  int? iosVersionCheck;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.androidAppVersion,
        this.androidVersionCheck,
        this.huaweiAppVersion,
        this.huaweiVersionCheck,
        this.iosAppVersion,
        this.iosVersionCheck,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    androidAppVersion = json['android_app_version'];
    androidVersionCheck = json['android_version_check'];
    huaweiAppVersion = json['huawei_app_version'];
    huaweiVersionCheck = json['huawei_version_check'];
    iosAppVersion = json['ios_app_version'];
    iosVersionCheck = json['ios_version_check'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['android_app_version'] = this.androidAppVersion;
    data['android_version_check'] = this.androidVersionCheck;
    data['huawei_app_version'] = this.huaweiAppVersion;
    data['huawei_version_check'] = this.huaweiVersionCheck;
    data['ios_app_version'] = this.iosAppVersion;
    data['ios_version_check'] = this.iosVersionCheck;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
