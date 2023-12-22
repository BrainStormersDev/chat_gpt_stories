class StoryWatchedModel {
  bool? status;
  String? message;
  List<Data>? data;

  StoryWatchedModel({this.status, this.message, this.data});

  StoryWatchedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? storyId;
  int? userId;
  Story? story;

  Data({this.id, this.storyId, this.userId, this.story});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storyId = json['story_id'];
    userId = json['user_id'];
    story = json['story'] != null ? new Story.fromJson(json['story']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['story_id'] = this.storyId;
    data['user_id'] = this.userId;
    if (this.story != null) {
      data['story'] = this.story!.toJson();
    }
    return data;
  }
}

class Story {
  int? id;
  String? storyTitle;
  int? createdBy;
  int? viewCount;
  String? created;
 var averageRating;
  var storyImages;

  Story(
      {this.id,
        this.storyTitle,
        this.createdBy,
        this.viewCount,
        this.created,
        this.averageRating,
        this.storyImages});

  Story.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storyTitle = json['story_title'];
    createdBy = json['created_by'];
    viewCount = json['view_count'];
    created = json['created'];
    averageRating = json['average_rating'];
    if (json['images'] != null) {
      storyImages = <StoryImages>[];
      json['images'].forEach((v) {
        storyImages!.add(new StoryImages.fromJson(v));
      });
    }


    if (json['story_images'] != null) {
      storyImages = <StoryImages>[];
      json['story_images'].forEach((v) {
        storyImages!.add(new StoryImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['story_title'] = this.storyTitle;
    data['created_by'] = this.createdBy;
    data['view_count'] = this.viewCount;
    data['created'] = this.created;
    data['average_rating'] = this.averageRating;
    if (this.storyImages != null) {
      data['story_images'] = this.storyImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoryImages {
  var id;
  var storyId;
  var imageUrl;
  var createdAt;
  var updatedAt;

  StoryImages(
      {this.id, this.storyId, this.imageUrl, this.createdAt, this.updatedAt});

  StoryImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storyId = json['story_id'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['story_id'] = this.storyId;
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
