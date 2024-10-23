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
      title: 'Stock',
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

  // Load todos from the database with error handling
  void _loadTodos() async {
    try {
      final todos = await _dbHelper.todos();
      setState(() {
        _todos = todos;
      });
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading todos: $e')),
      );
    }
  }

  // Add a new ToDo item by scanning a barcode
  void _addToDo() async {
    final result =
        await scanBarcode(); // Implement this method to get actual result

    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => BarcodeScannerScreen(result: result),
          ),
        )
        .then((_) => _loadTodos()); // Reload todos on return
  }

  // Mock method for barcode scanning; replace with actual implementation
  Future<String> scanBarcode() async {
    // Implement your barcode scanning logic here
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
    try {
      await _dbHelper.deleteToDo(id);
      _loadTodos();
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting todo: $e')),
      );
    }
  }

  // Build the UI for the ToDo List screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock'),
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
        width: double.infinity,
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'Your Header Text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              color: Colors.blue, // Set the background color as needed
              height: 40, // Set the desired height
              alignment: Alignment.center,
              child: Text(
                'Product List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0), // Adjust padding
                    child: ListTile(
                      leading: todo.imagePath != null
                          ? Image.file(
                              File(todo.imagePath!),
                              width: 85,
                              height: 70,
                              fit: BoxFit.cover,
                            )
                          : SizedBox.shrink(),
                      title: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          4.0), // Increased vertical padding
                                  child: Text(
                                    todo.task,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              4.0), // Increased vertical padding
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/icon/arrowY.png',
                                            width: 16,
                                            height: 16,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '100',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              4.0), // Increased vertical padding
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/icon/arrowxX.png',
                                            width: 16,
                                            height: 16,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            '200',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.0), // Increased vertical padding
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          4.0), // Increased vertical padding
                                  child: Image.asset(
                                    'assets/icon/right.png',
                                    width: 16,
                                    height: 16,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onLongPress: () => _deleteToDo(todo.id!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
เพิ่ม: ถ้ามีสินค้าเข้ามาใหม่ เช่น การรับสินค้า
ลด: ถ้ามีสินค้าขายออกไปหรือหมด
 */

/*
profit
totel
 */