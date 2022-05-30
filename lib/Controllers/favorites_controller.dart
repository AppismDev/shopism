import 'package:get/get.dart';
import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';
import 'package:shopism/Core/Init/Cache/favorites_cache_manager.dart';
import 'package:shopism/Core/Init/Cache/i_cache_manager.dart';
import 'package:shopism/Models/Product/product_model.dart';

class FavoritesController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    // await _favoritesCacheManager.removeBox();
    await getFavorites();
  }

  RxBool isFavoritesLoading = false.obs;
  RxList favorites = [].obs;
  FavoritesCacheManager _favoritesCacheManager = FavoritesCacheManager.instance;

  Future<void> addToFavorites(Product product) async {
    await _favoritesCacheManager.addItem(product);
    favorites.add(product);
  }

  Future<void> removeFromFavorites(Product product) async {
    favorites.remove(favorites.firstWhere((p0) => (p0 as Product).productId == product.productId));

    dynamic desiredKey;
    final Map<dynamic, dynamic>? productsMap = _favoritesCacheManager.hiveBox?.toMap();

    productsMap?.forEach((key,element) {
      if((element as Product).productId == product.productId){
        desiredKey = key;
        return;
      }
    });
    _favoritesCacheManager.hiveBox?.delete(desiredKey);
  }

  Future<void> getFavorites() async {
    var favoritesData = await _favoritesCacheManager.hiveBox?.values.toList();

    if (favoritesData != null) {
      favorites.value = favoritesData;
    }
  }

  void checkAndRemoveIfExist(Product product) {
    bool isInFavorites =
    favorites.map((e) => (e as Product).productId).contains(product.productId);
    if (isInFavorites) {
      removeFromFavorites(product);
    } else {
      addToFavorites(product);
    }

  }
}
