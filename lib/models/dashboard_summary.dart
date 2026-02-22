/// Model representing dashboard summary data
class DashboardSummary {
  final double totalRevenue;
  final int totalSales;
  final double averageSaleValue;
  final Map<String, double> categoryBreakdown;
  final List<TopProduct> topProducts;
  final List<SalesDataPoint> salesTrend;

  DashboardSummary({
    required this.totalRevenue,
    required this.totalSales,
    required this.averageSaleValue,
    required this.categoryBreakdown,
    required this.topProducts,
    required this.salesTrend,
  });

  /// Create DashboardSummary from JSON
  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      totalSales: json['totalSales'] as int,
      averageSaleValue: (json['averageSaleValue'] as num).toDouble(),
      categoryBreakdown: Map<String, double>.from(
        json['categoryBreakdown'] as Map,
      ),
      topProducts: (json['topProducts'] as List)
          .map((item) => TopProduct.fromJson(item as Map<String, dynamic>))
          .toList(),
      salesTrend: (json['salesTrend'] as List)
          .map((item) => SalesDataPoint.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Convert DashboardSummary to JSON
  Map<String, dynamic> toJson() {
    return {
      'totalRevenue': totalRevenue,
      'totalSales': totalSales,
      'averageSaleValue': averageSaleValue,
      'categoryBreakdown': categoryBreakdown,
      'topProducts': topProducts.map((p) => p.toJson()).toList(),
      'salesTrend': salesTrend.map((s) => s.toJson()).toList(),
    };
  }
}

/// Model for top selling products
class TopProduct {
  final String productName;
  final int salesCount;
  final double revenue;

  TopProduct({
    required this.productName,
    required this.salesCount,
    required this.revenue,
  });

  factory TopProduct.fromJson(Map<String, dynamic> json) {
    return TopProduct(
      productName: json['productName'] as String,
      salesCount: json['salesCount'] as int,
      revenue: (json['revenue'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'salesCount': salesCount,
      'revenue': revenue,
    };
  }
}

/// Model for sales trend data points
class SalesDataPoint {
  final DateTime date;
  final double amount;

  SalesDataPoint({
    required this.date,
    required this.amount,
  });

  factory SalesDataPoint.fromJson(Map<String, dynamic> json) {
    return SalesDataPoint(
      date: DateTime.parse(json['date'] as String),
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'amount': amount,
    };
  }
}
