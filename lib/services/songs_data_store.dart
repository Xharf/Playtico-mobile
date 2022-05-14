import 'base_network.dart';
class SongDataSource {
  static SongDataSource instance = SongDataSource();

  Future<Map<String, dynamic>> loadSongs() {
    return BaseNetwork.get("songs");
  }
}