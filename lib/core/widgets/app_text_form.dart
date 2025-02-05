import 'package:flutter/material.dart';
import 'package:flutter_gemini_ai/core/resources/colors.dart';

class AppTextForm extends StatelessWidget {
  final String? hint;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const AppTextForm({
    super.key,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          // isDense: true,
          filled: true,
          fillColor: AppColors.secondary,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.grey, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
