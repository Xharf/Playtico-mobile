import 'base_network.dart';
class SongDataSource {
  static SongDataSource instance = SongDataSource();

  Future<Map<String, dynamic>> loadSongs() {
    return BaseNetwork.get("songs");
  }

  Future<Map<String, dynamic>> getSongsById(String id) {
    return BaseNetwork.get("songs/$id");
  }

  Future<Map<String, dynamic>> loadPlaylists(String token) {
    return BaseNetwork.getPlaylists("playlists", token);
  }
}