import 'package:dscity_mobile_app/core/constants/app_strings.dart';
import 'package:dscity_mobile_app/features/auth/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/assets/assets.dart';
import '../../../core/routes/routes.dart';
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
    Navigator.of(context).pushReplacementNamed('/home');

    if (!_formKey.currentState!.validate()) return;
    final success = await ref
        .read(loginProvider.notifier)
        .login(
      phone: _phoneController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đăng nhập thành công')));
    }
    // Navigator.of(context).pushReplacementNamed('/home');


  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref
        .watch(loginProvider);
    final color = Theme
        .of(context)
        .colorScheme;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
          CustomTextField(label: AppStrings.titlePhoneNumber,
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
        CustomTextField(label: AppStrings.titlePassword,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                  AppStrings.txtForgotPassword, style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: _onLogin,
            style: TextButton.styleFrom(
          backgroundColor: color.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: loginState.isLoading
              ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: color.onPrimary,
            ),
          )
              : Text('Đăng nhập', style: TextStyle(color: color.onPrimary)),
          ),
      ),
      SizedBox(height: 18),
      orDivider(color),
      SizedBox(height: 18),
      SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffF2F2F2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagesResource.pngIcGoogle,
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 12),
              const Text(
                "Đăng nhập với Google",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 18),
      SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffF2F2F2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagesResource.pngIcApple,
                height: 20,
                width: 20,
                alignment: Alignment.centerLeft,
              ),
              const SizedBox(width: 12),
              const Text(
                "Đăng nhập với Apple",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),

      SizedBox(height: 24),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Chưa có tài khoản? '),
          TextButton(
            onPressed: () => widget.onSwitch(1),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Text(
              'Đăng ký ngay', style: TextStyle(fontWeight: FontWeight.w800),),
          ),
        ],
      ),
      ],
    ),)
    ,
    );
  }

  Widget orDivider(ColorScheme color) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: color.onSurface.withValues(alpha: 0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Hoặc",
            style: TextStyle(
              color: color.onSurface.withValues(alpha: 0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: color.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
