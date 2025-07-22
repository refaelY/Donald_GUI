// 📁 lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../constants/colors.dart';
import '../screens/registration_screen.dart';
import '../screens/manager_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ManagerScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFFF26B3A),
                Color(0xFF3CA4DC),
              ],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/backgrounds/back.png',
                      height: 200,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Duck Me',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'תמיד כאן, תמיד איתך.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      hintText: 'שם משתמש',
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      hintText: 'סיסמה',
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      label: 'התחברות',
                      onPressed: _login,
                      color: Color(0xFFF26B3A),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationScreen(),
                        ),
                      ),
                      child: const Text(
                        'לא רשום ה? מעבר להרשמה',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}