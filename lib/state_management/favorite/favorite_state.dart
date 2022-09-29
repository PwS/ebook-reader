part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteErrorState extends FavoriteState {}

class FavoriteLoadedState extends FavoriteState {
  final List<FavoriteBook> listBooksFavorite;

  const FavoriteLoadedState({this.listBooksFavorite = const <FavoriteBook>[]});

  FavoriteLoadedState copyWith({List<FavoriteBook>? listBooksFavorite}) {
    return FavoriteLoadedState(
        listBooksFavorite: listBooksFavorite ?? this.listBooksFavorite);
  }

  @override
  List<Object> get props => [listBooksFavorite];
}
