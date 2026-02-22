import '../models/sale_model.dart';

abstract class SalesRepository {
  Future<List<SaleModel>> getSales({DateTime? startDate, DateTime? endDate});
  Future<SaleModel> addSale(SaleModel sale);
  Future<SaleModel> updateSale(SaleModel sale);
  Future<void> deleteSale(String saleId);
  Future<SaleModel?> getSaleById(String saleId);
}
