//add stock
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../db/database_helper.dart';
import '../../../../models/todo.dart';

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
  final TextEditingController _detailController = TextEditingController();

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
      price: double.tryParse(_salePriceController.text) ?? 0.0,
      quantity: _quantity,
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
      body: Container(
        color: Color.fromARGB(255, 254, 247, 255),
        child: SingleChildScrollView(
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
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'ชื่อสินค้า',
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 214, 214, 213),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 101, 185, 254),
                                  width: 2.0),
                            ),
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: Image.asset(
                                    'assets/images/camera_1.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                SizedBox(height: 16),
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: Image.asset(
                                    'assets/images/camera_1.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                              ],
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
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Category',
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 214, 214, 213),
                            width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 101, 185, 254),
                            width: 2.0),
                      ),
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _purchasePriceController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'ราคาซื้อ',
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 214, 214, 213),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 101, 185, 254),
                                  width: 2.0),
                            ),
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
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'ราคาขาย',
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 214, 214, 213),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 101, 185, 254),
                                  width: 2.0),
                            ),
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
                    controller: _detailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'รายละเอียด',
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 214, 214, 213),
                            width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 101, 185, 254),
                            width: 2.0),
                      ),
                    ),
                    maxLines: 3,
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
      ),
    );
  }
}
