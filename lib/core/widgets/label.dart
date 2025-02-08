import 'package:flutter/material.dart';
import 'package:aspectumai/core/resources/colors.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  
  const LabelWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
