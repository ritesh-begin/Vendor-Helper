import '../models/sale_model.dart';

/// Abstract repository interface for sales data
abstract class SalesRepository {
  /// Get all sales
  Future<List<SaleModel>> getAllSales();
  
  /// Get sales within a date range
  Future<List<SaleModel>> getSalesByDateRange(DateTime start, DateTime end);
  
  /// Get sales by category
  Future<List<SaleModel>> getSalesByCategory(String category);
  
  /// Add a new sale
  Future<void> addSale(SaleModel sale);
  
  /// Update an existing sale
  Future<void> updateSale(SaleModel sale);
  
  /// Delete a sale
  Future<void> deleteSale(String saleId);
  
  /// Get a single sale by ID
  Future<SaleModel?> getSaleById(String saleId);
}
