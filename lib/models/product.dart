class Product {
  final int id;
  final String name, category, image, description;
  final double price, rating;
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.description,
    required this.price,
    required this.rating,
  });
  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int,
    name: json['name'] as String,
    category: json['category'] as String,
    image: json['image'] as String,
    description: json['description'] as String,
    price: (json['price'] as num).toDouble(),
    rating: (json['rating'] as num).toDouble(),
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'image': image,
    'description': description,
    'price': price,
    'rating': rating,
  };
}

String money(double value) =>
    '${value.toStringAsFixed(2).replaceAll('.', ',')} ₺';
