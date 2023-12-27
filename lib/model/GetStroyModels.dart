// class GetStoryModels {
//   bool? status;
//   String? message;
//   Search? search;
//   DataOfStory? data;
//
//   GetStoryModels({this.status, this.message, this.search, this.data});
//
//   GetStoryModels.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     search =
//     json['search'] != null ? new Search.fromJson(json['search']) : null;
//     data = json['data'] != null ? new DataOfStory.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.search != null) {
//       data['search'] = this.search!.toJson();
//     }
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Search {
//   String? search;
//   String? q;
//
//   Search({this.search, this.q});
//
//   Search.fromJson(Map<String, dynamic> json) {
//     search = json['search'];
//     q = json['q'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['search'] = this.search;
//     data['q'] = this.q;
//     return data;
//   }
// }
//
// class DataOfStory {
//   int? id;
//   String? storyTitle;
//   String? story;
//   var storyNote;
//   var images;
//   // List<Images>? images;
//
//   DataOfStory({this.id, this.storyTitle, this.story, this.storyNote, this.images});
//
//   DataOfStory.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     storyTitle = json['story_title'];
//     story = json['story'];
//     storyNote = json['story_note'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['story_title'] = this.storyTitle;
//     data['story'] = this.story;
//     data['story_note'] = this.storyNote;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Images {
//   var id;
//   var storyId;
//   var imageUrl;
//   var createdAt;
//   var updatedAt;
//
//   Images(
//       {this.id, this.storyId, this.imageUrl, this.createdAt, this.updatedAt});
//
//   Images.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     storyId = json['story_id'];
//     imageUrl = json['image_url'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['story_id'] = this.storyId;
//     data['image_url'] = this.imageUrl;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
// // To parse this JSON data, do
// //
// //     final getStoryModels = getStoryModelsFromJson(jsonString);

import 'dart:convert';

GetStoryModels getStoryModelsFromJson(String str) => GetStoryModels.fromJson(json.decode(str));

String getStoryModelsToJson(GetStoryModels data) => json.encode(data.toJson());

class GetStoryModels {
  bool? status;
  String? message;
  Search? search;
  List<DataOfStory>? data;

  GetStoryModels({
    this.status,
    this.message,
    this.search,
    this.data,
  });

  factory GetStoryModels.fromJson(Map<String, dynamic> json) => GetStoryModels(
    status: json["status"],
    message: json["message"],
    search: json["search"] == null ? null : Search.fromJson(json["search"]),
    data: json["data"] == null ? [] : List<DataOfStory>.from(json["data"]!.map((x) => DataOfStory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "search": search?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataOfStory {
  int? id;
  String? storyTitle;
  String? story;
  dynamic storyNote;
  List<Image>? images;
  Category? category;
  int? viewCount;
  int? averageRating;

  DataOfStory({
    this.id,
    this.storyTitle,
    this.story,
    this.storyNote,
    this.images,
    this.category,
    this.viewCount,
    this.averageRating,
  });

  factory DataOfStory.fromJson(Map<String, dynamic> json) => DataOfStory(
    id: json["id"],
    storyTitle: json["story_title"],
    story: json["story"],
    storyNote: json["story_note"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    viewCount: json["view_count"],
    averageRating: json["average_rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "story_title": storyTitle,
    "story": story,
    "story_note": storyNote,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "category": category?.toJson(),
    "view_count": viewCount,
    "average_rating": averageRating,
  };
}

class Category {
  int? id;
  String? title;
  dynamic age;
  String? imageUrl;
  dynamic parentId;
  dynamic description;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdAt;
  dynamic updatedAt;

  Category({
    this.id,
    this.title,
    this.age,
    this.imageUrl,
    this.parentId,
    this.description,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    age: json["age"],
    imageUrl: json["image_url"],
    parentId: json["parent_id"],
    description: json["description"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "age": age,
    "image_url": imageUrl,
    "parent_id": parentId,
    "description": description,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Image {
  int? id;
  int? storyId;
  String? imageUrl;
  dynamic createdAt;
  dynamic updatedAt;

  Image({
    this.id,
    this.storyId,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    storyId: json["story_id"],
    imageUrl: json["image_url"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "story_id": storyId,
    "image_url": imageUrl,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Search {
  String? search;

  Search({
    this.search,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    search: json["search"],
  );

  Map<String, dynamic> toJson() => {
    "search": search,
  };
}
