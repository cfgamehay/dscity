
import 'package:dscity_mobile_app/features/auth/provider/signup_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupProvider = NotifierProvider<SignupNotifier, SignupState>(
    SignupNotifier.new
);

class SignupNotifier extends Notifier<SignupState>
{
  @override
  SignupState build() {
    return SignupState();
  }
  Future<bool> signup({
    required String fullName,
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