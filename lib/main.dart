import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/utils/app_style.dart';
import 'package:tasky/screens/main_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

import 'core/utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  String? name = pref.getString('name');
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: AppColors.primary,
          titleTextStyle: AppStyle.regular20,
          centerTitle: false,
          iconTheme: const IconThemeData(color: AppColors.white2),
        ),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStateProperty.resolveWith((states) {
            if(states.contains(WidgetState.selected)){
              return AppColors.green;
            }else{
              return AppColors.white;
            }
          },),
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if(states.contains(WidgetState.selected)){
              return AppColors.white;
            }else{
              return AppColors.grey;
            }
          },),
        ),
        useMaterial3: true,
      ),
      home: name == null ? const WelcomeScreen() : const MainScreen(),
    );
  }
}
