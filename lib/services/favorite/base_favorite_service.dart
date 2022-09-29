import 'package:ebook/models/favorite_book/favorite_book.dart';

abstract class BaseFavoriteService {
  Future<List<FavoriteBook>> getListFavoriteBooks();

  Future<List<FavoriteBook>> addFavoriteBooks(FavoriteBook addedBooks);

  Future<List<FavoriteBook>> removeFavoriteBooks(String removedFavoriteIdBooks);
}
