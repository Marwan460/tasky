import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.primaryLight,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.primaryLight,
    selectedItemColor: AppColors.green,
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: AppColors.black2,
  ),
  colorScheme: const ColorScheme.light(
    primaryContainer: AppColors.white,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    color: AppColors.primaryLight,
    titleTextStyle: TextStyle(
      color: AppColors.black,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    centerTitle: false,
    iconTheme: IconThemeData(color: AppColors.black),
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
      foregroundColor: WidgetStateProperty.all(AppColors.white),
      iconColor: WidgetStateProperty.all(AppColors.white),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: AppColors.black,
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      color: AppColors.black,
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      color: AppColors.black2,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      color: AppColors.black,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: AppColors.black,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: AppColors.black,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    // For Done Task
    titleMedium: TextStyle(
      color: Color(0xff6A6A6A),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xff49454F),
      decorationThickness: 1.5,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.black,
    selectionColor: AppColors.grey2,
    selectionHandleColor: AppColors.black,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(
      color: AppColors.secondaryLight,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    fillColor: AppColors.white,
    border: buildOutlineInputBorder(),
    enabledBorder: buildOutlineInputBorder(),
    focusedBorder: buildOutlineInputBorder(),
  ),
  checkboxTheme: CheckboxThemeData(
    side: const BorderSide(
      color: Color(0xffD1DAD6),
      width: 2,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.black2,
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xffCAC4D0),
  ),
  focusColor: AppColors.black,
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: AppColors.primaryLight,
    labelTextStyle: WidgetStateProperty.all(
      const TextStyle(
        color: AppColors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),

);





OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(
      color: Color(0xffD1DAD6),
    ),
  );
}
