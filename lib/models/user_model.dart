/// Model representing a user
class UserModel {
  final String id;
  final String email;
  final String name;
  final String? shopName;
  final DateTime createdAt;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.shopName,
    required this.createdAt,
    this.photoUrl,
  });

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      shopName: json['shopName'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      photoUrl: json['photoUrl'] as String?,
    );
  }

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'shopName': shopName,
      'createdAt': createdAt.toIso8601String(),
      'photoUrl': photoUrl,
    };
  }

  /// Create a copy with updated fields
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? shopName,
    DateTime? createdAt,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      shopName: shopName ?? this.shopName,
      createdAt: createdAt ?? this.createdAt,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
