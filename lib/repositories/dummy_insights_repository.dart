import 'insights_repository.dart';

/// Dummy implementation of InsightsRepository for testing and development
class DummyInsightsRepository implements InsightsRepository {
  @override
  Future<String> getBusinessInsights({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    
    return '''
Based on your sales data from ${_formatDate(startDate)} to ${_formatDate(endDate)}:

📈 Key Insights:
• Electronics category shows the highest revenue with steady growth
• Weekend sales are 35% higher than weekday sales
• Average transaction value increased by 12% compared to last period

💡 Recommendations:
• Stock up on Electronics items for the upcoming weekend
• Consider promotional campaigns for mid-week to boost sales
• Focus on upselling strategies to maintain the increasing transaction value

🎯 Action Items:
• Monitor inventory levels for top-selling products
• Analyze customer feedback for product improvements
• Plan marketing activities for slower days
    ''';
  }

  @override
  Future<List<String>> getProductRecommendations() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    
    return [
      'Wireless Headphones - High demand in Electronics',
      'Yoga Mat - Trending in Sports category',
      'Smart Watch - Popular accessory',
      'Organic Coffee - Growing Food category trend',
      'LED Desk Lamp - Office essentials category',
    ];
  }

  @override
  Future<Map<String, dynamic>> getSalesPredictions({
    required int daysAhead,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final predictions = <String, dynamic>{
      'periodDays': daysAhead,
      'predictedRevenue': 5420.50,
      'confidence': 0.85,
      'expectedSales': 127,
      'trends': {
        'Electronics': 'increasing',
        'Clothing': 'stable',
        'Food': 'increasing',
        'Books': 'stable',
      },
    };
    
    return predictions;
  }

  @override
  Future<Map<String, dynamic>> analyzeTrends({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1800));
    
    return {
      'period': {
        'start': startDate.toIso8601String(),
        'end': endDate.toIso8601String(),
      },
      'overallTrend': 'positive',
      'growthRate': 15.5,
      'categoryTrends': {
        'Electronics': {'trend': 'up', 'percentage': 22.3},
        'Clothing': {'trend': 'stable', 'percentage': 2.1},
        'Food': {'trend': 'up', 'percentage': 18.7},
        'Books': {'trend': 'down', 'percentage': -5.2},
      },
      'insights': [
        'Electronics showing strong upward trend',
        'Food category gaining momentum',
        'Books category needs attention',
      ],
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
