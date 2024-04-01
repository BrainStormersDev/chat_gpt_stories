// // To parse this JSON data, do
// //
// //     final createStory = createStoryFromJson(jsonString);
//
// import 'dart:convert';
//
// CreateStory createStoryFromJson(String str) => CreateStory.fromJson(json.decode(str));
//
// String createStoryToJson(CreateStory data) => json.encode(data.toJson());
//
// class CreateStory {
//   bool? status;
//   String? message;
//   List<StoryData>? data;
//
//   CreateStory({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory CreateStory.fromJson(Map<String, dynamic> json) => CreateStory(
//     status: json["status"],
//     message: json["message"],
//     data: json["data"] == null ? [] : List<StoryData>.from(json["data"]!.map((x) => StoryData.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class StoryData {
//   int? id;
//   String? storyTitle;
//   String? story;
//   dynamic storyNote;
//   List<Image>? images;
//   dynamic category;
//   dynamic viewCount;
//   int? averageRating;
//
//   StoryData({
//     this.id,
//     this.storyTitle,
//     this.story,
//     this.storyNote,
//     this.images,
//     this.category,
//     this.viewCount,
//     this.averageRating,
//   });
//
//   factory StoryData.fromJson(Map<String, dynamic> json) => StoryData(
//     id: json["id"],
//     storyTitle: json["story_title"],
//     story: json["story"],
//     storyNote: json["story_note"],
//     images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
//     category: json["category"],
//     viewCount: json["view_count"],
//     averageRating: json["average_rating"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "story_title": storyTitle,
//     "story": story,
//     "story_note": storyNote,
//     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//     "category": category,
//     "view_count": viewCount,
//     "average_rating": averageRating,
//   };
// }
//
// class Image {
//   int? id;
//   int? storyId;
//   String? imageUrl;
//   String? createdAt;
//   String? updatedAt;
//
//   Image({
//     this.id,
//     this.storyId,
//     this.imageUrl,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//     id: json["id"],
//     storyId: json["story_id"],
//     imageUrl: json["image_url"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "story_id": storyId,
//     "image_url": imageUrl,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
