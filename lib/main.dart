import 'package:e_commerce_product_listing_app/core/exports.dart';
import 'package:e_commerce_product_listing_app/core/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_commerce_product_listing_app/core/service_locator.dart';
import 'package:e_commerce_product_listing_app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init(); // initialize service locator

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SearchBloc>(
              create: (context) => sl<SearchBloc>(),
            ),
            // Add other BLoCs here if needed
          ],
          child: MaterialApp(
            title: 'E commerce product for Listing app',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,navigatorKey: NavigatorService.navigatorKey,
            initialRoute: AppRoutes.homeScreen,
            routes: AppRoutes.routes,
          ),
        );
      },
    );
  }
}
