part of 'download_book_bloc.dart';

abstract class DownloadBookEvent extends Equatable {
  const DownloadBookEvent();

  @override
  List<Object> get props => [];
}

class LoadDownloadBookEvent extends DownloadBookEvent {}

class RefreshDownloadBookEvent extends DownloadBookEvent {}

class AddDownloadBookEvent extends DownloadBookEvent {
  final String idBooks;
  final String urlDownloadBook;

  const AddDownloadBookEvent(this.idBooks, this.urlDownloadBook);

  @override
  List<Object> get props => [idBooks];
}

class RemoveDownloadBookEvent extends DownloadBookEvent {
  final String removedDownloadedBookIdBooks;

  const RemoveDownloadBookEvent(this.removedDownloadedBookIdBooks);

  @override
  List<Object> get props => [removedDownloadedBookIdBooks];
}
