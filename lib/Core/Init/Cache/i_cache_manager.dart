import 'package:hive_flutter/adapters.dart';
import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';

//Custom typelar için extra işlemler gerekiyor örneğin useri cachlerken --> https://docs.hivedb.dev/#/custom-objects/generate_adapter
abstract class ICacheManager<T> {
  final HiveKeys key;
  Box<T>? hiveBox;

  ICacheManager(this.key);

  Future<void> init() async {
    registerAdapters();
    if (!(hiveBox?.isOpen ?? false)) {
      hiveBox = await Hive.openBox(this.key.toString());
    }
  }

  void registerAdapters();

  Future<void> addItems(List<T> items);

  Future<void> deleteItem(HiveKeys key) async {
    await hiveBox?.delete(key.toString());
  }

  Future<T?> getItem(HiveKeys key) async {
    var item = await hiveBox?.get(key.toString());
    return item;
  }

  Future<void> putItem(HiveKeys key, T value) async {
    await hiveBox?.put(key.toString(), value);
  }

  Future<void> addItem(T value) async {
    await hiveBox?.add(value);
  }

  Future<void> removeBox() async {
    await hiveBox?.deleteFromDisk();
  }

  Future<void> clearAll() async {
    await hiveBox?.clear();
  }
}
