import '../../../const/constant.dart';
import '../../../data/line_chart_data.dart';
import '../../../old/widgets/custom_card_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartCard extends StatelessWidget {
  final String selectedPeriod;

  const LineChartCard({super.key, required this.selectedPeriod});

  @override
  Widget build(BuildContext context) {
    final data = LineData();
    final filteredSpots = _filterData(selectedPeriod, data);

    return CustomCard(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Revenue",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8991A3), // ปรับสีที่นี่
              ),
            ),
            Text(
              "\$27,003.98", // ใช้เครื่องหมาย \$ เพื่อแสดงสัญลักษณ์ดอลลาร์
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold, // ทำให้ตัวหนา
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 180,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            'Date: ${data.dates[spot.x.toInt()]}\nSteps: ${spot.y}',
                            TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return data.bottomTitle[value.toInt()] != null
                              ? SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    data.bottomTitle[value.toInt()].toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey[400]),
                                  ),
                                )
                              : const SizedBox();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      // ไม่แสดงแกน Y
                      sideTitles: SideTitles(
                        showTitles: false, // ปิดการแสดง
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      color: Color(0xFF007AF5),
                      barWidth: 2.5,
                      belowBarData: BarAreaData(
                        color: Color(0xFFE6F1FE),
                        show: true,
                      ),
                      dotData: FlDotData(show: false),
                      spots: filteredSpots,
                    ),
                  ],
                  minX: 0,
                  maxX: 120,
                  maxY: 105,
                  minY: -5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _filterData(String period, LineData data) {
    switch (period) {
      case '1m':
        return data.spots.where((spot) => spot.x <= 30).toList();
      case '2m':
        return data.spots.where((spot) => spot.x <= 60).toList();
      case '3m':
        return data.spots.where((spot) => spot.x <= 90).toList();
      case '6m':
        return data.spots.where((spot) => spot.x <= 180).toList();
      case '1y':
        return data.spots; // Return all data for 1 year
      default:
        return data.spots;
    }
  }
}
