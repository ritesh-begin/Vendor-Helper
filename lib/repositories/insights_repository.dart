/// Abstract repository interface for AI-powered insights
abstract class InsightsRepository {
  /// Get business insights based on sales data
  Future<String> getBusinessInsights({
    required DateTime startDate,
    required DateTime endDate,
  });
  
  /// Get product recommendations
  Future<List<String>> getProductRecommendations();
  
  /// Get sales predictions for the next period
  Future<Map<String, dynamic>> getSalesPredictions({
    required int daysAhead,
  });
  
  /// Analyze trends in sales data
  Future<Map<String, dynamic>> analyzeTrends({
    required DateTime startDate,
    required DateTime endDate,
  });
}
