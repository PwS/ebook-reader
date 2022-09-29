part of 'download_book_bloc.dart';

abstract class DownloadBookState extends Equatable {
  const DownloadBookState();

  @override
  List<Object> get props => [];
}

class DownloadBookProgressLoading extends DownloadBookState {
  final int progress;

  const DownloadBookProgressLoading({this.progress = 0});

  DownloadBookProgressLoading copyWith({int? progress}) {
    return DownloadBookProgressLoading(progress: progress ?? this.progress);
  }

  @override
  List<Object> get props => [progress];
}

class DownloadBookLoadingState extends DownloadBookState {}

class DownloadBookErrorState extends DownloadBookState {}

class DownloadBookLoadedState extends DownloadBookState {
  final List<DownloadedBook> listDownloadedBooks;

  const DownloadBookLoadedState(
      {this.listDownloadedBooks = const <DownloadedBook>[]});

  DownloadBookLoadedState copyWith(
      {List<DownloadedBook>? listDownloadedBooks}) {
    return DownloadBookLoadedState(
        listDownloadedBooks: listDownloadedBooks ?? this.listDownloadedBooks);
  }

  @override
  List<Object> get props => [listDownloadedBooks];
}
