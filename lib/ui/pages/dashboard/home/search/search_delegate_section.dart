import 'package:ebook/models/books/book.dart';
import 'package:ebook/services/book/book_service.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  String errorLink =
      "https://img.freepik.com/free-vector/funny-error-404-background-design_1167-219.jpg?w=740&t=st=1658904599~exp=1658905199~hmac=131d690585e96267bbc45ca0978a85a2f256c7354ce0f18461cd030c5968011c";

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
                onTap: () {},
                leading: Image.network(snapshot
                        .data?.items[index].volumeInfo.imageLinks.thumbnail ??
                    errorLink),
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
                  leading: Image.network(snapshot
                          .data?.items[index].volumeInfo.imageLinks.thumbnail ??
                      errorLink),
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
