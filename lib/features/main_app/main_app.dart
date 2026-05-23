import 'package:dscity_mobile_app/core/constants/app_strings.dart';
import '../../screen.dart';
import '../../core/app_config/app_config.dart';
import '../../core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/routes/routes.dart';

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  late final Future _futureBuildHome = _buildHome();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // statusBarColor: Colors.transparent,
        // statusBarIconBrightness: Brightness.dark, // for Android
        // statusBarBrightness: Brightness.dark, // for iOS
        // systemNavigationBarColor: Colors.white,
        // systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        // ScrollBehavior will remove the glow effect entirely
        builder: (context, child) {
          return ScrollConfiguration(behavior: MyBehavior(), child: child!);
        },
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        title: AppConfig.shared.appName,
        locale: const Locale('vi'),
        routes: Routes.routes,
        // navigatorObservers: [routeObserver],
        home: FutureBuilder(
          future: _futureBuildHome,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                backgroundColor: AppColors.background,
                body: Center(child: CircularProgressIndicator.adaptive()),
              );
            }
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(child: Text(AppStrings.txtErrorException)),
              );
            }
            return snapshot.data as Widget;
          },
        ),
        navigatorKey: navigatorKey,
      ),
    );
  }

  Future<Widget> _buildHome() async {
    // Check Open App First Time
    // bool isFirstOpenApp = await SecureStorageUtil.readFirstOpenApp();
    // if (isFirstOpenApp) {
    //   return const LanguageSettingPage();
    // }

    // Get config
    // final config = await ref.read(authRepositoryProvider).getConfig();
    // if (config.isNotEmpty) {
    //   // Save config to secure storage
    //   await SecureStorageUtil.writeAppConfig(jsonEncode(config));
    // }

    // var fcmToken = await DeviceUtils.getFcmToken();
    // log('FCM Token: $fcmToken');
    return const AuthPage();

    // // Check Login
    // var loginInfo = await SecureStorageUtil.readLoginInfo();
    // if (loginInfo == null) {
    //   return const LoginPage();
    // }
    // String accessToken = loginInfo.accessToken;
    // if (accessToken.isEmpty) {
    //   return const LoginPage();
    // }
    // if (kDebugMode) {
    //   log('Access Token: $accessToken');
    // }

    // // Push Home Page
    // return const HomeNavigationPage();
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// final RouteTrackingObserver routeObserver = RouteTrackingObserver();

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context,
      Widget child,
      ScrollableDetails details,
      ) {
    return child;
  }
}
