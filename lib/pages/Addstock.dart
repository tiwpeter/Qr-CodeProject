import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../db/database_helper.dart';
import '../models/todo.dart';

class AddStock extends StatefulWidget {
  final String result; // รับค่าจาก BarcodeScannerScreen

  AddStock({required this.result});

  @override
  _AddStockState createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  final ImagePicker _picker = ImagePicker();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _purchasePriceController =
      TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();
  final TextEditingController _detailController =
      TextEditingController(); // เพิ่ม Controller สำหรับ Detail

  int _quantity = 0;
  String _scanResult = 'ผลการสแกนจะปรากฏที่นี่';
  File? _image;
  String? _barcode;

  @override
  void initState() {
    super.initState();
    _barcode = widget.result; // ใช้ค่าจาก BarcodeScannerScreen
    _scanResult = _barcode ?? 'ไม่พบข้อมูลบาร์โค้ด';
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveToDoItem() async {
    final todo = ToDo(
      task: _nameController.text.isNotEmpty
          ? _nameController.text
          : 'Product with Barcode $_barcode',
      barcode: _barcode!,
      imagePath: _image?.path,
      name: _nameController.text,
      price: double.tryParse(_salePriceController.text) ?? 0.0, // ใช้ราคาขาย
      quantity: _quantity,
      // detail: _detailController.text, // เพิ่ม Detail
    );

    await _dbHelper.insertToDo(todo);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('บันทึกข้อมูลเรียบร้อย')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มสินค้า'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                if (_image != null)
                  Image.file(
                    _image!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ชื่อสินค้า',
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 10), // เพิ่มระยะห่าง
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: _pickImage,
                            child: const Text('เลือกรูปภาพ'),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (_quantity > 0) _quantity--;
                                  });
                                },
                              ),
                              Text('$_quantity'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Barcode: $_scanResult',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                TextField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category',
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _purchasePriceController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ราคาซื้อ',
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _salePriceController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ราคาขาย',
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _detailController, // ใช้ Controller สำหรับ Detail
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'รายละเอียด',
                  ),
                  maxLines: 3, // ให้สามารถพิมพ์หลายบรรทัด
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveToDoItem,
              child: const Text('บันทึกสินค้า'),
            ),
          ],
        ),
      ),
    );
  }
}
