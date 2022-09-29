part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteEvent extends FavoriteEvent {}

class RefreshFavoriteEvent extends FavoriteEvent {}

class AddFavoriteEvent extends FavoriteEvent {
  final FavoriteBook addedFavoriteBooks;

  const AddFavoriteEvent(this.addedFavoriteBooks);

  @override
  List<Object> get props => [addedFavoriteBooks];
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final String removedFavoriteIdBooks;

  const RemoveFavoriteEvent(this.removedFavoriteIdBooks);

  @override
  List<Object> get props => [removedFavoriteIdBooks];
}
