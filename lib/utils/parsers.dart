import '../models/sale_model.dart';

/// Utility functions for parsing data
class Parsers {
  /// Parse sale data from CSV format
  static List<SaleModel> parseSalesFromCSV(String csvData) {
    final lines = csvData.split('\n');
    final sales = <SaleModel>[];

    // Skip header line
    for (int i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      final parts = line.split(',');
      if (parts.length >= 7) {
        try {
          sales.add(SaleModel(
            id: parts[0],
            productName: parts[1],
            category: parts[2],
            price: double.parse(parts[3]),
            quantity: int.parse(parts[4]),
            totalAmount: double.parse(parts[5]),
            saleDate: DateTime.parse(parts[6]),
            notes: parts.length > 7 ? parts[7] : null,
          ));
        } catch (e) {
          // Skip invalid lines
          continue;
        }
      }
    }

    return sales;
  }

  /// Convert sales list to CSV format
  static String salesToCSV(List<SaleModel> sales) {
    final buffer = StringBuffer();
    buffer.writeln('id,productName,category,price,quantity,totalAmount,saleDate,notes');

    for (final sale in sales) {
      buffer.writeln(
        '${sale.id},${sale.productName},${sale.category},'
        '${sale.price},${sale.quantity},${sale.totalAmount},'
        '${sale.saleDate.toIso8601String()},${sale.notes ?? ''}',
      );
    }

    return buffer.toString();
  }

  /// Parse receipt text to extract items and prices
  static Map<String, dynamic> parseReceiptText(String text) {
    final lines = text.split('\n');
    final items = <Map<String, dynamic>>[];
    double total = 0.0;

    // More restrictive pattern for prices - requires currency symbol or decimal point
    final pricePattern = RegExp(r'(?:\$|USD|€|£)?\s*(\d+\.\d{2})\b');
    
    for (final line in lines) {
      final trimmedLine = line.trim();
      if (trimmedLine.isEmpty) continue;

      // Try to extract price from line
      final matches = pricePattern.allMatches(trimmedLine);
      for (final match in matches) {
        final priceStr = match.group(1);
        if (priceStr != null) {
          final price = double.tryParse(priceStr);
          if (price != null && price > 0) {
            // Extract item description (text before the price)
            final description = trimmedLine
                .substring(0, match.start)
                .trim()
                .replaceAll(RegExp(r'[^\w\s]'), '');
            
            if (description.isNotEmpty) {
              items.add({
                'description': description,
                'price': price,
              });
              total += price;
            }
          }
        }
      }
    }

    return {
      'items': items,
      'total': total,
      'itemCount': items.length,
    };
  }

  /// Format currency value
  static String formatCurrency(double value, {String symbol = '\$'}) {
    return '$symbol${value.toStringAsFixed(2)}';
  }

  /// Format date to readable string
  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Format date with time
  static String formatDateTime(DateTime date) {
    return '${formatDate(date)} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
