class SongGetSpecificModel {
  String? status;
  Data? data;

  SongGetSpecificModel({this.status, this.data});

  SongGetSpecificModel.fromJson(Map<String, dynamic> json) {
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
  Song? song;

  Data({this.song});

  Data.fromJson(Map<String, dynamic> json) {
    song = json['song'] != null ? new Song.fromJson(json['song']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.song != null) {
      data['song'] = this.song!.toJson();
    }
    return data;
  }
}

class Song {
  String? id;
  String? title;
  int? year;
  String? performer;
  String? genre;
  int? duration;
  String? cover;
  String? song;
  String? insertedAt;
  String? updatedAt;

  Song(
      {this.id,
        this.title,
        this.year,
        this.performer,
        this.genre,
        this.duration,
        this.cover,
        this.song,
        this.insertedAt,
        this.updatedAt});

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    performer = json['performer'];
    genre = json['genre'];
    duration = json['duration'];
    cover = json['cover'];
    song = json['song'];
    insertedAt = json['insertedAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['year'] = this.year;
    data['performer'] = this.performer;
    data['genre'] = this.genre;
    data['duration'] = this.duration;
    data['cover'] = this.cover;
    data['song'] = this.song;
    data['insertedAt'] = this.insertedAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
