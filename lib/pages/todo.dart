import 'package:flutter/material.dart';
import 'dart:io';
import '../pages/qrcode.dart'; // Assuming this is where BarcodeScannerScreen is defined
import '../db/database_helper.dart';
import '../models/todo.dart';
import 'BarCodeSale.dart'; // Import BarCodeSale instead of SalesScreen

// Main function to run the app
void main() => runApp(TodoApp());

// TodoApp widget that sets up the theme and home screen
class TodoApp extends StatelessWidget {
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

// Stateful widget for the ToDo List screen
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

  // Load todos from the database
  void _loadTodos() async {
    final todos = await _dbHelper.todos();
    setState(() {
      _todos = todos;
    });
  }

  // Add a new ToDo item by scanning a barcode
  void _addToDo() async {
    final result = await scanBarcode(); // Implement this method to get actual result

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BarcodeScannerScreen(result: result),
      ),
    ).then((_) => _loadTodos()); // Reload todos on return
  }

  // Mock method for barcode scanning; replace with actual implementation
  Future<String> scanBarcode() async {
    // Implement your barcode scanning logic here
    // Return a sample result for now
    return 'SampleBarcodeResult'; // Replace with actual scanned result
  }

  // Navigate to the BarCodeSale screen
  void _navigateToSalesScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BarCodeSale(), // Updated to BarCodeSale
      ),
    );
  }

  // Delete a ToDo item by its ID
  void _deleteToDo(int id) async {
    await _dbHelper.deleteToDo(id);
    _loadTodos();
  }

  // Build the UI for the ToDo List screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addToDo,
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: _navigateToSalesScreen,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50], // Background color
          border: Border.all(color: Colors.blueGrey[100]!, width: 2), // Border
        ),
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, index) {
            final todo = _todos[index];
            return ListTile(
              leading: todo.imagePath != null
                  ? Image.file(
                      File(todo.imagePath!),
                      width: 24, // Set the width of the image
                      height: 24, // Set the height of the image
                      fit: BoxFit.cover, // Fit the image within the specified width and height
                    )
                  : SizedBox.shrink(), // Hide if no imagePath
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      todo.task,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      'ราคา: ${todo.price}', // Display price label and value
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              onLongPress: () => _deleteToDo(todo.id!),
            );
          },
        ),
      ),
    );
  }
}
