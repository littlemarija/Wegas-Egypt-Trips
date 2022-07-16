import 'package:flutter/material.dart';
import 'package:wegas/ui/home/ui/home_screen.dart';
import 'package:wegas/ui/onboarding/ui/onboarding.dart';


abstract class MainNavigationRoutes {
  static const String main = '/';
  static const String onboarding = '/onboarding';
}

final routes = {
  MainNavigationRoutes.main: (BuildContext context) => HomeScreen(),
  MainNavigationRoutes.onboarding: (BuildContext context) =>
  const OnBoardingScreen(),
};