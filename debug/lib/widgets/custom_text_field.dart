import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final int maxLines;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final Widget? prefixIcon;

  const CustomTextField({
    super.key,
    this.isPassword = false,
    this.maxLines = 1,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.enabled = true,
    this.prefixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword && _obscure,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.errorText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.border, width: 2),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}
