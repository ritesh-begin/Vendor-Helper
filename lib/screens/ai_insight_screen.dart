import 'package:flutter/material.dart';
import '../repositories/dummy_insights_repository.dart';
import '../widgets/insight_card.dart';

class AIInsightScreen extends StatefulWidget {
  const AIInsightScreen({Key? key}) : super(key: key);

  @override
  State<AIInsightScreen> createState() => _AIInsightScreenState();
}

class _AIInsightScreenState extends State<AIInsightScreen> {
  final _insightsRepository = DummyInsightsRepository();
  bool _isLoading = true;
  Map<String, dynamic>? _insightsData;

  @override
  void initState() {
    super.initState();
    _loadInsights();
  }

  Future<void> _loadInsights() async {
    setState(() => _isLoading = true);

    try {
      final endDate = DateTime.now();
      final startDate = endDate.subtract(const Duration(days: 30));
      
      final insights = await _insightsRepository.getInsights(
        startDate: startDate,
        endDate: endDate,
      );

      setState(() {
        _insightsData = insights;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading insights: $e')),
        );
      }
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _insightsData == null
              ? const Center(child: Text('No insights available'))
              : RefreshIndicator(
                  onRefresh: _loadInsights,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Business Insights',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'AI-powered analysis of your sales data',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 24),
                        ..._buildInsightsList(),
                        const SizedBox(height: 24),
                        const Text(
                          'Recommendations',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ..._buildRecommendationsList(),
                      ],
                    ),
                  ),
                ),
    );
  }

  List<Widget> _buildInsightsList() {
    final insights = _insightsData!['insights'] as List;
    return insights.map((insight) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: InsightCard(
          title: insight['title'] as String,
          description: insight['description'] as String,
          sentiment: insight['sentiment'] as String,
          type: insight['type'] as String,
        ),
      );
    }).toList();
  }

  List<Widget> _buildRecommendationsList() {
    final recommendations = _insightsData!['recommendations'] as List<dynamic>;
    return recommendations.asMap().entries.map((entry) {
      final index = entry.key;
      final recommendation = entry.value as String;
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text('${index + 1}'),
          ),
          title: Text(recommendation),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      );
    }).toList();
  }
}
