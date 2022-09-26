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

    ///TODO Register Adapter Model
    /*Hive.registerAdapter(adapter)*/
  }
}
