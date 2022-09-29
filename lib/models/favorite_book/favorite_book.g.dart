// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteBookAdapter extends TypeAdapter<FavoriteBook> {
  @override
  final int typeId = 0;

  @override
  FavoriteBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteBook(
      idFavoriteBook: fields[0] as String,
      title: fields[1] as String,
      coverImage: fields[2] as String,
      authors: fields[3] as String,
      genre: (fields[4] as List).cast<String>(),
      synopsis: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteBook obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.idFavoriteBook)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.coverImage)
      ..writeByte(3)
      ..write(obj.authors)
      ..writeByte(4)
      ..write(obj.genre)
      ..writeByte(5)
      ..write(obj.synopsis);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
