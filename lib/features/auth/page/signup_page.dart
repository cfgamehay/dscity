import 'package:dscity_mobile_app/core/utils/utils.dart';
import 'package:dscity_mobile_app/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_strings.dart';
import '../provider/signup_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  final Function(int) onSwitch;

  const SignupScreen({super.key, required this.onSwitch});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onSignup() async {
    if (!_formKey.currentState!.validate()) return;

    //gọi qua provider
    final success = await ref
        .read(signupProvider.notifier)
        .signup(
          fullName: _fullNameController.text.trim(),
          phone: _phoneController.text.trim(),
          password: _passwordController.text,
        );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đăng ký thành công')));
    }
  }


  @override
  Widget build(BuildContext context) {
    final signupState = ref.watch(signupProvider);
    final color = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: AppStrings.titleFullname,
              hintText: AppStrings.hintFullname,
              controller: _fullNameController,
              validator: (value)
              {
                String message = ValidateUtils.validateUsername(
                  context: context,
                  value: value ?? '',
                );

                return message != '' ? message : null;
              }
              ,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(height: 12),
            CustomTextField(
              label: AppStrings.titlePhoneNumber,
              hintText: AppStrings.hintPhoneNumber,
              controller: _phoneController,
              validator: (value) {
                String message = ValidateUtils.validatePhone(
                  context: context,
                  value: value ?? '',
                );

                return message != '' ? message : null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(height: 12),
            CustomTextField(
              label: AppStrings.titlePassword,
              hintText: AppStrings.hintPassWord,
              controller: _passwordController,
              validator: (value) {
                String message = ValidateUtils.validatePassword(
                  context: context,
                  value: value ?? '',
                );

                return message != '' ? message : null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              isPassword: true,
            ),
            SizedBox(height: 12),
            CustomTextField(
              label: AppStrings.titleConfirmPassword,
              hintText: AppStrings.hintConfirmPassword,
              controller: _confirmPasswordController,
              validator: (value) {
                String message = ValidateUtils.validateConfirmPassword(
                  context: context,
                  newPassword: value ?? '',
                  oldPassword: _passwordController.text,
                );

                return message != '' ? message : null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              isPassword: true,
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: signupState.isLoading ? null : _onSignup,
                style: TextButton.styleFrom(
                  backgroundColor: color.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: signupState.isLoading
                    ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: color.onPrimary,
                  ),
                )
                    : Text('Đăng ký', style: TextStyle(color: color.onPrimary)),
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Đã có tài khoản? '),
                TextButton(
                  onPressed: () => widget.onSwitch(0),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    'Đăng nhập ngay',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
