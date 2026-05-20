import 'package:dscity_mobile_app/screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String login = '/login';
  static const String home = '/home';
  static const String map = '/map';
  static const String shareVehicle = '/share';
  static const String profile = '/profile';

  static final routes = <String, WidgetBuilder>{
    login: (_) => const AuthPage(),
    home: (_) => const HomeNavigationPage(),
    // map: (_) => const MapSearchScreen(),
    // shareVehicle: (_) => const ShareVehiclePage(),
    // profile : (_) => const ProfileScreen()
  };
}