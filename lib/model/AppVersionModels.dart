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
  var androidAppVersion;
  var androidUrl;
  int? androidVersionCheck;
  String? huaweiAppVersion;
  Null? huaweiUrl;
  int? huaweiVersionCheck;
  String? iosAppVersion;
  Null? iosUrl;
  int? iosVersionCheck;

  Data(
      {this.androidAppVersion,
        this.androidUrl,
        this.androidVersionCheck,
        this.huaweiAppVersion,
        this.huaweiUrl,
        this.huaweiVersionCheck,
        this.iosAppVersion,
        this.iosUrl,
        this.iosVersionCheck});

  Data.fromJson(Map<String, dynamic> json) {
    androidAppVersion = json['android_app_version'];
    androidUrl = json['android_url'];
    androidVersionCheck = json['android_version_check'];
    huaweiAppVersion = json['huawei_app_version'];
    huaweiUrl = json['huawei_url'];
    huaweiVersionCheck = json['huawei_version_check'];
    iosAppVersion = json['ios_app_version'];
    iosUrl = json['ios_url'];
    iosVersionCheck = json['ios_version_check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['android_app_version'] = this.androidAppVersion;
    data['android_url'] = this.androidUrl;
    data['android_version_check'] = this.androidVersionCheck;
    data['huawei_app_version'] = this.huaweiAppVersion;
    data['huawei_url'] = this.huaweiUrl;
    data['huawei_version_check'] = this.huaweiVersionCheck;
    data['ios_app_version'] = this.iosAppVersion;
    data['ios_url'] = this.iosUrl;
    data['ios_version_check'] = this.iosVersionCheck;
    return data;
  }
}
