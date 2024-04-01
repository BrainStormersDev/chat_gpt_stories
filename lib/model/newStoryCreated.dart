// To parse this JSON data, do
//
//     final newStoryCreatedModel = newStoryCreatedModelFromJson(jsonString);

import 'dart:convert';

NewStoryCreatedModel newStoryCreatedModelFromJson(String str) => NewStoryCreatedModel.fromJson(json.decode(str));

String newStoryCreatedModelToJson(NewStoryCreatedModel data) => json.encode(data.toJson());

class NewStoryCreatedModel {
  bool? status;
  String? message;
  Data? data;

  NewStoryCreatedModel({
    this.status,
    this.message,
    this.data,
  });

  factory NewStoryCreatedModel.fromJson(Map<String, dynamic> json) => NewStoryCreatedModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? title;
  String? story;
  List<String>? images;

  Data({
    this.title,
    this.story,
    this.images,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    story: json["story"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "story": story,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}
