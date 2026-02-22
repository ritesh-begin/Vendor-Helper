import 'insights_repository.dart';

class DummyInsightsRepository implements InsightsRepository {
  @override
  Future<Map<String, dynamic>> getInsights({
    required DateTime startDate,
    required DateTime endDate,
    String? category,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    return {
      'insights': [
        {
          'type': 'revenue_trend',
          'title': 'Revenue Increasing',
          'description': 'Your revenue has increased by 15% compared to last period',
          'sentiment': 'positive',
        },
        {
          'type': 'top_category',
          'title': 'Electronics Leading',
          'description': 'Electronics category is generating the most revenue',
          'sentiment': 'neutral',
        },
        {
          'type': 'slow_product',
          'title': 'Low Sales Alert',
          'description': 'Some products have seen declining sales in the past week',
          'sentiment': 'negative',
        },
      ],
      'recommendations': [
        'Consider stocking more electronics items',
        'Promote slow-moving products with discounts',
        'Analyze peak sales hours to optimize staffing',
      ],
    };
  }

  @override
  Future<List<String>> getSuggestions({
    required Map<String, dynamic> salesData,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    return [
      'Focus on high-margin products',
      'Consider bundling related products',
      'Implement a loyalty program',
      'Optimize inventory based on demand patterns',
      'Analyze customer buying patterns',
    ];
  }

  @override
  Future<Map<String, dynamic>> analyzeTrends({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    
    return {
      'trends': [
        {
          'period': 'weekly',
          'trend': 'upward',
          'percentage': 12.5,
        },
        {
          'period': 'monthly',
          'trend': 'stable',
          'percentage': 2.3,
        },
      ],
      'predictions': {
        'next_week_revenue': 5000.0,
        'confidence': 0.85,
      },
    };
  }
}
