class ProductModel {
  final int? id;
  final String barcode;
  final String name;
  final double price;
  final String? imagePath;

  ProductModel({
    this.id,
    required this.barcode,
    required this.name,
    required this.price,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'name': name,
      'price': price,
      'imagePath': imagePath,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      barcode: map['barcode'],
      name: map['name'],
      price: map['price'],
      imagePath: map['imagePath'],
    );
  }
}
