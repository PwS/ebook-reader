import 'package:ebook/models/favorite_book/favorite_book.dart';
import 'package:ebook/utils/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'box_name.dart';

class Database {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    registerAdapterHive();
  }

  static void registerAdapterHive() {
    logger.i('Start Register Adapter');
    Hive.registerAdapter(FavoriteBookAdapter());
  }

  static void closeBox() {
    logger.i('Closing Box Hive');
    Hive.deleteFromDisk();
  }
}
