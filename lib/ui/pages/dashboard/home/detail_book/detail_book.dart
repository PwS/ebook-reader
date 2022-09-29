import 'package:ebook/models/book/access_info/access_info.dart';
import 'package:ebook/models/book/book.dart';
import 'package:ebook/models/favorite_book/favorite_book.dart';
import 'package:ebook/services/favorite/favorite_service.dart';
import 'package:ebook/state_management/favorite/favorite_bloc.dart';
import 'package:ebook/ui/custom_widgets/snackbar/custom_snackbar.dart';
import 'package:ebook/utils/constant/assets_path.dart';
import 'package:ebook/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBook extends StatelessWidget {
  final Book detailBooks;

  const DetailBook({Key? key, required this.detailBooks}) : super(key: key);

  String getUrl(Epub? epub, Pdf? pdf) {
    String result = '';
    if (epub == null) {
      if (pdf == null) {
        return result;
      }
      if (pdf.acsTokenLink == null) {
        return result;
      }
      result = pdf.acsTokenLink!;
      return result;
    }
    if (epub.downloadLink == null) {
      return result;
    }
    result = epub.downloadLink!;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          children: <Widget>[
            _ThumbnailsBook(
              urlThumbnail: detailBooks.volumeInfo.imageLinks.thumbnail,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(child: Text(detailBooks.volumeInfo.title)),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Text(detailBooks.volumeInfo.authors.isEmpty
                  ? 'Unknown'
                  : detailBooks.volumeInfo.authors.first),
            ),
            const SizedBox(
              height: 10,
            ),
            RepositoryProvider<FavoriteService>(
              create: (context) => FavoriteService(),
              child: BlocProvider<FavoriteBloc>(
                create: (context) => FavoriteBloc(
                    favoriteService: context.read<FavoriteService>())
                  ..add(LoadFavoriteEvent()),
                child: _OptionsSection(
                    urlPreview: detailBooks.volumeInfo.previewLink,
                    bookId: detailBooks.id,
                    coverImage: detailBooks.volumeInfo.imageLinks.thumbnail,
                    title: detailBooks.volumeInfo.title,
                    authors: detailBooks.volumeInfo.authors.isEmpty
                        ? 'Unknown'
                        : detailBooks.volumeInfo.authors.first,
                    synopsis: detailBooks.volumeInfo.description,
                    genre: detailBooks.volumeInfo.categories),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _DetailBook(
                author: detailBooks.volumeInfo.authors.isEmpty
                    ? 'Unknown'
                    : detailBooks.volumeInfo.authors.first,
                publisher: detailBooks.volumeInfo.publisher == ''
                    ? 'Unknown'
                    : detailBooks.volumeInfo.publisher,
                publishedDate: detailBooks.volumeInfo.publishedDate == ''
                    ? 'Unknown'
                    : detailBooks.volumeInfo.publishedDate,
                categories: detailBooks.volumeInfo.categories.isEmpty
                    ? 'Unknown '
                    : detailBooks.volumeInfo.categories.first),
            _SynopsisBook(
              synopsisBook: detailBooks.volumeInfo.description == ''
                  ? 'Unknown'
                  : detailBooks.volumeInfo.description,
            ),
          ],
        ),
        bottomSheet: _DownloadButton(
          downloadUrl:
              getUrl(detailBooks.accessInfo.epub, detailBooks.accessInfo.pdf),
        ),
      ),
    );
  }
}

class _ThumbnailsBook extends StatelessWidget {
  final String? urlThumbnail;

  const _ThumbnailsBook({Key? key, this.urlThumbnail}) : super(key: key);

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

class _OptionsSection extends StatelessWidget {
  final String urlPreview;
  final String bookId;
  final String coverImage;
  final String title;
  final String authors;
  final String synopsis;
  final List<String> genre;

  const _OptionsSection(
      {Key? key,
      required this.urlPreview,
      required this.bookId,
      required this.coverImage,
      required this.title,
      required this.authors,
      required this.synopsis,
      required this.genre})
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () async {
            Uri url = Uri.parse(urlPreview);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              CustomShowSnackBar.basicSnackBar(
                  context, Colors.red, 'could not launch $url');
            }
          },
          style: OutlinedButton.styleFrom(side: const BorderSide(width: 1)),
          child: Text(
            'View Online',
            style:
                Theme.of(context).textTheme.headline4?.copyWith(fontSize: 14),
          ),
        ),
        BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoadedState) {
              return OutlinedButton.icon(
                onPressed: () => isFavorited(state.listBooksFavorite, bookId)
                    ? context
                        .read<FavoriteBloc>()
                        .add(RemoveFavoriteEvent(bookId))
                    : context.read<FavoriteBloc>().add(AddFavoriteEvent(
                        FavoriteBook(
                            idFavoriteBook: bookId,
                            synopsis: synopsis,
                            authors: authors,
                            title: title,
                            coverImage: coverImage,
                            genre: genre))),
                style:
                    OutlinedButton.styleFrom(side: const BorderSide(width: 1)),
                icon: isFavorited(state.listBooksFavorite, bookId)
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

class _DetailBook extends StatelessWidget {
  final String author;
  final String publisher;
  final String publishedDate;
  final String categories;

  const _DetailBook(
      {Key? key,
      required this.author,
      required this.publisher,
      required this.publishedDate,
      required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontSize: 20,
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Author",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Publisher",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(fontSize: 16)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Published Date",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(fontSize: 16)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Categorie",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(fontSize: 16))
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
                      author,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      publisher,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      publishedDate,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      categories,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(fontSize: 16),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _SynopsisBook extends StatelessWidget {
  final String synopsisBook;

  const _SynopsisBook({Key? key, required this.synopsisBook}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          synopsisBook,
          style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}

class _DownloadButton extends StatelessWidget {
  final String downloadUrl;

  const _DownloadButton({Key? key, required this.downloadUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () async {
          if (downloadUrl == '') {
            return CustomShowSnackBar.basicSnackBar(
                context, Colors.red, 'Downloads Link Not Available');
          } else {
            logger.i(downloadUrl);
          }
        },
        child: Text(
          'Download',
          style: Theme.of(context)
              .textTheme
              .headline2
              ?.copyWith(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
