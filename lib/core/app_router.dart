import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/add_sale_screen.dart';
import '../screens/ocr_screen.dart';
import '../screens/ai_insight_screen.dart';

/// Application routing configuration
class AppRouter {
  static const String login = '/';
  static const String dashboard = '/dashboard';
  static const String addSale = '/add-sale';
  static const String ocr = '/ocr';
  static const String aiInsight = '/ai-insight';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      
      case addSale:
        return MaterialPageRoute(builder: (_) => const AddSaleScreen());
      
      case ocr:
        return MaterialPageRoute(builder: (_) => const OCRScreen());
      
      case aiInsight:
        return MaterialPageRoute(builder: (_) => const AIInsightScreen());
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
