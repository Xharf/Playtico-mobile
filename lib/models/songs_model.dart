class SongsModel {
  List<Songs>? songs;
  SongsModel({this.songs});
  SongsModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? iso2;
  String? iso3;
  Songs({this.name, this.iso2, this.iso3});
  Songs.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iso2 = json['iso2'];
    iso3 = json['iso3'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    return data;
  }
}