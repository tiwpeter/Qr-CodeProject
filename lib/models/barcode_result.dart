class BarcodeResultModel {
  final String? value;

  BarcodeResultModel({this.value});
}

class BarcodeModel {
  final int? id;
  final String value;
  final String? imagePath;

  BarcodeModel({this.id, required this.value, this.imagePath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'imagePath': imagePath,
    };
  }

  factory BarcodeModel.fromMap(Map<String, dynamic> map) {
    return BarcodeModel(
      id: map['id'],
      value: map['value'],
      imagePath: map['imagePath'],
    );
  }
}
