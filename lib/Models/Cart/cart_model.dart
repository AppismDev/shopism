class CartModel {
  int? cartItem;
  int? productId;
  int? quantity;
  double? price;
  String? productName;
  String? productDescription;
  int? imageID;
  String? imageURL;


  CartModel({
    this.cartItem,
    this.productId,
    this.quantity,
    this.price,
    this.productName,
    this.productDescription,
    this.imageID,
    this.imageURL
  });

  CartModel.fromJSON(Map<String, dynamic> map) {
    cartItem = map["cart_item"];
    productId = map["product_id"];
    quantity = map["quantity"];
    price = map["price"] * 1.0;
    productName = map["product_name"];
    productDescription = map["product_description"];
    imageID = map["image_id"];
    imageURL = map["image_url"];
  }

  @override
  String toString() {
    return "${imageURL} name :${productName} adet : ${quantity}";
  }

}
