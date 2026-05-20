
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_state.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new
);

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  void switchTab(int index) {
    if (index == state.selectedIndex) return;
    state = state.copyWith(selectedIndex: index);
  }
}

