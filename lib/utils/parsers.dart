class Parsers {
  static double parsePrice(String priceString) {
    // Remove currency symbols and whitespace
    final cleaned = priceString
        .replaceAll(RegExp(r'[^\d.]'), '')
        .trim();
    
    return double.tryParse(cleaned) ?? 0.0;
  }

  static int parseQuantity(String quantityString) {
    // Remove non-numeric characters
    final cleaned = quantityString
        .replaceAll(RegExp(r'[^\d]'), '')
        .trim();
    
    return int.tryParse(cleaned) ?? 1;
  }

  static DateTime parseDate(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      // Try common date formats
      final formats = [
        RegExp(r'(\d{4})-(\d{2})-(\d{2})'), // YYYY-MM-DD
        RegExp(r'(\d{2})/(\d{2})/(\d{4})'), // MM/DD/YYYY
        RegExp(r'(\d{2})-(\d{2})-(\d{4})'), // DD-MM-YYYY
      ];

      for (var format in formats) {
        final match = format.firstMatch(dateString);
        if (match != null) {
          try {
            if (format.pattern.startsWith(r'(\d{4})')) {
              // YYYY-MM-DD
              return DateTime(
                int.parse(match.group(1)!),
                int.parse(match.group(2)!),
                int.parse(match.group(3)!),
              );
            } else if (format.pattern.contains('/')) {
              // MM/DD/YYYY
              return DateTime(
                int.parse(match.group(3)!),
                int.parse(match.group(1)!),
                int.parse(match.group(2)!),
              );
            } else {
              // DD-MM-YYYY
              return DateTime(
                int.parse(match.group(3)!),
                int.parse(match.group(2)!),
                int.parse(match.group(1)!),
              );
            }
          } catch (_) {
            continue;
          }
        }
      }
      
      return DateTime.now();
    }
  }

  static String formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static String formatDateTime(DateTime dateTime) {
    return '${formatDate(dateTime)} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
  }

  static Map<String, dynamic> parseReceiptText(String text) {
    final lines = text.split('\n');
    final result = <String, dynamic>{
      'products': <Map<String, dynamic>>[],
      'total': 0.0,
      'date': null,
    };

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty) continue;

      // Try to extract price
      final priceMatch = RegExp(r'\$?(\d+\.?\d*)').firstMatch(line);
      if (priceMatch != null) {
        final price = parsePrice(priceMatch.group(1)!);
        if (price > 0) {
          result['products'].add({
            'name': line.replaceAll(priceMatch.group(0)!, '').trim(),
            'price': price,
          });
        }
      }

      // Try to extract date
      final dateMatch = RegExp(r'(\d{2}/\d{2}/\d{4}|\d{4}-\d{2}-\d{2})')
          .firstMatch(line);
      if (dateMatch != null) {
        result['date'] = parseDate(dateMatch.group(1)!);
      }
    }

    // Calculate total
    double total = 0;
    for (var product in result['products']) {
      total += product['price'] as double;
    }
    result['total'] = total;

    return result;
  }
}
