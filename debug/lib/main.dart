import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'אפליקציה',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
      theme: ThemeData(fontFamily: 'Arial'),
    );
  }
}
