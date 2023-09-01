class GetStoryModels {
  bool? status;
  String? message;
  Search? search;
  DataOfStory? data;

  GetStoryModels({this.status, this.message, this.search, this.data});

  GetStoryModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    search =
    json['search'] != null ? new Search.fromJson(json['search']) : null;
    data = json['data'] != null ? new DataOfStory.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.search != null) {
      data['search'] = this.search!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Search {
  String? search;
  String? q;

  Search({this.search, this.q});

  Search.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    q = json['q'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['q'] = this.q;
    return data;
  }
}

class DataOfStory {
  int? id;
  String? storyTitle;
  String? story;
  var storyNote;
  var images;
  // List<Images>? images;

  DataOfStory({this.id, this.storyTitle, this.story, this.storyNote, this.images});

  DataOfStory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storyTitle = json['story_title'];
    story = json['story'];
    storyNote = json['story_note'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['story_title'] = this.storyTitle;
    data['story'] = this.story;
    data['story_note'] = this.storyNote;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  var id;
  var storyId;
  var imageUrl;
  var createdAt;
  var updatedAt;

  Images(
      {this.id, this.storyId, this.imageUrl, this.createdAt, this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
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
