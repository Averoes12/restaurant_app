import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/restaurant/view/restaurant.dart';
import 'package:restaurant_app/routes/Routes.dart';
import 'package:restaurant_app/style/styles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Icon(Icons.fastfood, color: secondaryColor, size: 72,),
      splashIconSize: 64.0,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: const RestaurantScreen(),
      nextRoute: Routes.restaurant.toString(),
      backgroundColor: primaryColor,

    );
  }
}
