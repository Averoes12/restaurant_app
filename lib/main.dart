import 'package:flutter/material.dart';
import 'package:restaurant_app/data/Restaurant.dart';
import 'package:restaurant_app/presentation/restaurant/view/restaurant.dart';
import 'package:restaurant_app/presentation/restaurant_detail/view/restaurant_detail.dart';
import 'package:restaurant_app/presentation/splash_screen.dart';
import 'package:restaurant_app/routes/Routes.dart';

import 'style/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: primaryColor,
            onPrimary: Colors.black,
            secondary: secondaryColor,
          ),
          textTheme: textTheme,
          appBarTheme: const AppBarTheme(elevation: 0.0),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  )
              )
          )
      ),
      initialRoute: Routes.splashScreen.toString(),
      routes: {
        Routes.splashScreen.toString():(context) => const SplashScreen(),
        Routes.restaurant.toString(): (context) => const RestaurantScreen(),
        Routes.restaurantDetail.toString() : (context) => RestaurantDetailScreen(
          restaurant: ModalRoute.of(context)?.settings.arguments as RestaurantElement,
        ),
      },
    );
  }
}