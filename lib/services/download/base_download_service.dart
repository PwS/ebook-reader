import 'dart:io';

import 'package:ebook/models/downloaded_book/downloaded_book.dart';

abstract class BaseDownloadService {
  Future<Directory> getApplicationDirectory();

  Future<File> getFileDownloadedBook();

  Future<List<DownloadedBook>> getListDownloadedBooks();

  Future<DownloadedBook> addDownloadedBooks(String idBooks, String downloadUrl);

  Future<DownloadedBook> removeDownloadedBooks(String removedFavoriteIdBooks);
}
