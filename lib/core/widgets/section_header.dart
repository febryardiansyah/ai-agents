import 'package:flutter/material.dart';
import 'package:flutter_gemini_ai/core/resources/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "See more",
          style: TextStyle(color: AppColors.grey, fontSize: 10),
        ),
      ],
    );
  }
}
