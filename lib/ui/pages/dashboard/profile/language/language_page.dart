import 'package:ebook/utils/config/language.dart';
import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: Language.languages.length,
        itemBuilder: (BuildContext context, int index) {
          return _ItemList(language: Language.languages[index], index: index);
        },
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  final String language;
  final int index;

  const _ItemList({Key? key, required this.language, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(language),
          onTap: () async {
            /*  if(index == 0){
              context.locale = Locale('en');
            }
            else{
              context.locale = Locale('es');
            }*/
            Navigator.pop(context);
          },
        ),
        const Divider()
      ],
    );
  }
}
