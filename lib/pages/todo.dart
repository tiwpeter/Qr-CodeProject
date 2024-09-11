import 'package:flutter/material.dart';
import 'dart:io'; // เพิ่มบรรทัดนี้
import '../pages/qrcode.dart';
import '../db/database_helper.dart';
import '../models/todo.dart';

void main() => runApp(Todo());

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListScreen(),
    );
  }
}

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

  void _addToDo() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BarcodeScannerScreen(),
      ),
    ).then((_) => _loadTodos()); // Reload todos on return
  }

  void _updateToDo(ToDo todo) async {
    final updatedTodo = ToDo(
      id: todo.id,
      task: todo.task,
      isDone: !todo.isDone,
      barcode: todo.barcode,
      imagePath: todo.imagePath,
      name: todo.name,
      price: todo.price,
      quantity: todo.quantity, // Ensure quantity is passed
    );
    await _dbHelper.updateToDo(updatedTodo);
    _loadTodos();
  }

  void _deleteToDo(int id) async {
    await _dbHelper.deleteToDo(id);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการสินค้า'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addToDo,
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
                if (todo.quantity > 0) Text('จำนวน: ${todo.quantity}'), // Display quantity
                if (todo.imagePath != null) Image.file(File(todo.imagePath!)),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteToDo(todo.id!),
            ),
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (value) => _updateToDo(todo),
            ),
          );
        },
      ),
    );
  }
}
