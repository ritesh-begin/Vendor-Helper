class DashboardSummary {
  final double totalRevenue;
  final int totalSales;
  final double averageSaleValue;
  final Map<String, double> categoryRevenue;
  final List<TopProduct> topProducts;
  final List<DailySale> dailySales;

  DashboardSummary({
    required this.totalRevenue,
    required this.totalSales,
    required this.averageSaleValue,
    required this.categoryRevenue,
    required this.topProducts,
    required this.dailySales,
  });

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      totalSales: json['totalSales'] as int,
      averageSaleValue: (json['averageSaleValue'] as num).toDouble(),
      categoryRevenue: Map<String, double>.from(
        (json['categoryRevenue'] as Map).map(
          (key, value) => MapEntry(key as String, (value as num).toDouble()),
        ),
      ),
      topProducts: (json['topProducts'] as List)
          .map((item) => TopProduct.fromJson(item as Map<String, dynamic>))
          .toList(),
      dailySales: (json['dailySales'] as List)
          .map((item) => DailySale.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalRevenue': totalRevenue,
      'totalSales': totalSales,
      'averageSaleValue': averageSaleValue,
      'categoryRevenue': categoryRevenue,
      'topProducts': topProducts.map((p) => p.toJson()).toList(),
      'dailySales': dailySales.map((d) => d.toJson()).toList(),
    };
  }
}

class TopProduct {
  final String productName;
  final int quantity;
  final double revenue;

  TopProduct({
    required this.productName,
    required this.quantity,
    required this.revenue,
  });

  factory TopProduct.fromJson(Map<String, dynamic> json) {
    return TopProduct(
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      revenue: (json['revenue'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'quantity': quantity,
      'revenue': revenue,
    };
  }
}

class DailySale {
  final DateTime date;
  final double revenue;
  final int count;

  DailySale({
    required this.date,
    required this.revenue,
    required this.count,
  });

  factory DailySale.fromJson(Map<String, dynamic> json) {
    return DailySale(
      date: DateTime.parse(json['date'] as String),
      revenue: (json['revenue'] as num).toDouble(),
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'revenue': revenue,
      'count': count,
    };
  }
}
