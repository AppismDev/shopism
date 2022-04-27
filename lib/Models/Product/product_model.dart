import 'package:hive/hive.dart';
import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';

part 'product_model.g.dart';
@HiveType(typeId: HiveConstants.productBrandTypeID)
class ProductBrand {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  int? imageId;
  @HiveField(4)
  String? imageUrl;

  ProductBrand({
    this.id,
    this.name,
    this.description,
    this.imageId,
    this.imageUrl,
  });

  ProductBrand.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    description = json['description']?.toString();
    imageId = json['image_id']?.toInt();
    imageUrl = json['image_url']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image_id'] = imageId;
    data['image_url'] = imageUrl;
    return data;
  }
}

@HiveType(typeId: HiveConstants.productImageTypeID)
class ProductProductImage {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? url;
  @HiveField(2)
  String? description;

  ProductProductImage({
    this.id,
    this.url,
    this.description,
  });

  ProductProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    url = json['url']?.toString();
    description = json['description']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['description'] = description;
    return data;
  }
}

@HiveType(typeId: HiveConstants.productCategoryTypeID)
class ProductCategory {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int? imageId;
  @HiveField(3)
  String? imageUrl;

  ProductCategory({
    this.id,
    this.name,
    this.imageId,
    this.imageUrl,
  });

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    name = json['name']?.toString();
    imageId = json['imageId']?.toInt();
    imageUrl = json['imageUrl']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageId'] = imageId;
    data['imageUrl'] = imageUrl;
    return data;
  }
}

@HiveType(typeId: HiveConstants.productModelTypeID)
class Product {
  @HiveField(0)
  int? productId;
  @HiveField(1)
  ProductCategory? category;
  @HiveField(2)
  ProductProductImage? productImage;
  @HiveField(3)
  ProductBrand? brand;
  @HiveField(4)
  String? productName;
  @HiveField(5)
  double? productPrice;
  @HiveField(6)
  String? productDescription;
  @HiveField(7)
  int? productDiscountRate;

  Product({
    this.productId,
    this.category,
    this.productImage,
    this.brand,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productDiscountRate,
  });

  Product.fromJson(dynamic json) {
    productId = json['product_id']?.toInt();
    category = (json['category'] != null)
        ? ProductCategory.fromJson(json['category'])
        : null;
    productImage = (json['product_image'] != null)
        ? ProductProductImage.fromJson(json['product_image'])
        : null;
    brand =
        (json['brand'] != null) ? ProductBrand.fromJson(json['brand']) : null;
    productName = json['product_name']?.toString();
    productPrice = json['product_price']?.toDouble();
    productDescription = json['product_description']?.toString();
    productDiscountRate = json['product_discount_rate']?.toInt();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_id'] = productId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (productImage != null) {
      data['product_image'] = productImage!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    data['product_name'] = productName;
    data['product_price'] = productPrice;
    data['product_description'] = productDescription;
    data['product_discount_rate'] = productDiscountRate;
    return data;
  }
}
