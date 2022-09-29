import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ebook/models/downloaded_book/downloaded_book.dart';
import 'package:ebook/services/download/download_service.dart';
import 'package:equatable/equatable.dart';

part 'download_book_event.dart';

part 'download_book_state.dart';

class DownloadBookBloc extends Bloc<DownloadBookEvent, DownloadBookState> {
  DownloadBookBloc({required DownloadService downloadService})
      : _downloadService = downloadService,
        super(DownloadBookLoadingState()) {
    on<LoadDownloadBookEvent>(_onLoadDownloadBookEvent);
    on<RefreshDownloadBookEvent>(_onRefreshDownloadBookEvent);
    on<AddDownloadBookEvent>(_onAddDownloadBookEvent);
    on<RemoveDownloadBookEvent>(_onRemoveDownloadBookEvent);
  }

  final DownloadService _downloadService;

  FutureOr<void> _onLoadDownloadBookEvent(
      LoadDownloadBookEvent event, Emitter<DownloadBookState> emit) async {
    try {
      final List<DownloadedBook> listDownloadedBook =
          await _downloadService.getListDownloadedBooks();
      emit(DownloadBookLoadedState(listDownloadedBooks: listDownloadedBook));
    } catch (_) {
      emit(DownloadBookErrorState());
    }
  }

  FutureOr<void> _onRefreshDownloadBookEvent(
      RefreshDownloadBookEvent event, Emitter<DownloadBookState> emit) async {}

  FutureOr<void> _onAddDownloadBookEvent(
      AddDownloadBookEvent event, Emitter<DownloadBookState> emit) async {
    try{

    }catch(_){
      emit(DownloadBookErrorState());
    }
  }

  FutureOr<void> _onRemoveDownloadBookEvent(
      RemoveDownloadBookEvent event, Emitter<DownloadBookState> emit) async {}
}
