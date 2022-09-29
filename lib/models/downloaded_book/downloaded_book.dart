import 'dart:io';

import 'package:equatable/equatable.dart';

class DownloadedBook extends Equatable {
  final String idBook;
  final File? fileBook;

  const DownloadedBook({this.idBook = '', this.fileBook});

  static const empty = DownloadedBook();

  @override
  List<Object?> get props => [idBook];
}
