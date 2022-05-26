class DeliveryModel {
  int? deliveryID;
  int? logoId;
  String? name;
  String? imageURL;
  String? imageDescription;

  DeliveryModel(this.deliveryID, this.logoId, this.name, this.imageURL, this.imageDescription);


  DeliveryModel.fromJSON(Map<String, dynamic>map){
    this.imageURL = map["image_url"];
    this.logoId = map["logo_id"];
    this.name = map["name"];
    this.imageDescription = map["image_description"];
    this.deliveryID = map["delivery_id"];
  }
}