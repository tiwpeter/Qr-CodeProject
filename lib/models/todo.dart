class ToDo {
  int? id;
  String task;
  bool isDone;
  String? barcode;
  String? imagePath;

  ToDo({
    this.id,
    required this.task,
    this.isDone = false,
    this.barcode,
    this.imagePath,
  });

  // แปลงจาก Map เป็น ToDo
  factory ToDo.fromMap(Map<String, dynamic> json) => ToDo(
        id: json['id'],
        task: json['task'],
        isDone: json['isDone'] == 1,
        barcode: json['barcode'],
        imagePath: json['imagePath'],
      );

  // แปลงจาก ToDo เป็น Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
      'isDone': isDone ? 1 : 0,
      'barcode': barcode,
      'imagePath': imagePath,
    };
  }
}
