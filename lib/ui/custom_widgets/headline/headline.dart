import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  const Headline({Key? key, required this.category, required this.showAll})
      : super(key: key);

  final String category;
  final String showAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
          ),
          InkWell(
              onTap: () {},
              child: const Text(
                "See All",
              ))
        ],
      ),
    );
  }
}
