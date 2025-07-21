import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../constants/colors.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    'שם האפליקציה',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/backgrounds/back.png',
                    height: 180,
                  ),
                  const SizedBox(height: 24),

                  // שם מלא
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text('שם מלא', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  const CustomTextField(),

                  const SizedBox(height: 16),

                  // מייל
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text('מייל', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  const CustomTextField(),

                  const SizedBox(height: 16),

                  // פלאפון + אימות
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text('מספר פלאפון', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Expanded(
                        flex: 2,
                        child: CustomTextField(),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: CustomButton(label: 'אימות'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // קצת עליי
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text('קצת עליי', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  const CustomTextField(maxLines: 3),

                  const SizedBox(height: 32),

                  // כפתור הרשמה
                  const CustomButton(label: 'להרשמה'),

                  const SizedBox(height: 24),

                  // קישור למסך התחברות
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'כבר רשום? התחבר כאן',
                      style: TextStyle(
                        color: Colors.teal,
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
    );
  }
}
