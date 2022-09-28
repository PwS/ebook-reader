import 'package:ebook/models/books/book.dart';
import 'package:ebook/services/book/book_service.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DetailCategoriesPage extends StatelessWidget {
  const DetailCategoriesPage({Key? key, required this.sourceCategories})
      : super(key: key);
  final String sourceCategories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(sourceCategories),
        ),
        body: FutureBuilder(
          future: BookService().searchBooksResponse(sourceCategories),
          builder: (context, AsyncSnapshot<ResponseBook> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Opps! Try again later!"),
              );
            }
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: 35,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //childAspectRatio: 16 / 15,
                    crossAxisCount: 2,
                    mainAxisExtent: 260,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: constraints.maxHeight / 2,
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      height: constraints.maxHeight / 2.5,
                                      decoration: BoxDecoration(
                                        color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                    Positioned(
                                      top: 0,
                                      child: Card(
                                        margin: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: SizedBox(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image(
                                              height: constraints.maxHeight / 2,
                                              width: constraints.maxWidth / 2,
                                              image: NetworkImage(
                                                  "${snapshot.data?.items[index].volumeInfo.imageLinks.thumbnail}"),
                                              fit: BoxFit.fill, // use this
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data == null ? 'Not Found' : snapshot.data!.items[index].volumeInfo.authors.isNotEmpty ? snapshot.data?.items[index].volumeInfo.authors[0] : 'Not Found'}',
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(
                                            fontSize:
                                                constraints.maxWidth * 0.09,
                                          ),
                                    ),
                                    Text(
                                      "${snapshot.data?.items[index].volumeInfo.title}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(
                                              fontSize:
                                                  constraints.maxWidth * 0.09,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      height: constraints.maxHeight * 0.20,
                                      width: constraints.maxWidth * 0.60,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        "Page Count : ${snapshot.data?.items[index].volumeInfo.pageCount}",
                                        style: TextStyle(
                                            fontSize:
                                                constraints.maxWidth * 0.08,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                      ),
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
        ));
  }
}
