import 'package:e_commerce_product_listing_app/features/search/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String homeScreen = "/homeScreen";

  // Defining the routes map with type safety
  static Map<String, WidgetBuilder> get routes => {
        homeScreen: (context) => const HomeScreen(),
      };

  // Error Route
  static Route<dynamic> errorRoute(RouteSettings settings) {
    // Optionally, you could pass `settings.arguments` to error screens for debugging purposes
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(
          child: Text(
            "Oops! The page you're looking for doesn't exist.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // Dynamic Route Example: You can create routes with arguments
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      default:
        return errorRoute(settings);
    }
  }
}
