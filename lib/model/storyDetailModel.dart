import 'dart:convert';

StoryDetailModel storyDetailModelFromJson(String str) => StoryDetailModel.fromJson(json.decode(str));

String storyDetailModelToJson(StoryDetailModel data) => json.encode(data.toJson());

class StoryDetailModel {
  bool? status;
  String? message;
  SelectedStoryData? data;

  StoryDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory StoryDetailModel.fromJson(Map<String, dynamic> json) => StoryDetailModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : SelectedStoryData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class SelectedStoryData {
  Story? story;
  List<String>? images;

  SelectedStoryData({
    this.story,
    this.images,
  });

  factory SelectedStoryData.fromJson(Map<String, dynamic> json) => SelectedStoryData(
    story: json["story"] == null ? null : Story.fromJson(json["story"]),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "story": story?.toJson(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}

class Story {
  int? id;
  String? storyTitle;
  String? story;
  dynamic storyNote;
  Category? category;
  int? viewCount;
  int? averageRating;

  Story({
    this.id,
    this.storyTitle,
    this.story,
    this.storyNote,
    this.category,
    this.viewCount,
    this.averageRating,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    storyTitle: json["story_title"],
    story: json["story"],
    storyNote: json["story_note"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    viewCount: json["view_count"],
    averageRating: json["average_rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "story_title": storyTitle,
    "story": story,
    "story_note": storyNote,
    "category": category?.toJson(),
    "view_count": viewCount,
    "average_rating": averageRating,
  };
}

class Category {
  int? id;
  String? title;

  Category({
    this.id,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
