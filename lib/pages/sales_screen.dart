import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/todo.dart';
import '../pages/SalesScreen.dart'; // นำเข้า SalesScreen
import 'dart:io'; // เพิ่มการนำเข้า dart:io เพื่อจัดการกับไฟล์

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<ToDo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    final todos = await _dbHelper.todos();
    setState(() {
      _todos = todos;
    });
  }

  void _navigateToSalesScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SalesScreen(), // นำทางไปยัง SalesScreen
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการสินค้า'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // การนำทางไปยังหน้า BarcodeScannerScreen หรือฟังก์ชันอื่น
            },
          ),
          IconButton(
            icon: const Icon(Icons.sell),
            onPressed: _navigateToSalesScreen, // เรียกใช้งานฟังก์ชันการนำทาง
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            title: Text(
              todo.task,
              style: TextStyle(
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (todo.barcode != null) Text('บาร์โค้ด: ${todo.barcode}'),
                if (todo.name != null) Text('ชื่อสินค้า: ${todo.name}'),
                if (todo.price != 0.0) Text('ราคา: ${todo.price.toStringAsFixed(2)}'),
                if (todo.quantity > 0) Text('จำนวน: ${todo.quantity}'),
                if (todo.imagePath != null) Image.file(File(todo.imagePath!)),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await _dbHelper.deleteToDo(todo.id!);
                _loadTodos();
              },
            ),
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (value) async {
                final updatedTodo = ToDo(
                  id: todo.id,
                  task: todo.task,
                  isDone: value!,
                  barcode: todo.barcode,
                  imagePath: todo.imagePath,
                  name: todo.name,
                  price: todo.price,
                  quantity: todo.quantity,
                );
                await _dbHelper.updateToDo(updatedTodo);
                _loadTodos();
              },
            ),
          );
        },
      ),
    );
  }
}
