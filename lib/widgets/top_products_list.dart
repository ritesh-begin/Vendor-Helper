import 'package:flutter/material.dart';
import '../models/dashboard_summary.dart';

/// Widget to display top selling products
class TopProductsList extends StatelessWidget {
  final List<TopProduct> products;

  const TopProductsList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('No products data available'),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              '${index + 1}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            product.productName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${product.salesCount} units sold'),
          trailing: Text(
            '\$${product.revenue.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
