import 'package:flutter/material.dart';
import 'core/app_router.dart';

void main() {
  runApp(const ShopInsightsApp());
}

class ShopInsightsApp extends StatelessWidget {
  const ShopInsightsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Insights',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.loginRoute,
    );
  }
}
