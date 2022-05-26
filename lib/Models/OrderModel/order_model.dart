class OrderModel {
  BasicDetails? basicDetails;
  CartItemDetails? cartItemDetails;
  AddressDetails? addressDetails;
  StatusDetails? statusDetails;
  PaymentDetails? paymentDetails;

  OrderModel({this.basicDetails, this.cartItemDetails, this.addressDetails, this.statusDetails, this.paymentDetails});

  OrderModel.fromJson(Map<String, dynamic> json) {
    basicDetails = json['BasicDetails'] != null ? new BasicDetails.fromJson(json['BasicDetails']) : null;
    cartItemDetails = json['CartItemDetails'] != null ? new CartItemDetails.fromJson(json['CartItemDetails']) : null;
    addressDetails = json['AddressDetails'] != null ? new AddressDetails.fromJson(json['AddressDetails']) : null;
    statusDetails = json['StatusDetails'] != null ? new StatusDetails.fromJson(json['StatusDetails']) : null;
    paymentDetails = json['PaymentDetails'] != null ? new PaymentDetails.fromJson(json['PaymentDetails']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basicDetails != null) {
      data['BasicDetails'] = this.basicDetails!.toJson();
    }
    if (this.cartItemDetails != null) {
      data['CartItemDetails'] = this.cartItemDetails!.toJson();
    }
    if (this.addressDetails != null) {
      data['AddressDetails'] = this.addressDetails!.toJson();
    }
    if (this.statusDetails != null) {
      data['StatusDetails'] = this.statusDetails!.toJson();
    }
    if (this.paymentDetails != null) {
      data['PaymentDetails'] = this.paymentDetails!.toJson();
    }
    return data;
  }
}

class BasicDetails {
  int? orderId;
  String? userEmail;
  int? cartItemId;
  int? deliveryStatusId;
  int? paymentOptionsId;
  String? orderDate;

  BasicDetails({this.orderId, this.userEmail, this.cartItemId, this.deliveryStatusId, this.paymentOptionsId, this.orderDate});

  BasicDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    userEmail = json['userEmail'];
    cartItemId = json['cartItemId'];
    deliveryStatusId = json['deliveryStatusId'];
    paymentOptionsId = json['paymentOptionsId'];
    orderDate = json['orderDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['userEmail'] = this.userEmail;
    data['cartItemId'] = this.cartItemId;
    data['deliveryStatusId'] = this.deliveryStatusId;
    data['paymentOptionsId'] = this.paymentOptionsId;
    data['orderDate'] = this.orderDate;
    return data;
  }
}

class CartItemDetails {
  int? cartItemId;
  int? itemQuantity;
  double? totalPrice;
  OrderProduct? product;

  CartItemDetails({this.cartItemId, this.itemQuantity, this.totalPrice, this.product});

  CartItemDetails.fromJson(Map<String, dynamic> json) {
    cartItemId = json['cartItemId'];
    itemQuantity = json['itemQuantity'];
    totalPrice = json['totalPrice'].toDouble();
    product = json['product'] != null ? new OrderProduct.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartItemId'] = this.cartItemId;
    data['itemQuantity'] = this.itemQuantity;
    data['totalPrice'] = this.totalPrice;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class OrderProduct {
  String? productName;
  String? productImage;
  double? productPrice;

  OrderProduct({this.productName, this.productImage, this.productPrice});

  OrderProduct.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productImage = json['productImage'];
    productPrice = json['productPrice'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['productImage'] = this.productImage;
    data['productPrice'] = this.productPrice;
    return data;
  }
}

class AddressDetails {
  String? country;
  String? city;
  String? district;
  String? firstAddress;

  AddressDetails({this.country, this.city, this.district, this.firstAddress});

  AddressDetails.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    district = json['district'];
    firstAddress = json['firstAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['city'] = this.city;
    data['district'] = this.district;
    data['firstAddress'] = this.firstAddress;
    return data;
  }
}

class StatusDetails {
  int? orderStatusId;
  String? orderStatus;
  int? deliveryStatusId;
  String? deliveryStatus;
  String? deliveryName;

  StatusDetails({this.orderStatusId, this.orderStatus, this.deliveryStatusId, this.deliveryStatus, this.deliveryName});

  StatusDetails.fromJson(Map<String, dynamic> json) {
    orderStatusId = json['orderStatusId'];
    orderStatus = json['orderStatus'];
    deliveryStatusId = json['deliveryStatusId'];
    deliveryStatus = json['deliveryStatus'];
    deliveryName = json['deliveryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderStatusId'] = this.orderStatusId;
    data['orderStatus'] = this.orderStatus;
    data['deliveryStatusId'] = this.deliveryStatusId;
    data['deliveryStatus'] = this.deliveryStatus;
    data['deliveryName'] = this.deliveryName;
    return data;
  }
}

class PaymentDetails {
  int? paymentOptionsID;
  String? paymentType;
  double? totalPrice;
  double? installmentPrice;
  int? installment;

  PaymentDetails({this.paymentOptionsID, this.paymentType, this.totalPrice, this.installmentPrice, this.installment});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    paymentOptionsID = json['paymentOptionsID'];
    paymentType = json['paymentType'];
    totalPrice = json['totalPrice'].toDouble();
    installmentPrice = json['installmentPrice'].toDouble();
    installment = json['installment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentOptionsID'] = this.paymentOptionsID;
    data['paymentType'] = this.paymentType;
    data['totalPrice'] = this.totalPrice;
    data['installmentPrice'] = this.installmentPrice;
    data['installment'] = this.installment;
    return data;
  }
}
