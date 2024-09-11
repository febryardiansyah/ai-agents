import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/scheduler.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);

  void getTheme() {
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    emit(isDarkMode);
  }
}
