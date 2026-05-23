import 'package:dscity_mobile_app/core/constants/app_strings.dart';
import 'package:dscity_mobile_app/features/auth/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/assets/assets.dart';
import '../../../core/theme/theme.dart';
import '../../../core/utils/validate_utils.dart';
import '../../../core/widgets/custom_textfield.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final Function(int) onSwitch;

  const LoginScreen({super.key, required this.onSwitch});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    // if (!_formKey.currentState!.validate()) return;
    // final success = await ref.read(loginProvider.notifier).login(
    //       phone: _phoneController.text.trim(),
    //       password: _passwordController.text,
    //     );
    //
    // if (!mounted || !success) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Đăng nhập thành công')),
    );
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: AppStrings.titlePhoneNumber,
              hintText: AppStrings.hintPhoneNumber,
              controller: _phoneController,
              validator: (value) {
                final message = ValidateUtils.validatePhone(
                  context: context,
                  value: value ?? '',
                );
                return message.isNotEmpty ? message : null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              label: AppStrings.titlePassword,
              hintText: AppStrings.hintPassWord,
              controller: _passwordController,
              validator: (value) {
                final message = ValidateUtils.validatePassword(
                  context: context,
                  value: value ?? '',
                );
                return message.isNotEmpty ? message : null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              isPassword: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.txtForgotPassword,
                    style: textTheme.labelMedium,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _onLogin,
                child: loginState.isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: color.onPrimary,
                        ),
                      )
                    : const Text('Đăng nhập'),
              ),
            ),
            const SizedBox(height: 18),
            _orDivider(color),
            const SizedBox(height: 18),
            _SocialLoginButton(
              iconPath: ImagesResource.pngIcGoogle,
              label: 'Đăng nhập với Google',
            ),
            const SizedBox(height: 18),
            _SocialLoginButton(
              iconPath: ImagesResource.pngIcApple,
              label: 'Đăng nhập với Apple',
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chưa có tài khoản? ',
                  style: textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: () => widget.onSwitch(1),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'Đăng ký ngay',
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _orDivider(ColorScheme color) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: color.onSurface.withValues(alpha: 0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Hoặc',
            style: TextStyle(
              color: color.onSurface.withValues(alpha: 0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: color.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  final String iconPath;
  final String label;

  const _SocialLoginButton({
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
