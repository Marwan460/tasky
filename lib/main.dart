import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/screens/home_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';

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
        useMaterial3: true,
      ),
      home: name == null ? const WelcomeScreen() : const HomeScreen(),
    );
  }
}
