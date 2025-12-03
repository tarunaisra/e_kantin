class ProductModel_taruna { 
  final String productId;
  final String name;
  final double price;
  final int stock;
  final String imageUrl;

  ProductModel_taruna({
    required this.productId,
    required this.name,
    required this.price,
    required this.stock,
    required this.imageUrl,
  });

  factory ProductModel_taruna.fromJson(Map<String, dynamic> json) {
    return ProductModel_taruna(
      productId: json['product_id'],
      name: json['name'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'name': name,
      'price': price,
      'stock': stock,
      'image_url': imageUrl,
    };
  }
}
