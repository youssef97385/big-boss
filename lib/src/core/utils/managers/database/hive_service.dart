import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveService {



  isExists({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  clearBoxes(String boxName) async {
    final openBox = await Hive.openBox(boxName);
    await openBox.clear();
  }

  deleteBox(String key, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    await openBox.delete(key);
  }

  Future addBoxes<T>(List<T> items, String boxName) async {
    debugPrint("adding boxes");
    final openBox = await Hive.openBox(boxName);

    for (var item in items) {
      openBox.add(item);
    }
  }

  addBox<T>(String key, T item, String boxName) async {
    final openBox = await Hive.openBox(boxName);

    openBox.put(key, item).then((value) {
      debugPrint("added");
    });
  }

  getBox<T>(String key, String boxName) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.get(key);
  }

  clearBox<T>( String boxName) async {
    final openBox = await Hive.openBox(boxName);
    openBox.clear();
  }

  getBoxes<T>(String boxName) async {
    List<T> boxList = [];

    final openBox = await Hive.openBox(boxName);

    int length = openBox.length;

    for (int i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }

    return boxList;
  }
}
