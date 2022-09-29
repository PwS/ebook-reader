import 'package:ebook/ui/custom_widgets/headline/headline.dart';
import 'package:ebook/ui/pages/dashboard/home/book_section/book_section.dart';
import 'package:ebook/ui/pages/dashboard/home/popular_book/popular_book.dart';
import 'package:ebook/ui/pages/dashboard/home/search/custom_search_delegate.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height / 2,
              child: Stack(
                children: [
                  SizedBox(
                    height: height / 2.5,
                    child: SafeArea(
                      minimum: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          const Text(
                            'Book',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              showSearch(
                                  context: context,
                                  delegate: CustomSearchDelegate());
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              height: 50,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(width: 1, color: Colors.black),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Search for Books"),
                                  Icon(Icons.search),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Most Popular'),
                              InkWell(
                                onTap: () {},
                                child: const Text(
                                  "See All",
                                ),
                              )
                            ],
                          ),
                          const Spacer(
                            flex: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: height / 4.5,
                      //height: constraints.maxHeight * 0.38,
                      margin: const EdgeInsets.only(left: 16),
                      child: const PopularBook(),
                    ),
                  ),
                ],
              ),
            ),
            const Headline(
              category: "Anime",
              showAll: "Anime",
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              height: height / 3.4,
              child: const BookSection(category: 'anime'),
            ),
            const Headline(
              category: "Action & Adventure",
              showAll: "Action & Adventure",
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              height: height / 3.4,
              child: const BookSection(category: 'action & adventure'),
            ),
          ],
        ),
      ),
    );
  }
}
