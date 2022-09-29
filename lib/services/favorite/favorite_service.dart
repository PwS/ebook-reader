import 'package:ebook/db/database.dart';
import 'package:ebook/models/favorite_book/favorite_book.dart';
import 'package:ebook/services/favorite/base_favorite_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteService implements BaseFavoriteService {
  ///SingleTon
  FavoriteService._privateConstructor();

  static final FavoriteService _instance =
      FavoriteService._privateConstructor();

  factory FavoriteService() {
    return _instance;
  }

  @override
  Future<List<FavoriteBook>> getListFavoriteBooks() async {
    List<FavoriteBook> listBook = [];
    try {
      var dataBox = await Hive.openBox<FavoriteBook>(BoxName.favoriteBox);
      dataBox.toMap().forEach((key, value) => listBook.add(FavoriteBook(
          title: value.title,
          coverImage: value.coverImage,
          authors: value.authors,
          idFavoriteBook: value.idFavoriteBook,
          synopsis: value.synopsis,
          genre: value.genre)));
      return listBook;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<FavoriteBook>> addFavoriteBooks(FavoriteBook addedBooks) async {
    List<FavoriteBook> listBook = [];
    try {
      var dataBox = await Hive.openBox<FavoriteBook>(BoxName.favoriteBox);
      dataBox.put(addedBooks.idFavoriteBook, addedBooks);
      dataBox.toMap().forEach((key, value) => listBook.add(FavoriteBook(
          title: value.title,
          coverImage: value.coverImage,
          authors: value.authors,
          idFavoriteBook: value.idFavoriteBook,
          synopsis: value.synopsis,
          genre: value.genre)));
      return listBook;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<FavoriteBook>> removeFavoriteBooks(
      String removedFavoriteIdBooks) async {
    List<FavoriteBook> listBook = [];
    try {
      var dataBox = await Hive.openBox<FavoriteBook>(BoxName.favoriteBox);
      dataBox.delete(removedFavoriteIdBooks);
      dataBox.toMap().forEach((key, value) => listBook.add(FavoriteBook(
          title: value.title,
          coverImage: value.coverImage,
          authors: value.authors,
          idFavoriteBook: value.idFavoriteBook,
          synopsis: value.synopsis,
          genre: value.genre)));
      return listBook;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
