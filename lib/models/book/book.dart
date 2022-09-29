import 'package:ebook/models/book/access_info/access_info.dart';
import 'package:ebook/models/book/sales_info/sales_info.dart';
import 'package:ebook/models/book/search_info/search_info.dart';
import 'package:ebook/models/book/volume_info/volume_info.dart';

class ResponseBook {
  final String kind;
  final int totalItems;
  final List<Book> items;

  const ResponseBook(
      {required this.kind, required this.totalItems, required this.items});

  static const empty = ResponseBook(kind: '', totalItems: 0, items: []);

  factory ResponseBook.fromJson(Map<String, dynamic> json) {
    return ResponseBook(
        kind: json['kind'],
        totalItems: json['totalItems'],
        items: List<Book>.from(json['items'].map((x) => Book.fromJson(x))));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['totalItems'] = totalItems;
    data['items'] = items.map((v) => v.toJson()).toList();
    return data;
  }
}

class Book {
  final String kind;
  final String id;
  final String etag;
  final String selfLink;
  final VolumeInfo volumeInfo;
  final SaleInfo saleInfo;
  final AccessInfo accessInfo;
  final SearchInfo searchInfo;

  Book(
      {required this.kind,
      required this.id,
      required this.etag,
      required this.selfLink,
      required this.volumeInfo,
      required this.saleInfo,
      required this.accessInfo,
      required this.searchInfo});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        kind: json['kind'],
        id: json['id'],
        etag: json['etag'],
        selfLink: json['selfLink'],
        volumeInfo: VolumeInfo.fromJson(json['volumeInfo']),
        saleInfo: SaleInfo.fromJson(json['saleInfo']),
        accessInfo: AccessInfo.fromJson(json['accessInfo']),
        searchInfo: json['searchInfo'] == null
            ? SearchInfo.empty
            : SearchInfo.fromJson(json['searchInfo']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    data['id'] = id;
    data['etag'] = etag;
    data['selfLink'] = selfLink;
    data['volumeInfo'] = volumeInfo.toJson();
    data['saleInfo'] = saleInfo.toJson();
    data['accessInfo'] = accessInfo.toJson();
    data['searchInfo'] = searchInfo.toJson();
    return data;
  }

  @override
  String toString() {
    return '$kind - $id - $etag - $selfLink';
  }
}
