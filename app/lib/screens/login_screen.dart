import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../constants/colors.dart';
import '../screens/registration_screen.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality( 
      textDirection: TextDirection.rtl, // תמיכה בכיוון ימין לשמאל
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'שם האפליקציה',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/backgrounds/back.png',
                    height: 200,
                  ),
                  const SizedBox(height: 32),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'מספר פלאפון',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const CustomTextField(),
                  const SizedBox(height: 16),
                  const CustomButton(label: 'אימות'),
                  const SizedBox(height: 32),
                  CustomButton(
                    label: 'להרשמה',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
