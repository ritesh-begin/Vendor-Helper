import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import 'insights_repository.dart';

class ApiInsightsRepository implements InsightsRepository {
  final String baseUrl;
  final http.Client client;

  ApiInsightsRepository({
    this.baseUrl = AppConstants.apiBaseUrl,
    http.Client? client,
  }) : client = client ?? http.Client();

  @override
  Future<Map<String, dynamic>> getInsights({
    required DateTime startDate,
    required DateTime endDate,
    String? category,
  }) async {
    final uri = Uri.parse('$baseUrl${AppConstants.geminiApiEndpoint}');
    
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'action': 'get_insights',
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
        'category': category,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to get insights: ${response.statusCode}');
    }
  }

  @override
  Future<List<String>> getSuggestions({
    required Map<String, dynamic> salesData,
  }) async {
    final uri = Uri.parse('$baseUrl${AppConstants.geminiApiEndpoint}');
    
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'action': 'get_suggestions',
        'sales_data': salesData,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['suggestions'] as List).cast<String>();
    } else {
      throw Exception('Failed to get suggestions: ${response.statusCode}');
    }
  }

  @override
  Future<Map<String, dynamic>> analyzeTrends({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final uri = Uri.parse('$baseUrl${AppConstants.geminiApiEndpoint}');
    
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'action': 'analyze_trends',
        'start_date': startDate.toIso8601String(),
        'end_date': endDate.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to analyze trends: ${response.statusCode}');
    }
  }
}
