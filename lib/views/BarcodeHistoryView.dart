import 'package:flutter/material.dart';
import 'package:poject_qr/models/barcode_result.dart';
import 'package:provider/provider.dart';
import '../viewmodels/barcode_view_model.dart';

class BarcodeHistoryView extends StatelessWidget {
  const BarcodeHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BarcodeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ประวัติการสแกน'),
      ),
      body: FutureBuilder<List<BarcodeModel>>(
        future: viewModel.getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          }

          final history = snapshot.data;

          if (history == null || history.isEmpty) {
            return const Center(child: Text('ยังไม่มีประวัติการสแกน'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: history.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = history[index];
              return ListTile(
                title: Text(item.value ?? 'ไม่มีข้อมูล'),
              );
            },
          );
        },
      ),
    );
  }
}
