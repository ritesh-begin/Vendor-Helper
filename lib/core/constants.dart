class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'http://localhost:8000';
  static const String geminiApiEndpoint = '/api/insights';
  
  // Firebase Configuration
  static const String firebaseCollection = 'sales';
  
  // App Settings
  static const String appName = 'Shop Insights';
  static const String appVersion = '1.0.0';
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userIdKey = 'user_id';
  
  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  
  // Chart Settings
  static const int maxChartDataPoints = 30;
  static const int topProductsCount = 10;
  
  // OCR Settings
  static const double ocrConfidenceThreshold = 0.7;
}
