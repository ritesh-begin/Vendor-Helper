import '../models/user_model.dart';

class AuthService {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<UserModel> login(String email, String password) async {
    // This would integrate with Firebase Auth or custom auth backend
    // For now, this is a placeholder implementation
    
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    // Simulate successful login
    _currentUser = UserModel(
      id: 'user_123',
      email: email,
      displayName: email.split('@')[0],
      shopName: 'Demo Shop',
      phoneNumber: '+1234567890',
      createdAt: DateTime.now(),
      isVerified: true,
    );

    return _currentUser!;
  }

  Future<UserModel> register({
    required String email,
    required String password,
    required String displayName,
    String? shopName,
    String? phoneNumber,
  }) async {
    // This would integrate with Firebase Auth or custom auth backend
    // For now, this is a placeholder implementation
    
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty || displayName.isEmpty) {
      throw Exception('Email, password, and display name are required');
    }

    // Simulate successful registration
    _currentUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: displayName,
      shopName: shopName,
      phoneNumber: phoneNumber,
      createdAt: DateTime.now(),
      isVerified: false,
    );

    return _currentUser!;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (email.isEmpty) {
      throw Exception('Email is required');
    }
    
    // Simulate password reset email sent
  }

  Future<UserModel> updateProfile({
    String? displayName,
    String? shopName,
    String? phoneNumber,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_currentUser == null) {
      throw Exception('No user is currently logged in');
    }

    _currentUser = _currentUser!.copyWith(
      displayName: displayName ?? _currentUser!.displayName,
      shopName: shopName ?? _currentUser!.shopName,
      phoneNumber: phoneNumber ?? _currentUser!.phoneNumber,
    );

    return _currentUser!;
  }
}
