import 'package:flutter/material.dart';
import 'core/app_router.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const ShopInsightsApp());
}

class ShopInsightsApp extends StatelessWidget {
  const ShopInsightsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Insights',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: AppRouter.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
