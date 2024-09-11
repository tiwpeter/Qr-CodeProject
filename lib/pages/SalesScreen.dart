import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/todo.dart';
import '../models/sale.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _quantityController = TextEditingController();
  ToDo? _selectedToDo;

  double _totalSales = 0.0;
  List<ToDo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
    _loadTotalSales();
  }

  void _loadTodos() async {
    final todos = await _dbHelper.todos();
    setState(() {
      _todos = todos;
    });
  }

  void _loadTotalSales() async {
    final totalSales = await _dbHelper.getTotalSales();
    setState(() {
      _totalSales = totalSales;
    });
  }

  Future<void> _recordSale() async {
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    if (_selectedToDo == null || quantity <= 0) return;

    final total = _selectedToDo!.price * quantity;
    final sale = Sale(
      todoId: _selectedToDo!.id!,
      quantity: quantity,
      total: total,
      date: DateTime.now(),
    );

    await _dbHelper.insertSale(sale);
    await _dbHelper.updateToDo(ToDo(
      id: _selectedToDo!.id,
      task: _selectedToDo!.task,
      isDone: _selectedToDo!.isDone,
      barcode: _selectedToDo!.barcode,
      imagePath: _selectedToDo!.imagePath,
      name: _selectedToDo!.name,
      price: _selectedToDo!.price,
      quantity: _selectedToDo!.quantity - quantity,
    ));

    _quantityController.clear();
    _loadTodos();
    _loadTotalSales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Sales'),
      ),
      body: Column(
        children: [
          DropdownButton<ToDo>(
            hint: Text('Select Item'),
            value: _selectedToDo,
            onChanged: (ToDo? newValue) {
              setState(() {
                _selectedToDo = newValue;
              });
            },
            items: _todos.map<DropdownMenuItem<ToDo>>((ToDo todo) {
              return DropdownMenuItem<ToDo>(
                value: todo,
                child: Text(todo.task),
              );
            }).toList(),
          ),
          TextField(
            controller: _quantityController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Quantity',
            ),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: _recordSale,
            child: const Text('Record Sale'),
          ),
          Text('Total Sales: $_totalSales'),
        ],
      ),
    );
  }
}
