class Product {
  String id;
  String name;
  double? price;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    this.price,
    required this.imageUrl,
  });
}
