

import 'package:dscity_mobile_app/features/auth/provider/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
    LoginNotifier.new
);


class LoginNotifier extends Notifier<LoginState>
{
  @override
  LoginState build() {
    return const LoginState();
  }

  Future<bool> login({
    required String phone,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error:  e.toString()
      );
      return false;
    }
  }
}