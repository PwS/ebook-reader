import 'package:ebook/models/book/book.dart';

abstract class BaseBookService {
  Future<List<Book>> getBooks();

  Future<ResponseBook> searchBooksResponse(String searchBook);

  Future<List<Book>> searchBooks(String searchBook);
}
