import 'package:flutter/material.dart';

class AppColors {
  static const blue = Color(0xFF1D5BFF);
  static const blueDark = Color(0xFF0B3BB8);
  static const blueSoft = Color(0xFFE8F0FF);
  static const yellow = Color(0xFFFFC21A);
  static const yellowSoft = Color(0xFFFFF4D1);
  static const green = Color(0xFF1FA463);
  static const greenSoft = Color(0xFFE3F6EC);
  static const white = Colors.white;
  static const background = Color(0xFFF5F8FF);
  static const ink = Color(0xFF14213D);
  static const muted = Color(0xFF6B7A99);
  static const border = Color(0xFFD9E3F7);
}

ThemeData buildAppTheme() {
  const scheme = ColorScheme.light(
    primary: AppColors.blue,
    onPrimary: AppColors.white,
    secondary: AppColors.green,
    onSecondary: AppColors.white,
    tertiary: AppColors.yellow,
    onTertiary: AppColors.ink,
    surface: AppColors.white,
    onSurface: AppColors.ink,
    error: Color(0xFFD64545),
  );

  final text = Typography.material2021(platform: TargetPlatform.android)
      .black
      .apply(bodyColor: AppColors.ink, displayColor: AppColors.ink);

  OutlineInputBorder border(Color c, [double w = 1.2]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: c, width: w),
      );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: text.copyWith(
      titleLarge: text.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      titleMedium: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
      labelLarge: text.labelLarge?.copyWith(fontWeight: FontWeight.w700),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blue,
      foregroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      labelStyle: const TextStyle(color: AppColors.muted),
      floatingLabelStyle: const TextStyle(
        color: AppColors.blue,
        fontWeight: FontWeight.w600,
      ),
      prefixStyle: const TextStyle(
        color: AppColors.ink,
        fontWeight: FontWeight.w600,
      ),
      border: border(AppColors.border),
      enabledBorder: border(AppColors.border),
      focusedBorder: border(AppColors.blue, 2),
      errorBorder: border(scheme.error),
      focusedErrorBorder: border(scheme.error, 2),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(0, 52),
        foregroundColor: AppColors.blue,
        side: const BorderSide(color: AppColors.blue, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.blueSoft
              : AppColors.white,
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? AppColors.blue
              : AppColors.muted,
        ),
        side: const WidgetStatePropertyAll(
          BorderSide(color: AppColors.border, width: 1.2),
        ),
      ),
    ),
  );
}
