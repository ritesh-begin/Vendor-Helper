import 'package:flutter/material.dart';
import '../models/dashboard_summary.dart';

class TopProductsList extends StatelessWidget {
  final List<TopProduct> topProducts;

  const TopProductsList({
    Key? key,
    required this.topProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (topProducts.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text('No product data available'),
          ),
        ),
      );
    }

    return Card(
      child: Column(
        children: topProducts.asMap().entries.map((entry) {
          final index = entry.key;
          final product = entry.value;
          final isLast = index == topProducts.length - 1;

          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getColorForRank(index),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  product.productName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Sold: ${product.quantity} units'),
                trailing: Text(
                  '\$${product.revenue.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              if (!isLast) const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }

  Color _getColorForRank(int rank) {
    switch (rank) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.grey;
      case 2:
        return Colors.brown;
      default:
        return Colors.blue;
    }
  }
}
