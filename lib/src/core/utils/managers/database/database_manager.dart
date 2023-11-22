import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

abstract class DatabaseManager {
  Future<void> openBox();
  void saveData(String key, dynamic value);
  dynamic getData(String key);
  void deleteData(String key);
}

class DatabaseManagerImpl implements DatabaseManager {
  late Box<dynamic> _box;

  @override
  Future<void> openBox() async {
    if (!kIsWeb) {
      final Directory appDocDir =
          await pathProvider.getApplicationDocumentsDirectory();
      final String appDocPath = appDocDir.path;
      Hive.init(appDocPath);
    }

    _box = await Hive.openBox("appBox");
  }

  @override
  void saveData(String key, dynamic value) {
    _box.put(key, value);
  }

  @override
  dynamic getData(String key) {
    return _box.get(key);
  }

  @override
  void deleteData(String key) {
    _box.delete(key);
  }
}
