import 'package:flutter/material.dart';
import 'package:flutter_gemini_ai/core/resources/colors.dart';

enum AppButtonType { normal, outlined }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final Widget? body;
  final AppButtonType type;

  const AppButton({
    super.key,
    this.text = 'button',
    this.onPressed,
    this.width,
    this.body,
    this.type = AppButtonType.normal,
  });

  @override
  Widget build(BuildContext context) {
    final isOutlined = type == AppButtonType.outlined;
    final currentBackgroundColor =
        isOutlined ? Colors.white : AppColors.secondary;
    final isDarkBackground =
        ThemeData.estimateBrightnessForColor(currentBackgroundColor) ==
            Brightness.dark;

    return SizedBox(
      height: 48,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: currentBackgroundColor,
          elevation: isOutlined ? 0 : 2,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isOutlined
                ? const BorderSide(color: AppColors.stroke)
                : BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: body ??
            Text(
              text,
              style: TextStyle(
                color: isDarkBackground ? AppColors.white : AppColors.black,
              ),
            ),
      ),
    );
  }
}
