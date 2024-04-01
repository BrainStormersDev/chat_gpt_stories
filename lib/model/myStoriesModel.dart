import 'dart:convert';

MyStoriesModel myStoriesModelFromJson(String str) => MyStoriesModel.fromJson(json.decode(str));

String myStoriesModelToJson(MyStoriesModel data) => json.encode(data.toJson());

class MyStoriesModel {
  bool? status;
  String? message;
  List<MyStoriesData>? data;

  MyStoriesModel({
    this.status,
    this.message,
    this.data,
  });

  factory MyStoriesModel.fromJson(Map<String, dynamic> json) => MyStoriesModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<MyStoriesData>.from(json["data"]!.map((x) => MyStoriesData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MyStoriesData {
  int? id;
  String? storyTitle;
  String? story;
  dynamic storyNote;
  Category? category;
  int? viewCount;
  int? averageRating;
  String? featuredImage;

  MyStoriesData({
    this.id,
    this.storyTitle,
    this.story,
    this.storyNote,
    this.category,
    this.viewCount,
    this.averageRating,
    this.featuredImage,
  });

  factory MyStoriesData.fromJson(Map<String, dynamic> json) => MyStoriesData(
    id: json["id"],
    storyTitle: json["story_title"],
    story: json["story"],
    storyNote: json["story_note"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    viewCount: json["view_count"],
    averageRating: json["average_rating"],
    featuredImage: json["featured_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "story_title": storyTitle,
    "story": story,
    "story_note": storyNote,
    "category": category?.toJson(),
    "view_count": viewCount,
    "average_rating": averageRating,
    "featured_image": featuredImage,
  };
}

class Category {
  int? id;
  String? title;
  String? imageUrl;

  Category({
    this.id,
    this.title,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image_url": imageUrl,
  };
}
