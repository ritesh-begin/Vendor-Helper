import 'package:flutter/material.dart';

class InsightCard extends StatelessWidget {
  final String title;
  final String description;
  final String sentiment;
  final String type;

  const InsightCard({
    Key? key,
    required this.title,
    required this.description,
    required this.sentiment,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildSentimentIcon(),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Chip(
              label: Text(
                _getTypeLabel(),
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: _getTypeColor().withOpacity(0.2),
              labelStyle: TextStyle(color: _getTypeColor()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentimentIcon() {
    IconData icon;
    Color color;

    switch (sentiment.toLowerCase()) {
      case 'positive':
        icon = Icons.trending_up;
        color = Colors.green;
        break;
      case 'negative':
        icon = Icons.trending_down;
        color = Colors.red;
        break;
      default:
        icon = Icons.trending_flat;
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  String _getTypeLabel() {
    switch (type) {
      case 'revenue_trend':
        return 'Revenue Trend';
      case 'top_category':
        return 'Category Insight';
      case 'slow_product':
        return 'Product Alert';
      default:
        return 'Insight';
    }
  }

  Color _getTypeColor() {
    switch (sentiment.toLowerCase()) {
      case 'positive':
        return Colors.green;
      case 'negative':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
