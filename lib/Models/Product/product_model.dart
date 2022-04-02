
class ProductBrand {
  int? id;
  String? name;
  String? description;
  int? imageId;
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

class ProductProductImage {
  int? id;
  String? url;
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

class ProductCategory {

  int? id;
  String? name;
  int? imageId;
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

class Product {

  int? productId;
  ProductCategory? category;
  ProductProductImage? productImage;
  ProductBrand? brand;
  String? productName;
  double? productPrice;
  String? productDescription;
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
    category = (json['category'] != null) ? ProductCategory.fromJson(json['category']) : null;
    productImage = (json['product_image'] != null) ? ProductProductImage.fromJson(json['product_image']) : null;
    brand = (json['brand'] != null) ? ProductBrand.fromJson(json['brand']) : null;
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
