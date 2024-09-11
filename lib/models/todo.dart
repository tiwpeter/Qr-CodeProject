class ToDo {
  int? id;
  String task;
  bool isDone;
  String? barcode;
  String? imagePath;
  String? name; // New field for name
  double price; // New field for price

  ToDo({
    this.id,
    required this.task,
    this.isDone = false,
    this.barcode,
    this.imagePath,
    this.name, // Initialize name
    this.price = 0.0, // Initialize price
  });

  // Convert from Map to ToDo
  factory ToDo.fromMap(Map<String, dynamic> json) => ToDo(
        id: json['id'],
        task: json['task'],
        isDone: json['isDone'] == 1,
        barcode: json['barcode'],
        imagePath: json['imagePath'],
        name: json['name'], // Load name
        price: json['price']?.toDouble() ?? 0.0, // Load price
      );

  // Convert from ToDo to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'isDone': isDone ? 1 : 0,
      'barcode': barcode,
      'imagePath': imagePath,
      'name': name, // Save name
      'price': price, // Save price
    };
  }
}
