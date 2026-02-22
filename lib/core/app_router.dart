import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/add_sale_screen.dart';
import '../screens/ocr_screen.dart';
import '../screens/ai_insight_screen.dart';

class AppRouter {
  static const String loginRoute = '/';
  static const String dashboardRoute = '/dashboard';
  static const String addSaleRoute = '/add-sale';
  static const String ocrRoute = '/ocr';
  static const String aiInsightRoute = '/ai-insight';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case addSaleRoute:
        return MaterialPageRoute(builder: (_) => const AddSaleScreen());
      case ocrRoute:
        return MaterialPageRoute(builder: (_) => const OCRScreen());
      case aiInsightRoute:
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
