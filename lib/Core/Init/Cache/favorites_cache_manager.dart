import 'package:hive/hive.dart';
import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';
import 'package:shopism/Core/Init/Cache/i_cache_manager.dart';
import 'package:shopism/Models/Product/product_model.dart';

class FavoritesCacheManager extends ICacheManager {
  FavoritesCacheManager._init(HiveKeys key) : super(key);

  static FavoritesCacheManager? _instance;

  static FavoritesCacheManager get instance {
    _instance ??= FavoritesCacheManager._init(HiveKeys.FAVORITESBOX);
    return _instance!;
  }

  @override
  Future<void> addItems(List items) {
    // TODO: implement addItems
    throw UnimplementedError();
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.productModelTypeID)) {
      Hive.registerAdapter(ProductAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveConstants.productCategoryTypeID)) {
      Hive.registerAdapter(ProductCategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveConstants.productImageTypeID)) {
      Hive.registerAdapter(ProductProductImageAdapter());
    }
    if (!Hive.isAdapterRegistered(HiveConstants.productBrandTypeID)) {
      Hive.registerAdapter(ProductBrandAdapter());
    }
  }
}
