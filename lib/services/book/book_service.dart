import 'package:ebook/models/books/book.dart';
import 'package:ebook/services/book/base_book_service.dart';
import 'package:ebook/services/config/dio_client.dart';

class BookService implements BaseBookService {
  ///SingleTon
  BookService._privateConstructor();

  static final BookService _instance = BookService._privateConstructor();

  factory BookService() {
    return _instance;
  }

  final _client = DioClient();

  @override
  Future<List<Book>> getBooks() async {
    List<Book> listBook = [];
    try {
      final response = await _client.getRequest(
          'https://www.googleapis.com/books/v1/volumes?q=aime&maxResults=40');
      if (response.statusCode == 200) {
        final result = ResponseBook.fromJson(response.data);
        listBook = result.items;
      }
      return listBook;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<List<Book>> searchBooks(String searchBook) async {
    List<Book> listBook = [];
    try {
      final response = await _client.getRequest(
          'https://www.googleapis.com/books/v1/volumes?q=$searchBook&maxResults=40');
      if (response.statusCode == 200) {
        final result = ResponseBook.fromJson(response.data);
        listBook = result.items;
      }
      return listBook;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<ResponseBook> searchBooksResponse(String searchBook) async {
    ResponseBook responseResult = ResponseBook.empty;
    try {
      final response = await _client.getRequest(
          'https://www.googleapis.com/books/v1/volumes?q=$searchBook&maxResults=40');
      if (response.statusCode == 200) {
        final result = ResponseBook.fromJson(response.data);
        responseResult = result;
      }
      return responseResult;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
