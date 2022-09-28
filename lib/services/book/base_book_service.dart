import 'package:ebook/models/books/book.dart';

abstract class BaseBookService {
  Future<List<Book>> getBooks();

  Future<ResponseBook> searchBooksResponse(String searchBook);

  Future<List<Book>> searchBooks(String searchBook);
}
