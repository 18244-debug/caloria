import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const CaloriaApp());
}

class CaloriaApp extends StatelessWidget {
  const CaloriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalorIA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B3B36),
          primary: const Color(0xFF1B3B36),
          secondary: const Color(0xFFE67E22),
        ),
      ),
      home: const ProfileScreen(isInitialSetup: true),
    );
  }
}