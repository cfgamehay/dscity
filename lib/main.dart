import 'features/main_app/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_config/app_config.dart';
import 'core/constants/constants.dart';
import 'core/utils/device_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // AppConfig.create(
  //   appName: Strings.APP_NAME_DEV,
  //   baseUrl: Url.devBaseUrl,
  //   gRPCHost: Url.devGRPCHost,
  //   gRPCHostFile: Url.devGRPCHostFile,
  //   gRPCPort: Url.devGRPCPort,
  //   gRPCPortChat: Url.devGRPCPortChat,
  //   gRPCPortFile: Url.devGRPCPortFile,
  //   flavor: Flavor.dev,
  // );


  runApp(const ProviderScope(child: MainApp()));
}
