import 'package:ebook/models/book/book.dart';
import 'package:ebook/services/book/book_service.dart';
import 'package:ebook/ui/pages/dashboard/home/detail_book/detail_book.dart';
import 'package:ebook/utils/constant/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: BookService().searchBooksResponse(query),
      builder: (context, AsyncSnapshot<ResponseBook> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Opps! Try again later!"),
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailBook(
                              detailBooks: snapshot.data!.items[index],
                            ))),
                leading: (snapshot.data == null ||
                        snapshot.data?.items[index].volumeInfo.imageLinks
                                .thumbnail ==
                            null)
                    ? SvgPicture.asset(AssetsPath.illustrations_404)
                    : Image.network(snapshot
                        .data!.items[index].volumeInfo.imageLinks.thumbnail),
                title: Text(
                  "${snapshot.data == null ? 'Not Found' : snapshot.data!.items[index].volumeInfo.authors.isNotEmpty ? snapshot.data?.items[index].volumeInfo.authors[0] : "Not Found"}",
                ),
                subtitle: Text(
                  "${snapshot.data?.items[index].volumeInfo.title}",
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: BookService().searchBooksResponse('Biography'),
      builder: (context, AsyncSnapshot<ResponseBook> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Opps! Try again later!"),
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () {},
                  leading: (snapshot.data == null ||
                          snapshot.data?.items[index].volumeInfo.imageLinks
                                  .thumbnail ==
                              null)
                      ? SvgPicture.asset(AssetsPath.illustrations_404)
                      : Image.network(snapshot
                          .data!.items[index].volumeInfo.imageLinks.thumbnail),
                  title: Text(
                    "${snapshot.data == null ? 'Not Found' : snapshot.data!.items[index].volumeInfo.authors.isNotEmpty ? snapshot.data?.items[index].volumeInfo.authors[0] : "Not Found"}",
                  ),
                  subtitle:
                      Text("${snapshot.data?.items[index].volumeInfo.title}"));
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );
  }
}
