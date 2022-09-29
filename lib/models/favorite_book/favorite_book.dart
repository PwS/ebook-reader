import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'favorite_book.g.dart';

@HiveType(typeId: 0)
class FavoriteBook extends Equatable {
  @HiveField(0)
  final String idFavoriteBook;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String coverImage;
  @HiveField(3)
  final String authors;
  @HiveField(4)
  final List<String> genre;
  @HiveField(5)
  final String synopsis;

  const FavoriteBook(
      {this.idFavoriteBook = '',
      this.title = 'Unknown',
      this.coverImage = '',
      this.authors = 'Unknown',
      this.genre = const <String>[],
      this.synopsis = 'Unknown'});

  static const empty = FavoriteBook();

  factory FavoriteBook.fromJson(Map<String, dynamic> json) {
    return FavoriteBook(
        idFavoriteBook: json['idFavoriteBook'],
        title: json['title'],
        coverImage: json['coverImage'],
        authors: json['authors'],
        genre: (json['genre'] ?? <String>[]).cast<String>(),
        synopsis: json['synopsis']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idFavoriteBook'] = idFavoriteBook;
    data['title'] = title;
    data['coverImage'] = coverImage;
    data['authors'] = authors;
    data['genre'] = genre;
    data['synopsis'] = synopsis;
    return data;
  }

  @override
  String toString() {
    return '$idFavoriteBook - $title - $coverImage - $authors - $genre - $synopsis';
  }

  @override
  List<Object?> get props => [idFavoriteBook];
}
