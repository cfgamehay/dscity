import '../../features/main_app/main_app.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  static void show() {
    showDialog(
      barrierColor: Colors.black12,
      barrierDismissible: true,
      context: navigatorKey.currentState!.overlay!.context,
      builder: (ctx) => Theme(
        data: Theme.of(ctx).copyWith(
          dialogTheme: const DialogThemeData(
            backgroundColor: Colors.transparent,
          ),
        ),
        child: const LoadingWidget(),
      ),
    );
  }

  // static bool _isThereCurrentDialogShowing(BuildContext context) =>
  static void hide() {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          width: 60,
          height: 60,
          alignment: Alignment.center,
          child: const CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
