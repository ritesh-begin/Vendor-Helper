import '../models/sale_model.dart';
import 'sales_repository.dart';

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
        notes: 'Customer requested gift wrapping',
      ),
      SaleModel(
        id: '2',
        productName: 'Coffee Maker',
        category: 'Appliances',
        price: 79.99,
        quantity: 1,
        totalAmount: 79.99,
        saleDate: now.subtract(const Duration(days: 2)),
      ),
      SaleModel(
        id: '3',
        productName: 'Office Chair',
        category: 'Furniture',
        price: 249.50,
        quantity: 3,
        totalAmount: 748.50,
        saleDate: now.subtract(const Duration(days: 3)),
      ),
    ]);
  }

  @override
  Future<List<SaleModel>> getSales({DateTime? startDate, DateTime? endDate}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (startDate == null && endDate == null) {
      return List.from(_sales);
    }
    
    return _sales.where((sale) {
      if (startDate != null && sale.saleDate.isBefore(startDate)) {
        return false;
      }
      if (endDate != null && sale.saleDate.isAfter(endDate)) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Future<SaleModel> addSale(SaleModel sale) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _sales.add(sale);
    return sale;
  }

  @override
  Future<SaleModel> updateSale(SaleModel sale) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _sales.indexWhere((s) => s.id == sale.id);
    if (index != -1) {
      _sales[index] = sale;
      return sale;
    }
    throw Exception('Sale not found');
  }

  @override
  Future<void> deleteSale(String saleId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _sales.removeWhere((s) => s.id == saleId);
  }

  @override
  Future<SaleModel?> getSaleById(String saleId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _sales.firstWhere((s) => s.id == saleId);
    } catch (e) {
      return null;
    }
  }
}
