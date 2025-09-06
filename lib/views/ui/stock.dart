import 'package:flutter/material.dart';
import 'dart:io';

// Mock ToDo class
class ToDo {
  final String task;
  final String? imagePath;
  ToDo({required this.task, this.imagePath});
}

void main() => runApp(StockApp());

class StockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Mockup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatelessWidget {
  // Mock data
  final List<ToDo> _todos = [
    ToDo(task: 'Product A', imagePath: 'assets/sample/product1.jpg'),
    ToDo(task: 'Product B', imagePath: 'assets/sample/product2.jpg'),
    ToDo(task: 'Product C'),
    ToDo(task: 'Product D', imagePath: 'assets/sample/product3.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Stock'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Header
          Container(
            color: Colors.white,
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard('Total Product', '128', '+8.00%', Colors.blue),
                _buildStatCard('Profit', '2,350', '+2.34%', Colors.blue),
              ],
            ),
          ),
          // Section Title
          Container(
            color: Colors.white,
            height: 40,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Product List',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 200),
                Image.asset(
                  'assets/icon/preferences.png',
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
          // Product List
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: ListTile(
                    leading: todo.imagePath != null
                        ? Container(
                            width: 85,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(todo.imagePath!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            width: 85,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.image_not_supported),
                          ),
                    title: Text(
                      todo.task,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build stat cards
  Widget _buildStatCard(
      String title, String value, String percent, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(
                    color: Color(0xFFA4AAB9),
                    fontSize: 8,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 3),
            Text(value,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 3),
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_upward, size: 8, color: Colors.white),
                  SizedBox(width: 4),
                  Text(percent,
                      style: TextStyle(color: Colors.white, fontSize: 8)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
