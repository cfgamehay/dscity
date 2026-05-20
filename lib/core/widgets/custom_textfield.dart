import 'package:flutter/material.dart';

import '../theme/theme.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.label,
    this.labelStyle,
    this.isDartTheme = false,
    this.hintText,
    this.icon,
    this.isPassword = false,
    this.controller,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.initialValue,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.readOnly = false,
    this.focusedBorderColor,
    this.autofocus = false,
    this.iconIncludeVerticalLine = false,
    this.fillColor,
    this.enabledBorderColor,
    this.maxLength,
    this.focusNode,
    this.textInputAction,
    this.validator,
    this.autovalidateMode,
  });

  final String? label;
  final TextStyle? labelStyle;
  final bool isDartTheme;
  final Widget? icon;
  final String? hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextAlign textAlign;
  final String? initialValue;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool readOnly;
  final Color? focusedBorderColor;
  final bool autofocus;
  final bool iconIncludeVerticalLine;
  final Color? fillColor;
  final Color? enabledBorderColor;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  late final TextEditingController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? TextEditingController();

    if (_ownsController && widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final normalBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: widget.enabledBorderColor ??
            (widget.isDartTheme
                ? AppColors.onSurface
                : AppColors.surface),
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: widget.focusedBorderColor ??
            (widget.isDartTheme
                ? AppColors.onSurface
                : AppColors.grey500),
      ),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(color: AppColors.red),
    );

    final field = TextFormField(
      cursorColor: AppColors.primary,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign,
      controller: _controller,
      autovalidateMode: widget.autovalidateMode,
      focusNode: widget.focusNode,
      style: widget.textStyle ??
          (widget.isDartTheme
              ? AppTextStyles.textFieldWhite
              : AppTextStyles.textField),
      textAlignVertical: TextAlignVertical.center,
      obscureText: widget.isPassword && _isObscured,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        prefixIcon: widget.icon != null
            ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 10),
            widget.icon!,
            if (widget.iconIncludeVerticalLine)
              Container(
                margin: const EdgeInsets.only(left: 10, right: 8),
                width: 1.5,
                height: 25,
                color: Colors.grey,
              ),
          ],
        )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _isObscured
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
            color: widget.isDartTheme
                ? AppColors.white
                : AppColors.grey700,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        )
            : null,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            (widget.isDartTheme
                ? AppTextStyles.hintTextFieldWhite
                : AppTextStyles.hintTextField),
        filled: true,
        fillColor: widget.fillColor ??
            (widget.isDartTheme
                ? AppColors.onSurface
                : AppColors.surface),
        enabledBorder: normalBorder,
        focusedBorder: focusedBorder,
        border: normalBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 1.2,
        ),
      ),
    );

    if (widget.label == null) return field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label!,
          style: widget.labelStyle ??
              TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color.onSurface.withValues(alpha: 0.7),
              ),
        ),
        const SizedBox(height: 6),
        field,
      ],
    );
  }
}