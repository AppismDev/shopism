import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';
import 'package:shopism/Core/Init/Cache/i_cache_manager.dart';

class UserCacheManager extends ICacheManager {
  UserCacheManager(HiveKeys key) : super(key);

  @override
  Future<void> addItems(List items) {
    throw UnimplementedError();
  }

  @override
  Future getItem(HiveKeys key) {
    throw UnimplementedError();
  }

  @override
  HiveKeys get key => HiveKeys.USERBOX;

  @override
  Future<void> putItem(HiveKeys key, value) {
    throw UnimplementedError();
  }
}
