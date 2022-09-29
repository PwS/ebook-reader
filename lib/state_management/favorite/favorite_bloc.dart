import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ebook/models/favorite_book/favorite_book.dart';
import 'package:ebook/services/favorite/favorite_service.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({required FavoriteService favoriteService})
      : _favoriteService = favoriteService,
        super(FavoriteLoadingState()) {
    on<LoadFavoriteEvent>(_onLoadFavoriteEvent);
    on<RefreshFavoriteEvent>(_onRefreshFavoriteEvent);
    on<AddFavoriteEvent>(_onAddFavoriteEvent);
    on<RemoveFavoriteEvent>(_onRemoveFavoriteEvent);
  }

  final FavoriteService _favoriteService;

  FutureOr<void> _onLoadFavoriteEvent(
      LoadFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      final List<FavoriteBook> listFavoriteBooks =
          await _favoriteService.getListFavoriteBooks();
      emit(FavoriteLoadedState(listBooksFavorite: listFavoriteBooks));
    } catch (_) {
      emit(FavoriteErrorState());
    }
  }

  FutureOr<void> _onRefreshFavoriteEvent(
      RefreshFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      final List<FavoriteBook> listFavoriteBooks =
          await _favoriteService.getListFavoriteBooks();
      emit(FavoriteLoadedState(listBooksFavorite: listFavoriteBooks));
    } catch (_) {
      emit(FavoriteErrorState());
    }
  }

  FutureOr<void> _onAddFavoriteEvent(
      AddFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      final List<FavoriteBook> listFavoriteBooks =
          await _favoriteService.addFavoriteBooks(event.addedFavoriteBooks);
      emit(FavoriteLoadedState(listBooksFavorite: listFavoriteBooks));
    } catch (_) {
      emit(FavoriteErrorState());
    }
  }

  FutureOr<void> _onRemoveFavoriteEvent(
      RemoveFavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      final List<FavoriteBook> listFavoriteBooks = await _favoriteService
          .removeFavoriteBooks(event.removedFavoriteIdBooks);
      emit(FavoriteLoadedState(listBooksFavorite: listFavoriteBooks));
    } catch (_) {
      emit(FavoriteErrorState());
    }
  }
}
