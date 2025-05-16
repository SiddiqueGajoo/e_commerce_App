class productStore {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  productStore({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory productStore.fromJson(Map<String, dynamic> json) {
    return productStore(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'] ?? 0.0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
