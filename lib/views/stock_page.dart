import 'package:flutter/material.dart';
import 'package:poject_qr/viewmodels/stock_viewmodel.dart';
import 'package:provider/provider.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Stock'),
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: เพิ่มสินค้าใหม่
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard(
                  'Total Products',
                  viewModel.products.length.toString(),
                  '+8%',
                  Colors.teal,
                  icon: Icons.inventory_2,
                ),
                _buildStatCard(
                  'Profit',
                  '2,350 ฿',
                  '+2.34%',
                  Colors.orange,
                  icon: Icons.attach_money,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Section Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Product List',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // Product List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: viewModel.products.length,
              itemBuilder: (context, index) {
                final product = viewModel.products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: product.imagePath != null
                          ? Image.asset(
                              product.imagePath!,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 70,
                              height: 70,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image_not_supported),
                            ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            // วงกลมเปล่า สีสวย
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: _getQuantityColor(product.quantity),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // ตัวเลขแยกออกมา
                            Text(
                              '${product.quantity}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String percent,
    Color color, {
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_upward, size: 10, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    percent,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันเลือกสีวงกลมตามจำนวนสินค้า
  Color _getQuantityColor(int quantity) {
    if (quantity >= 10) return Colors.green;
    if (quantity >= 5) return Colors.orange;
    return Colors.red;
  }
}
