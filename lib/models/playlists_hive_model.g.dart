// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlists_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistHiveAdapter extends TypeAdapter<PlaylistHive> {
  @override
  final int typeId = 0;

  @override
  PlaylistHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlaylistHive(
      id: fields[0] as String?,
      name: fields[1] as String?,
      cover: fields[3] as String?,
      username: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlaylistHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.cover)
      ..writeByte(4)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
