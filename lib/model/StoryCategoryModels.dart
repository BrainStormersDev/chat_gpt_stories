// To parse this JSON data, do
//
//     final storyCategoryModels = storyCategoryModelsFromJson(jsonString);

import 'dart:convert';

StoryCategoryModels storyCategoryModelsFromJson(String str) => StoryCategoryModels.fromJson(json.decode(str));

String storyCategoryModelsToJson(StoryCategoryModels data) => json.encode(data.toJson());

class StoryCategoryModels {
  bool? status;
  String? message;
  List<StoryCatData>? data;

  StoryCategoryModels({
    this.status,
    this.message,
    this.data,
  });

  factory StoryCategoryModels.fromJson(Map<String, dynamic> json) => StoryCategoryModels(
    status: json["status"]??false,
    message: json["message"]??"Nothing to show",
    data: json["data"] == null ? [] : List<StoryCatData>.from(json["data"]!.map((x) => StoryCatData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StoryCatData {
  int? id;
  String? title;
  dynamic age;
  String? imageUrl;
  dynamic description;
  dynamic parentId;
  dynamic parent;

  StoryCatData({
    this.id,
    this.title,
    this.age,
    this.imageUrl,
    this.description,
    this.parentId,
    this.parent,
  });

  factory StoryCatData.fromJson(Map<String, dynamic> json) => StoryCatData(
    id: json["id"]??"",
    title: json["title"]??"",
    age: json["age"]??"",
    imageUrl: json["image_url"]??"",
    description: json["description"]??"",
    parentId: json["parent_id"]??"",
    parent: json["parent"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "age": age,
    "image_url": imageUrl,
    "description": description,
    "parent_id": parentId,
    "parent": parent,
  };
}
