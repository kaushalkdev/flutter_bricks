import 'package:flutter/material.dart';

class AppThemeUtl {
  static final AppThemeUtl i = AppThemeUtl._();
  AppThemeUtl._() {
    _currentTheme = ValueNotifier(_lightTheme);
  }
  late ValueNotifier<ThemeData> _currentTheme;
  ValueNotifier<ThemeData> get currentTheme => _currentTheme;

  final ThemeData _lightTheme = ThemeData.light(
    useMaterial3: true,
  );
  final ThemeData _darkTheme = ThemeData.dark(
    useMaterial3: true,
  );

  void setTheme([bool isDark = false]) {
    if (isDark) {
      _currentTheme.value = _darkTheme;
    } else {
      _currentTheme.value = _lightTheme;
    }
  }
}
