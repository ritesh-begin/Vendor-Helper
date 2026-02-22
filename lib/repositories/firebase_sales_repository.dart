import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sale_model.dart';
import '../core/constants.dart';
import 'sales_repository.dart';

/// Firebase implementation of SalesRepository
class FirebaseSalesRepository implements SalesRepository {
  final FirebaseFirestore _firestore;
  final String _userId;

  FirebaseSalesRepository({
    FirebaseFirestore? firestore,
    required String userId,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _userId = userId;

  CollectionReference get _salesCollection =>
      _firestore
          .collection('users')
          .doc(_userId)
          .collection(AppConstants.firebaseCollectionSales);

  @override
  Future<List<SaleModel>> getAllSales() async {
    final snapshot = await _salesCollection.orderBy('saleDate', descending: true).get();
    return snapshot.docs
        .map((doc) => SaleModel.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
        .toList();
  }

  @override
  Future<List<SaleModel>> getSalesByDateRange(DateTime start, DateTime end) async {
    final snapshot = await _salesCollection
        .where('saleDate', isGreaterThanOrEqualTo: start.toIso8601String())
        .where('saleDate', isLessThanOrEqualTo: end.toIso8601String())
        .orderBy('saleDate', descending: true)
        .get();
    
    return snapshot.docs
        .map((doc) => SaleModel.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
        .toList();
  }

  @override
  Future<List<SaleModel>> getSalesByCategory(String category) async {
    final snapshot = await _salesCollection
        .where('category', isEqualTo: category)
        .orderBy('saleDate', descending: true)
        .get();
    
    return snapshot.docs
        .map((doc) => SaleModel.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id}))
        .toList();
  }

  @override
  Future<void> addSale(SaleModel sale) async {
    final data = sale.toJson();
    data.remove('id');
    await _salesCollection.add(data);
  }

  @override
  Future<void> updateSale(SaleModel sale) async {
    final data = sale.toJson();
    data.remove('id');
    await _salesCollection.doc(sale.id).update(data);
  }

  @override
  Future<void> deleteSale(String saleId) async {
    await _salesCollection.doc(saleId).delete();
  }

  @override
  Future<SaleModel?> getSaleById(String saleId) async {
    final doc = await _salesCollection.doc(saleId).get();
    if (!doc.exists) {
      return null;
    }
    return SaleModel.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
  }
}
