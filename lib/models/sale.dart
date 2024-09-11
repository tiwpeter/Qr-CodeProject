class Sale {
  int? id;
  int todoId;
  int quantity;
  double total;
  DateTime date;

  Sale({
    this.id,
    required this.todoId,
    required this.quantity,
    required this.total,
    required this.date,
  });

  // Convert from Map to Sale
  factory Sale.fromMap(Map<String, dynamic> json) => Sale(
        id: json['id'],
        todoId: json['todoId'],
        quantity: json['quantity'],
        total: json['total'],
        date: DateTime.parse(json['date']),
      );

  // Convert from Sale to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todoId': todoId,
      'quantity': quantity,
      'total': total,
      'date': date.toIso8601String(),
    };
  }
}
