import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.primaryDark,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.primaryDark,
    selectedItemColor: AppColors.green,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: AppColors.grey2,
  ),
  colorScheme: const ColorScheme.dark(
    primaryContainer: AppColors.secondaryDark,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: AppColors.primaryDark,
    titleTextStyle: TextStyle(
      color: AppColors.white2,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    centerTitle: false,
    iconTheme: IconThemeData(color: AppColors.white2),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green;
        } else {
          return AppColors.white;
        }
      },
    ),
    thumbColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.white;
        } else {
          return AppColors.grey;
        }
      },
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
    backgroundColor: WidgetStateProperty.all(AppColors.green),
    foregroundColor: WidgetStateProperty.all(AppColors.white2),
    iconColor: WidgetStateProperty.all(AppColors.white2),
  )),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: AppColors.white,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: AppColors.white2,
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: AppColors.grey2,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      color: AppColors.white2,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: AppColors.white2,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: AppColors.white2,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    // For Done Task
    titleMedium: TextStyle(
      color: Color(0xffA0A0A0),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: AppColors.grey2,
      decorationThickness: 1.5,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(
      color: AppColors.grey,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    fillColor: const Color(0xff282828),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
  ),
  checkboxTheme: CheckboxThemeData(
    side: const BorderSide(
      color: Color(0xff6E6E6E),
      width: 2,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.grey2,
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xff6E6E6E),
  ),
  focusColor: AppColors.white2,
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.primaryDark,
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(
        color: AppColors.white2,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.green),
    ),
    elevation: 2,
  ),
);
