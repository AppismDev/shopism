import 'package:hive_flutter/adapters.dart';
import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';

//Custom typelar için extra işlemler gerekiyor örneğine useri cachlerken --> https://docs.hivedb.dev/#/custom-objects/generate_adapter
abstract class ICacheManager<T> {
  final HiveKeys key;
  Box? _hiveBox;

  ICacheManager(this.key);

  Future<void> init() async {
    registerAdapters();
    if (!(_hiveBox?.isOpen ?? false)) {
      _hiveBox = await Hive.openBox(this.key.toString());
    }
  }

  void registerAdapters();
  Future<void> addItems(List<T> items);
  Future<T> getItem(HiveKeys key);
  Future<void> putItem(HiveKeys key, T value);

  Future<void> clearAll() async {
    await _hiveBox?.clear();
  }
}
