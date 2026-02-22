import 'package:flutter/material.dart';
import '../repositories/dummy_insights_repository.dart';
import '../widgets/insight_card.dart';

/// Screen for AI-powered insights
class AIInsightScreen extends StatefulWidget {
  const AIInsightScreen({super.key});

  @override
  State<AIInsightScreen> createState() => _AIInsightScreenState();
}

class _AIInsightScreenState extends State<AIInsightScreen> {
  final _insightsRepository = DummyInsightsRepository();
  String? _businessInsights;
  List<String>? _recommendations;
  Map<String, dynamic>? _predictions;
  Map<String, dynamic>? _trends;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadInsights();
  }

  Future<void> _loadInsights() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final endDate = DateTime.now();
      final startDate = endDate.subtract(const Duration(days: 30));

      final results = await Future.wait([
        _insightsRepository.getBusinessInsights(
          startDate: startDate,
          endDate: endDate,
        ),
        _insightsRepository.getProductRecommendations(),
        _insightsRepository.getSalesPredictions(daysAhead: 7),
        _insightsRepository.analyzeTrends(
          startDate: startDate,
          endDate: endDate,
        ),
      ]);

      setState(() {
        _businessInsights = results[0] as String;
        _recommendations = results[1] as List<String>;
        _predictions = results[2] as Map<String, dynamic>;
        _trends = results[3] as Map<String, dynamic>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Insights'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadInsights,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Analyzing your data with AI...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadInsights,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadInsights,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_businessInsights != null)
            InsightCard(
              title: 'Business Insights',
              icon: Icons.insights,
              color: Colors.blue,
              child: Text(_businessInsights!),
            ),
          const SizedBox(height: 16),
          if (_recommendations != null && _recommendations!.isNotEmpty)
            InsightCard(
              title: 'Product Recommendations',
              icon: Icons.recommend,
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _recommendations!
                    .map((rec) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle, 
                                  size: 20, color: Colors.green),
                              const SizedBox(width: 8),
                              Expanded(child: Text(rec)),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          const SizedBox(height: 16),
          if (_predictions != null)
            InsightCard(
              title: 'Sales Predictions',
              icon: Icons.trending_up,
              color: Colors.orange,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Next ${_predictions!['periodDays']} days:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Predicted Revenue: \$${_predictions!['predictedRevenue']}'),
                  Text('Expected Sales: ${_predictions!['expectedSales']}'),
                  Text('Confidence: ${(_predictions!['confidence'] * 100).toStringAsFixed(0)}%'),
                ],
              ),
            ),
          const SizedBox(height: 16),
          if (_trends != null)
            InsightCard(
              title: 'Trend Analysis',
              icon: Icons.analytics,
              color: Colors.purple,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall Trend: ${_trends!['overallTrend']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Growth Rate: ${_trends!['growthRate']}%'),
                  const SizedBox(height: 12),
                  const Text(
                    'Key Insights:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...(_trends!['insights'] as List).map(
                    (insight) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('• $insight'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
