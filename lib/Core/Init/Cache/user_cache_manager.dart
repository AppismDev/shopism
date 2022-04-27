import 'package:hive/hive.dart';
import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';
import 'package:shopism/Core/Init/Cache/i_cache_manager.dart';
import 'package:shopism/Models/User/account_model.dart';

class UserCacheManager extends ICacheManager {
  UserCacheManager._init(HiveKeys key) : super(key);

  static UserCacheManager _instance = UserCacheManager._init(HiveKeys.USERBOX);

  static UserCacheManager get instance => _instance;

  @override
  Future<void> addItems(List items) {
    throw UnimplementedError();
  }


  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.accountTypeID)) {
      Hive.registerAdapter(AccountModelAdapter());
    }
  }

}
