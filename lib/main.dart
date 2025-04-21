import 'package:e_commerce_product_listing_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Ensure this import is present

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800), // Reference design size (e.g., iPhone X)
      minTextAdapt: true, // Automatically adjust text size for smaller screens
      splitScreenMode: true, // Optional: support for split-screen mode
      builder: (context, child) {
        return MaterialApp(
          title: 'E commerce product for Listing app',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.homeScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}