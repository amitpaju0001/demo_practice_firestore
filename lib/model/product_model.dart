class ProductModel {
  String productId;
  String productName;
  String productPrice;
  String productDesc;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productDesc,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['id'],
      productName: json['name'],
      productPrice: json['price'],
      productDesc: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'name': productName,
      'price': productPrice,
      'description': productDesc,
    };
  }
}
