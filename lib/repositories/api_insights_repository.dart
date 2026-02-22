import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import 'insights_repository.dart';

/// API-based implementation of InsightsRepository
class ApiInsightsRepository implements InsightsRepository {
  final http.Client _client;
  final String _baseUrl;

  ApiInsightsRepository({
    http.Client? client,
    String? baseUrl,
  })  : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? AppConstants.baseUrl;

  @override
  Future<String> getBusinessInsights({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/insights/business'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['insights'] as String;
    } else {
      throw Exception('Failed to get business insights: ${response.statusCode}');
    }
  }

  @override
  Future<List<String>> getProductRecommendations() async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/api/insights/recommendations'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return List<String>.from(data['recommendations'] as List);
    } else {
      throw Exception('Failed to get recommendations: ${response.statusCode}');
    }
  }

  @override
  Future<Map<String, dynamic>> getSalesPredictions({
    required int daysAhead,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/insights/predictions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'daysAhead': daysAhead}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to get predictions: ${response.statusCode}');
    }
  }

  @override
  Future<Map<String, dynamic>> analyzeTrends({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/api/insights/trends'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to analyze trends: ${response.statusCode}');
    }
  }
}
