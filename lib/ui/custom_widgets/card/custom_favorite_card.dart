import 'package:ebook/models/favorite_book/favorite_book.dart';
import 'package:ebook/state_management/favorite/favorite_bloc.dart';
import 'package:ebook/utils/constant/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFavoriteCard extends StatelessWidget {
  final FavoriteBook dataFavoriteBook;

  const CustomFavoriteCard({Key? key, required this.dataFavoriteBook})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              _ThumbnailsFavoriteBook(
                urlThumbnail: dataFavoriteBook.coverImage,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: _QuickInformationFavoriteBook(
                  dataFavoriteBook: dataFavoriteBook,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _ThumbnailsFavoriteBook extends StatelessWidget {
  final String? urlThumbnail;

  const _ThumbnailsFavoriteBook({Key? key, this.urlThumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: urlThumbnail == null
            ? SvgPicture.asset(AssetsPath.illustrations_404)
            : Image(
                image: NetworkImage(urlThumbnail!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

class _QuickInformationFavoriteBook extends StatelessWidget {
  final FavoriteBook dataFavoriteBook;

  const _QuickInformationFavoriteBook(
      {Key? key, required this.dataFavoriteBook})
      : super(key: key);

  bool isFavorited(List<FavoriteBook> listFavoriteBooks, String booksId) {
    for (var items in listFavoriteBooks) {
      if (items.idFavoriteBook == booksId) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Text('Authors',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataFavoriteBook.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 25,
                  ),
                  Text(
                    dataFavoriteBook.authors,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoadedState) {
              return OutlinedButton.icon(
                onPressed: () => isFavorited(state.listBooksFavorite,
                        dataFavoriteBook.idFavoriteBook)
                    ? context.read<FavoriteBloc>().add(
                        RemoveFavoriteEvent(dataFavoriteBook.idFavoriteBook))
                    : context.read<FavoriteBloc>().add(AddFavoriteEvent(
                        FavoriteBook(
                            idFavoriteBook: dataFavoriteBook.idFavoriteBook,
                            synopsis: dataFavoriteBook.synopsis,
                            authors: dataFavoriteBook.authors,
                            title: dataFavoriteBook.title,
                            coverImage: dataFavoriteBook.coverImage,
                            genre: dataFavoriteBook.genre))),
                style:
                    OutlinedButton.styleFrom(side: const BorderSide(width: 1)),
                icon: isFavorited(state.listBooksFavorite,
                        dataFavoriteBook.idFavoriteBook)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        color: Colors.black,
                      ),
                label: Text(
                  'Favorite',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(fontSize: 14),
                ),
              );
            } else {
              return const Expanded(
                child: Center(
                  child: Text("Opps! Something Went Wrong outside the state!",
                      overflow: TextOverflow.ellipsis),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
