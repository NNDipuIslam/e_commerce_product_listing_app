import 'package:e_commerce_product_listing_app/features/search/presentation/pages/home_screen.dart';
import 'package:e_commerce_product_listing_app/features/search/presentation/pages/search_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String homeScreen = "/homeScreen";
  static const String searchScreen = "/searchScreen";

  // Defining the routes map with type safety
  static Map<String, WidgetBuilder> get routes => {
        homeScreen: (context) => const HomeScreen(),
        searchScreen: (context) => const SearchScreen()
      };

  // Error Route
  static Route<dynamic> errorRoute(RouteSettings settings) {
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

  // Dynamic Route
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case searchScreen:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      default:
        return errorRoute(settings);
    }
  }
}
