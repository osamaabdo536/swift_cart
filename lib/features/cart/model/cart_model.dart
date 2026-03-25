class CartItemModel {
  final String id;
  final String title;
  final String image;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
  });


  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['product']['id'] ?? json['product']['_id'] ?? json['_id'],
      title: json['product']['title'] ?? 'Product',
      image: json['product']['imageCover'] ?? '',
      price: (json['price'] ?? json['product']['price'] ?? 0).toDouble(),
      quantity: json['count'] ?? 1,
    );
  }
}