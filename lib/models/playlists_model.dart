class UserPlaylistModel {
  String? status;
  Data? data;

  UserPlaylistModel({this.status, this.data});

  UserPlaylistModel.fromJson(Map<String, dynamic> json) {
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
  List<Playlists>? playlists;

  Data({this.playlists});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['playlists'] != null) {
      playlists = <Playlists>[];
      json['playlists'].forEach((v) {
        playlists!.add(new Playlists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playlists != null) {
      data['playlists'] = this.playlists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Playlists {
  String? id;
  String? name;
  String? cover;
  String? username;

  Playlists({this.id, this.name, this.cover, this.username});

  Playlists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cover = json['cover'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cover'] = this.cover;
    data['username'] = this.username;
    return data;
  }
}
