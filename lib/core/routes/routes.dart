import 'package:dscity_mobile_app/features/map/page/map_page.dart';
import 'package:dscity_mobile_app/screen.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String login = '/login';
  static const String home = '/home';
  static const String map = '/map';
  static const String shareVehicle = '/share';
  static const String profile = '/profile';
  static const String carDetail = '/vehicle-vehicle';
  static const String motorbikeDetail = '/motorbike-vehicle';
  static const String parkingDetail = '/parking-vehicle';
  static const String rideShareDetail = '/ride-share-vehicle';


  static final routes = <String, WidgetBuilder>{
    login: (_) => const AuthPage(),
    home: (_) => const HomeNavigationPage(),
    map: (_) => const MapPage(),

    // shareVehicle: (_) => const ShareVehiclePage(),
    // profile : (_) => const ProfileScreen()
  };
}