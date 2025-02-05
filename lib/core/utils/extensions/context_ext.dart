import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
}