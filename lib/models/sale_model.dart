/// Model representing a sale transaction
class SaleModel {
  final String id;
  final String productName;
  final String category;
  final double price;
  final int quantity;
  final double totalAmount;
  final DateTime saleDate;
  final String? notes;

  SaleModel({
    required this.id,
    required this.productName,
    required this.category,
    required this.price,
    required this.quantity,
    required this.totalAmount,
    required this.saleDate,
    this.notes,
  });

  /// Create SaleModel from JSON
  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id'] as String,
      productName: json['productName'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      saleDate: DateTime.parse(json['saleDate'] as String),
      notes: json['notes'] as String?,
    );
  }

  /// Convert SaleModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'category': category,
      'price': price,
      'quantity': quantity,
      'totalAmount': totalAmount,
      'saleDate': saleDate.toIso8601String(),
      'notes': notes,
    };
  }

  /// Create a copy with updated fields
  SaleModel copyWith({
    String? id,
    String? productName,
    String? category,
    double? price,
    int? quantity,
    double? totalAmount,
    DateTime? saleDate,
    String? notes,
  }) {
    return SaleModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      totalAmount: totalAmount ?? this.totalAmount,
      saleDate: saleDate ?? this.saleDate,
      notes: notes ?? this.notes,
    );
  }
}
