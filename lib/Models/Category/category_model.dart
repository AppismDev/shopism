class CategoryModel {
  int? categoryID;
  String? categoryName;
  int? categoryImageID;
  String? categoryImageUrl;

  CategoryModel(
      {this.categoryID,
      this.categoryImageID,
      this.categoryName,
      this.categoryImageUrl});

  CategoryModel.fromJSON(Map<String, dynamic> map) {
    categoryID = map["category_id"];
    categoryName = map["category_name"];
    categoryImageID = map["category_image_id"];
    categoryImageUrl = map["image_url"];
  }

  Map<String, dynamic> toJson() {
    return {
      "category_id": categoryID,
      "category_name": categoryName,
      "category_image_id": categoryImageID,
      "image_url": categoryImageUrl
    };
  }
}
