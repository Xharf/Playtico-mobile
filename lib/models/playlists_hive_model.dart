import 'package:hive/hive.dart';
part 'playlists_hive_model.g.dart';

@HiveType(typeId: 0)
class PlaylistHive extends HiveObject{
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(3)
  String? cover;

  @HiveField(4)
  String? username;

  PlaylistHive({
    required this.id,
    required this.name,
    required this.cover,
    required this.username,
  });

}