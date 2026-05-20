import 'package:dscity_mobile_app/features/auth/page/login_page.dart';
import 'package:dscity_mobile_app/features/auth/page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthPage> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isSwitching = false;

  Future<void> _switchTab(int index) async {
    if (_isSwitching) return;

    final currentIndex = ref.read(authProvider).selectedIndex;
    if (index == currentIndex) return;

    _isSwitching = true;

    try {
      await _controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );

      if (!mounted) return;
      ref.read(authProvider.notifier).switchTab(index);
    } finally {
      _isSwitching = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 250,
              child: Text(
                'Chào mừng bạn đến với DSCITY',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: color.primary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Đăng nhập hoặc đăng ký để tiếp tục',
              style: TextStyle(fontSize: 12, color: color.primary),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  LoginScreen(onSwitch: _switchTab),
                  SignupScreen(onSwitch: _switchTab),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
