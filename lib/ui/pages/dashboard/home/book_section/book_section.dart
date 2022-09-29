import 'package:ebook/models/book/book.dart';
import 'package:ebook/services/book/book_service.dart';
import 'package:ebook/ui/pages/dashboard/home/detail_book/detail_book.dart';
import 'package:ebook/utils/constant/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookSection extends StatelessWidget {
  const BookSection({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: BookService().searchBooksResponse(category),
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
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailBook(
                                  detailBooks: snapshot.data!.items[index],
                                ))),
                    child: Container(
                      width: constraints.maxWidth * 0.30,
                      padding:
                          const EdgeInsets.only(left: 16, bottom: 5, top: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 2,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: SizedBox(
                              height: constraints.maxHeight * 0.6,
                              width: constraints.maxWidth * 0.25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: (snapshot.data == null ||
                                        snapshot.data?.items[index].volumeInfo
                                                .imageLinks.smallThumbnail ==
                                            null)
                                    ? SvgPicture.asset(
                                        AssetsPath.illustrations_404)
                                    : Image(
                                        image: NetworkImage(
                                          snapshot.data!.items[index].volumeInfo
                                              .imageLinks.smallThumbnail,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                              ),
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
                                    fontSize: constraints.maxWidth * 0.035,
                                    fontWeight: FontWeight.w500),
                          ),
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
