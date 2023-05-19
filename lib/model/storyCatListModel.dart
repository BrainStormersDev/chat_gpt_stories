class StoryCatListModel {
  bool? status;
  String? message;
  Search? search;
  List<DataList>? data;

  StoryCatListModel({this.status, this.message, this.search, this.data});

  StoryCatListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    search =
    json['search'] != null ? new Search.fromJson(json['search']) : null;
    if (json['data'] != null) {
      data = <DataList>[];
      json['data'].forEach((v) {
        data!.add(DataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.search != null) {
      data['search'] = this.search!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Search {
  String? catId;

  Search({this.catId});

  Search.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    return data;
  }
}

class DataList {
  int? id;
  String? storyTitle;
  String? story;
  String? storyNote;
  List<Images>? images;
  int? viewCount;

  DataList({this.id, this.storyTitle, this.story, this.storyNote, this.images, this.viewCount});

  DataList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storyTitle = json['story_title'];
    story = json['story'];
    storyNote = json['story_note'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
      viewCount = json['view_count'];
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
    data['view_count'] = this.viewCount;
    return data;
  }
}

class Images {
  int? id;
  int? storyId;
  String? imageUrl;
  dynamic createdAt;
  dynamic updatedAt;

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
