class StoryCategoryModels {
  bool? status;
  String? message;
  List<StoryCatData>? data;

  StoryCategoryModels({this.status, this.message, this.data});

  StoryCategoryModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StoryCatData>[];
      json['data'].forEach((v) {
        data!.add(new StoryCatData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoryCatData {
  var id;
  var title;
  var age;
 var imageUrl;
 var description;

  StoryCatData({this.id, this.title, this.age, this.imageUrl, this.description});

  StoryCatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    age = json['age'];
    imageUrl = json['image_url'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['age'] = this.age;
    data['image_url'] = this.imageUrl;
    data['description'] = this.description;
    return data;
  }
}
