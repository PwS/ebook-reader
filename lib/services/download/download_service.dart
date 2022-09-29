import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ebook/models/downloaded_book/downloaded_book.dart';
import 'package:ebook/services/download/base_download_service.dart';
import 'package:path_provider/path_provider.dart';

class DownloadService implements BaseDownloadService {
  ///SingleTon
  DownloadService._privateConstructor();

  static final DownloadService _instance =
      DownloadService._privateConstructor();

  factory DownloadService() {
    return _instance;
  }

  final dio = Dio();

  @override
  Future<Directory> getApplicationDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  @override
  Future<File> getFileDownloadedBook() {
    // TODO: implement getFileDownloadedBook
    throw UnimplementedError();
  }

  @override
  Future<List<DownloadedBook>> getListDownloadedBooks() async {
    List<DownloadedBook> listDownloadedBook = [];
    try {
      Directory dir = await getApplicationDirectory();
      print(dir);
      return listDownloadedBook;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<DownloadedBook> addDownloadedBooks(
      String idBooks, String downloadUrl) async {
    try {
      return DownloadedBook();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<DownloadedBook> removeDownloadedBooks(
      String removedFavoriteIdBooks) async {
    throw UnimplementedError();
  }
}
