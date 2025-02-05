import 'package:flutter/material.dart';

class AppSpacer extends StatelessWidget {
  final double width;
  final double height;

  const AppSpacer.width(this.width, {super.key})
      : height = 0;

  const AppSpacer.height(this.height, {super.key})
      : width = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}