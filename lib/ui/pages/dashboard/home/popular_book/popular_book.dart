import 'package:ebook/models/book/book.dart';
import 'package:ebook/services/book/book_service.dart';
import 'package:ebook/ui/pages/dashboard/home/detail_book/detail_book.dart';
import 'package:flutter/material.dart';

class PopularBook extends StatelessWidget {
  const PopularBook({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: BookService().searchBooksResponse('popular'),
        builder: (context, AsyncSnapshot<ResponseBook> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Opps! Try again later!"),
            );
          }
          if (snapshot.hasData) {
            return LayoutBuilder(builder: (context, constraints) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 30,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailBook(
                                  detailBooks: snapshot.data!.items[index],
                                ))),
                    child: SizedBox(
                      width: constraints.maxWidth * 0.8,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Card(
                                elevation: 2,
                                margin: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: SizedBox(
                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth * 0.30,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image(
                                      image: NetworkImage(
                                          "${snapshot.data?.items[index].volumeInfo.imageLinks.thumbnail}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: constraints.maxWidth * 0.03),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    snapshot.data == null
                                        ? 'Unknown'
                                        : "${snapshot.data!.items[index].volumeInfo.authors.isNotEmpty ? snapshot.data?.items[index].volumeInfo.authors[0] : "Censored"}",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                          fontSize:
                                              constraints.maxWidth * 0.038,
                                        )),
                                Text(
                                    "${snapshot.data?.items[index].volumeInfo.title}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        ?.copyWith(
                                            fontSize:
                                                constraints.maxWidth * 0.048)),
                                Text(
                                  snapshot.data == null
                                      ? 'Unknown'
                                      : "${snapshot.data!.items[index].volumeInfo.categories.isNotEmpty ? snapshot.data?.items[index].volumeInfo.categories[0] : "Unknown"}",
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                          fontSize:
                                              constraints.maxWidth * 0.038),
                                ),
                                const Spacer(
                                  flex: 2,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            });
          }
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        });
  }
}
