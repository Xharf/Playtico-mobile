class SongsModel {
  final String? status;
  final Data? data;

  SongsModel({
    this.status,
    this.data,
  });

  SongsModel.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'data' : data?.toJson()
  };
}

class Data {
  final List<Songs>? songs;

  Data({
    this.songs,
  });

  Data.fromJson(Map<String, dynamic> json)
      : songs = (json['songs'] as List?)?.map((dynamic e) => Songs.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = new Map<String, dynamic>();
   // 'songs' : songs?.map((e) => e.toJson()).toList()
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

  Songs({
    this.id,
    this.title,
    this.performer,
    this.cover,
    this.song,
  });

  Songs.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        performer = json['performer'],
        cover = json['cover'],
        song = json['song'];

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