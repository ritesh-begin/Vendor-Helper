import '../models/sale_model.dart';
import 'sales_repository.dart';

/// Dummy implementation of SalesRepository for testing and development
class DummySalesRepository implements SalesRepository {
  final List<SaleModel> _sales = [];

  DummySalesRepository() {
    _initializeDummyData();
  }

  void _initializeDummyData() {
    final now = DateTime.now();
    _sales.addAll([
      SaleModel(
        id: '1',
        productName: 'Laptop',
        category: 'Electronics',
        price: 999.99,
        quantity: 2,
        totalAmount: 1999.98,
        saleDate: now.subtract(const Duration(days: 1)),
        notes: 'High-end gaming laptop',
      ),
      SaleModel(
        id: '2',
        productName: 'T-Shirt',
        category: 'Clothing',
        price: 19.99,
        quantity: 5,
        totalAmount: 99.95,
        saleDate: now.subtract(const Duration(days: 2)),
      ),
      SaleModel(
        id: '3',
        productName: 'Coffee Beans',
        category: 'Food',
        price: 12.50,
        quantity: 3,
        totalAmount: 37.50,
        saleDate: now.subtract(const Duration(days: 3)),
      ),
      SaleModel(
        id: '4',
        productName: 'Programming Book',
        category: 'Books',
        price: 45.00,
        quantity: 1,
        totalAmount: 45.00,
        saleDate: now.subtract(const Duration(days: 4)),
      ),
    ]);
  }

  @override
  Future<List<SaleModel>> getAllSales() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_sales);
  }

  @override
  Future<List<SaleModel>> getSalesByDateRange(DateTime start, DateTime end) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _sales
        .where((sale) =>
            (sale.saleDate.isAfter(start) || sale.saleDate.isAtSameMomentAs(start)) &&
            (sale.saleDate.isBefore(end) || sale.saleDate.isAtSameMomentAs(end)))
        .toList();
  }

  @override
  Future<List<SaleModel>> getSalesByCategory(String category) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _sales.where((sale) => sale.category == category).toList();
  }

  @override
  Future<void> addSale(SaleModel sale) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _sales.add(sale);
  }

  @override
  Future<void> updateSale(SaleModel sale) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _sales.indexWhere((s) => s.id == sale.id);
    if (index != -1) {
      _sales[index] = sale;
    }
  }

  @override
  Future<void> deleteSale(String saleId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _sales.removeWhere((sale) => sale.id == saleId);
  }

  @override
  Future<SaleModel?> getSaleById(String saleId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _sales.firstWhere((sale) => sale.id == saleId);
    } catch (e) {
      return null;
    }
  }
}
