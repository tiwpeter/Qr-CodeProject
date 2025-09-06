import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modern Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        fontFamily: 'Poppins',
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ยอดขาย Dashboard'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Grid สรุปยอดขาย
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SummaryCard(
                    title: 'วันนี้', value: '฿5,000', color: Colors.orange),
                SizedBox(width: 16),
                SummaryCard(
                    title: 'เดือนนี้', value: '฿150,000', color: Colors.green),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SummaryCard(
                    title: 'ลูกค้าใหม่', value: '120', color: Colors.purple),
                SizedBox(width: 16),
                SummaryCard(
                    title: 'ปีนี้', value: '฿1,500,000', color: Colors.blue),
              ],
            ),
            const SizedBox(height: 30),
            // Line Chart Card
            ChartCard(
              title: 'ยอดขายรายสัปดาห์',
              child: LineChart(LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ];
                        return Text(days[value.toInt()]);
                      },
                    ),
                  ),
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: true)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 5000),
                      FlSpot(1, 7000),
                      FlSpot(2, 6000),
                      FlSpot(3, 8000),
                      FlSpot(4, 5500),
                      FlSpot(5, 9000),
                      FlSpot(6, 10000),
                    ],
                    isCurved: true,
                    gradient: const LinearGradient(
                      colors: [Colors.teal, Colors.lightBlueAccent],
                    ),
                    barWidth: 4,
                    dotData: FlDotData(show: true),
                  ),
                ],
              )),
            ),
            const SizedBox(height: 30),
            // Pie Chart Card
            ChartCard(
              title: 'ยอดขายตามประเภทสินค้า',
              child: PieChart(PieChartData(
                sections: [
                  PieChartSectionData(
                      color: Colors.orange,
                      value: 40,
                      title: 'อาหาร',
                      radius: 50),
                  PieChartSectionData(
                      color: Colors.green,
                      value: 30,
                      title: 'เครื่องดื่ม',
                      radius: 50),
                  PieChartSectionData(
                      color: Colors.blue,
                      value: 20,
                      title: 'ของใช้',
                      radius: 50),
                  PieChartSectionData(
                      color: Colors.purple,
                      value: 10,
                      title: 'อื่น ๆ',
                      radius: 50),
                ],
                centerSpaceRadius: 40,
                sectionsSpace: 4,
              )),
            ),
          ],
        ),
      ),
    );
  }
}

// การ์ดสรุปยอดขายแบบโมเดิร์น
class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const SummaryCard(
      {super.key,
      required this.title,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 5))
          ],
        ),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// Card สำหรับกราฟ
class ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  const ChartCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      shadowColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(height: 250, child: child),
          ],
        ),
      ),
    );
  }
}
