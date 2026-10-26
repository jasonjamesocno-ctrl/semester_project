
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const LCOApp());
}

class LCOApp extends StatelessWidget {
  const LCOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LCO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7F9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF119E94),
          primary: const Color(0xFF119E94),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF193F58),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
