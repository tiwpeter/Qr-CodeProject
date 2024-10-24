import '../const/constant.dart';
import '../data/line_chart_data.dart';
import '../widgets/custom_card_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartCard extends StatefulWidget {
  const LineChartCard({super.key});

  @override
  _LineChartCardState createState() => _LineChartCardState();
}

class _LineChartCardState extends State<LineChartCard> {
  String _selectedPeriod = '1m'; // Default to 1 month

  // Sample data filter based on selected period
  List<FlSpot> _filterData(String period, LineData data) {
    switch (period) {
      case '1m':
        return data.spots.where((spot) => spot.x <= 30).toList(); // 1 month
      case '2m':
        return data.spots.where((spot) => spot.x <= 60).toList(); // 2 months
      case '3m':
        return data.spots.where((spot) => spot.x <= 90).toList(); // 3 months
      case '6m':
        return data.spots.where((spot) => spot.x <= 180).toList(); // 6 months
      case '1y':
        return data.spots; // 1 year (all data)
      default:
        return data.spots;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = LineData();
    final filteredSpots = _filterData(_selectedPeriod, data);

    return CustomCard(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Steps Overview",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['1m', '2m', '3m', '6m', '1y'].map((period) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedPeriod = period;
                    });
                  },
                  child: Text(
                    period,
                    style: TextStyle(
                      color:
                          _selectedPeriod == period ? Colors.blue : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 16 / 6,
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
                      sideTitles: SideTitles(
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return data.leftTitle[value.toInt()] != null
                              ? Text(
                                  data.leftTitle[value.toInt()].toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[400]),
                                )
                              : const SizedBox();
                        },
                        showTitles: true,
                        interval: 1,
                        reservedSize: 40,
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
}
