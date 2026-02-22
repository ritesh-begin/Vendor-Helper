abstract class InsightsRepository {
  Future<Map<String, dynamic>> getInsights({
    required DateTime startDate,
    required DateTime endDate,
    String? category,
  });
  
  Future<List<String>> getSuggestions({
    required Map<String, dynamic> salesData,
  });
  
  Future<Map<String, dynamic>> analyzeTrends({
    required DateTime startDate,
    required DateTime endDate,
  });
}
