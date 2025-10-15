import 'package:flutter/material.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/screens/main_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

import 'core/services/preferences_manager.dart';
import 'core/theme/light_theme.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();

  ThemeController().init();

  String? name = PreferencesManager().getString('name');

  runApp(
    MyApp(
      name: name,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? name;

  const MyApp({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: value,
          home: name == null ? const WelcomeScreen() : const MainScreen(),
        );
      },
    );
  }
}
