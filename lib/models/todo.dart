class ToDo {
  int? id;
  String task;
  bool isDone;
  String? barcode;
  String? imagePath;
  String? name;
  double price;
  int quantity; // New field for quantity

  ToDo({
    this.id,
    required this.task,
    this.isDone = false,
    this.barcode,
    this.imagePath,
    this.name,
    this.price = 0.0,
    this.quantity = 1, // Initialize quantity
  });

  // Convert from Map to ToDo
  factory ToDo.fromMap(Map<String, dynamic> json) => ToDo(
        id: json['id'],
        task: json['task'],
        isDone: json['isDone'] == 1,
        barcode: json['barcode'],
        imagePath: json['imagePath'],
        name: json['name'],
        price: json['price']?.toDouble() ?? 0.0,
        quantity: json['quantity'] ?? 1, // Load quantity
      );

  // Convert from ToDo to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'isDone': isDone ? 1 : 0,
      'barcode': barcode,
      'imagePath': imagePath,
      'name': name,
      'price': price,
      'quantity': quantity, // Save quantity
    };
  }
}
