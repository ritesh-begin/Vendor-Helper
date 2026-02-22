import '../models/sale_model.dart';
import '../models/dashboard_summary.dart';
import '../repositories/sales_repository.dart';

/// Service for dashboard-related operations
class DashboardService {
  final SalesRepository _salesRepository;

  DashboardService({required SalesRepository salesRepository})
      : _salesRepository = salesRepository;

  /// Get dashboard summary for a date range
  Future<DashboardSummary> getDashboardSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final sales = await _salesRepository.getSalesByDateRange(startDate, endDate);

    // Calculate total revenue
    final totalRevenue = sales.fold<double>(
      0.0,
      (sum, sale) => sum + sale.totalAmount,
    );

    // Calculate total sales count
    final totalSales = sales.length;

    // Calculate average sale value
    final averageSaleValue = totalSales > 0 ? totalRevenue / totalSales : 0.0;

    // Category breakdown
    final categoryBreakdown = <String, double>{};
    for (final sale in sales) {
      categoryBreakdown[sale.category] =
          (categoryBreakdown[sale.category] ?? 0.0) + sale.totalAmount;
    }

    // Top products
    final productSales = <String, TopProduct>{};
    for (final sale in sales) {
      if (productSales.containsKey(sale.productName)) {
        final existing = productSales[sale.productName]!;
        productSales[sale.productName] = TopProduct(
          productName: sale.productName,
          salesCount: existing.salesCount + sale.quantity,
          revenue: existing.revenue + sale.totalAmount,
        );
      } else {
        productSales[sale.productName] = TopProduct(
          productName: sale.productName,
          salesCount: sale.quantity,
          revenue: sale.totalAmount,
        );
      }
    }
    
    final topProducts = productSales.values.toList()
      ..sort((a, b) => b.revenue.compareTo(a.revenue));

    // Sales trend (daily aggregation)
    final salesByDate = <DateTime, double>{};
    for (final sale in sales) {
      final dateOnly = DateTime(
        sale.saleDate.year,
        sale.saleDate.month,
        sale.saleDate.day,
      );
      salesByDate[dateOnly] = (salesByDate[dateOnly] ?? 0.0) + sale.totalAmount;
    }
    
    final salesTrend = salesByDate.entries
        .map((entry) => SalesDataPoint(date: entry.key, amount: entry.value))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return DashboardSummary(
      totalRevenue: totalRevenue,
      totalSales: totalSales,
      averageSaleValue: averageSaleValue,
      categoryBreakdown: categoryBreakdown,
      topProducts: topProducts.take(10).toList(),
      salesTrend: salesTrend,
    );
  }

  /// Get sales data for a specific period
  Future<List<SaleModel>> getSales({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return await _salesRepository.getSalesByDateRange(startDate, endDate);
  }

  /// Get all sales
  Future<List<SaleModel>> getAllSales() async {
    return await _salesRepository.getAllSales();
  }
}
