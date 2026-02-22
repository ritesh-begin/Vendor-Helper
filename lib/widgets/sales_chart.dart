import 'package:flutter/material.dart';
import '../models/dashboard_summary.dart';

class SalesChart extends StatelessWidget {
  final List<DailySale> dailySales;

  const SalesChart({
    Key? key,
    required this.dailySales,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dailySales.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text('No sales data available'),
          ),
        ),
      );
    }

    final maxRevenue = dailySales
        .map((s) => s.revenue)
        .reduce((a, b) => a > b ? a : b);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daily Revenue',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: dailySales.asMap().entries.map((entry) {
                  final sale = entry.value;
                  final height = (sale.revenue / maxRevenue) * 180;
                  
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Tooltip(
                            message: '\$${sale.revenue.toStringAsFixed(2)}',
                            child: Container(
                              height: height,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                  topRight: Radius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${sale.date.day}',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
