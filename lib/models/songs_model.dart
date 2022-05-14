class SongsModel {
  String? status;
  Data? data;

  SongsModel({this.status, this.data});

  SongsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Songs>? songs;

  Data({this.songs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['songs'] != null) {
      songs = <Songs>[];
      json['songs'].forEach((v) {
        songs!.add(new Songs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.songs != null) {
      data['songs'] = this.songs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Songs {
  String? id;
  String? title;
  String? performer;
  String? cover;
  String? song;

  Songs({this.id, this.title, this.performer, this.cover, this.song});

  Songs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    performer = json['performer'];
    cover = json['cover'];
    song = json['song'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['performer'] = this.performer;
    data['cover'] = this.cover;
    data['song'] = this.song;
    return data;
  }
}