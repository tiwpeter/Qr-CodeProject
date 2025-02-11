import 'package:flutter/material.dart';
import 'dart:io';
import '../homepage/startScan/Add/ScanToAdd.dart';

import '../../db/database_helper.dart';
import '../../models/todo.dart';
import './BarCodeSale.dart';

// Main function to run the app
void main() => runApp(StockApp());

// StockApp widget that sets up the theme and home screen
class StockApp extends StatelessWidget {
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
      backgroundColor: Color(0xFFFFFFFF), // Set background color to white

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
              color: Color(0xFFFFFFFF),
              height: 100, // Adjust height as needed
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Space them evenly
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(
                            8.0), // Inner padding for the content
                        decoration: BoxDecoration(
                          color: Color(
                              0xFFFFFFFF), // Background color for the container
                          border: Border.all(
                              color: Colors.white,
                              width: 2), // Border properties
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the left
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total Product',
                              style: TextStyle(
                                color: Color(0xFFA4AAB9), // Updated color
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                                height:
                                    3), // Space between 'Profit' and '2,350'

                            Text(
                              '128',
                              style: TextStyle(
                                fontSize: 22,

                                color: Color(
                                    0xFF000000), // Updated color           fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                                height:
                                    3), // Space between 'Profit' and '2,350'

                            // Text 3
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .blue, // Change background color to blue
                                    borderRadius: BorderRadius.circular(
                                        50.0), // Make it oval
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0), // Add some padding
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // Minimize the size of the row
                                    children: [
                                      Image.asset(
                                        'assets/icon/up-arrowStock.png', // Replace with your image path
                                        width: 8,
                                        height: 8,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                          width:
                                              4), // Space between the image and text
                                      Text(
                                        '+8.00%',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            //
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 16), // Optional space between the two containers
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(
                            8.0), // Inner padding for the content
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
// Background color for the container
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ), // Border properties
                          borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align text to the left
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Profit',
                              style: TextStyle(
                                color: Color(0xFFA4AAB9), // Updated color
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(
                                height:
                                    3), // Space between 'Profit' and '2,350'

                            Text(
                              '2,350',
                              style: TextStyle(
                                color: Color(0xFF000000), // Updated color
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                height:
                                    3), // Space between 'Profit' and '2,350'

                            // Text 3
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .blue, // Change background color to blue
                                    borderRadius: BorderRadius.circular(
                                        50.0), // Make it oval
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4.0), // Add some padding
                                  child: Row(
                                    mainAxisSize: MainAxisSize
                                        .min, // Minimize the size of the row
                                    children: [
                                      Image.asset(
                                        'assets/icon/up-arrowStock.png', // Replace with your image path
                                        width: 8,
                                        height: 8,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                          width:
                                              4), // Space between the image and text
                                      Text(
                                        '+2.34%',
                                        style: TextStyle(
                                          color: Color(
                                              0xFF48C7F0), // Updated color
                                          fontSize: 8,
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
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xFFFFFFFF), // Set the background color as needed
              height: 40, // Set the desired height
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the row content
                children: [
                  Text(
                    'Product List',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 200), // Space between text and icon
                  Image.asset(
                    'assets/icon/preferences.png', // Replace with your image path
                    width: 24, // Set width as needed
                    height: 24, // Set height as needed
                  ),
                ],
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
                          ? Container(
                              width: 85,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.blue, // Background color
                                borderRadius: BorderRadius.circular(
                                    8.0), // Rounded corners
                                image: DecorationImage(
                                  image: FileImage(File(todo.imagePath!)),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
/* bill */