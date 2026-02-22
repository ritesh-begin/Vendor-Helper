/// Application-wide constants
class AppConstants {
  // API Configuration
  static const String baseUrl = 'http://localhost:8000';
  static const String apiVersion = 'v1';
  
  // Firebase Configuration
  static const String firebaseCollectionSales = 'sales';
  static const String firebaseCollectionUsers = 'users';
  
  // App Configuration
  static const String appName = 'Shop Insights';
  static const String appVersion = '1.0.0';
  
  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Chart Configuration
  static const int maxChartDataPoints = 30;
  static const int topProductsLimit = 10;
  
  // Categories
  static const List<String> productCategories = [
    'Electronics',
    'Clothing',
    'Food',
    'Books',
    'Home & Garden',
    'Sports',
    'Toys',
    'Other'
  ];
  
  // Error Messages
  static const String genericError = 'An error occurred. Please try again.';
  static const String networkError = 'Network error. Please check your connection.';
  static const String authError = 'Authentication failed. Please login again.';
}
