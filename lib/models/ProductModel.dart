class ProductModel {
  final int? id;
  final String barcode;
  final String name;
  final double price;
  final String? imagePath;
  final int quantity; // เพิ่ม field quantity

  ProductModel({
    this.id,
    required this.barcode,
    required this.name,
    required this.price,
    this.imagePath,
    this.quantity = 0, // ค่าเริ่มต้น 0
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'quantity': quantity, // เพิ่ม
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      barcode: map['barcode'],
      name: map['name'],
      price: map['price'],
      imagePath: map['imagePath'],
      quantity: map['quantity'] ?? 0, // กำหนดค่า default ถ้า null
    );
  }
}
