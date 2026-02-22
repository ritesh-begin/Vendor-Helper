import '../models/dashboard_summary.dart';
import '../models/sale_model.dart';
import '../repositories/sales_repository.dart';

class DashboardService {
  final SalesRepository salesRepository;

  DashboardService({required this.salesRepository});

  Future<DashboardSummary> getDashboardSummary({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final sales = await salesRepository.getSales(
      startDate: startDate,
      endDate: endDate,
    );

    // Calculate total revenue and sales count
    double totalRevenue = 0;
    int totalSales = sales.length;
    Map<String, double> categoryRevenue = {};
    Map<String, int> productQuantities = {};
    Map<String, double> productRevenue = {};
    Map<String, int> dailySalesCount = {};
    Map<String, double> dailySalesRevenue = {};

    for (var sale in sales) {
      totalRevenue += sale.totalAmount;
      
      // Category revenue
      categoryRevenue[sale.category] = 
          (categoryRevenue[sale.category] ?? 0) + sale.totalAmount;
      
      // Product quantities and revenue
      productQuantities[sale.productName] = 
          (productQuantities[sale.productName] ?? 0) + sale.quantity;
      productRevenue[sale.productName] = 
          (productRevenue[sale.productName] ?? 0) + sale.totalAmount;
      
      // Daily sales
      final dateKey = sale.saleDate.toIso8601String().split('T')[0];
      dailySalesCount[dateKey] = (dailySalesCount[dateKey] ?? 0) + 1;
      dailySalesRevenue[dateKey] = 
          (dailySalesRevenue[dateKey] ?? 0) + sale.totalAmount;
    }

    // Calculate average sale value
    double averageSaleValue = totalSales > 0 ? totalRevenue / totalSales : 0;

    // Get top products
    final topProductsList = productQuantities.entries
        .map((entry) => TopProduct(
              productName: entry.key,
              quantity: entry.value,
              revenue: productRevenue[entry.key] ?? 0,
            ))
        .toList()
      ..sort((a, b) => b.revenue.compareTo(a.revenue));

    // Get daily sales
    final dailySalesList = dailySalesCount.entries
        .map((entry) => DailySale(
              date: DateTime.parse(entry.key),
              revenue: dailySalesRevenue[entry.key] ?? 0,
              count: entry.value,
            ))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return DashboardSummary(
      totalRevenue: totalRevenue,
      totalSales: totalSales,
      averageSaleValue: averageSaleValue,
      categoryRevenue: categoryRevenue,
      topProducts: topProductsList.take(10).toList(),
      dailySales: dailySalesList,
    );
  }
}
