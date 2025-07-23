// 📁 lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../constants/colors.dart';
import '../screens/registration_screen.dart';
import '../screens/manager_dashboard_screen.dart';
import '../services/api_service.dart';
import '../services/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  void _login() async {
    if (_isLoading) return;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final username = usernameController.text.trim();
      final password = passwordController.text.trim();
      // כאן יש להחליף ל-loginUser אמיתי
      final success = await ApiService.registerUser(name: username, email: password, age: "20");

      if (!mounted) return;

      if (success) {
        // שמירת פרטי המשתמש הגלובליים
        UserProvider().setUser(UserModel(
          name: username,
          email: password,
          age: '20',
          about: '',
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ManagerDashboardScreen(userName: username),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('שגיאה'),
            content: const Text('התחברות נכשלה. נסה שוב.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('אישור'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('שגיאה'),
          content: Text('אירעה שגיאה: $e'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
                child: Form(
                  key: _formKey,
                  // Removed autovalidateMode so validation only happens on submit
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/backgrounds/back.png',
                        height: 200,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'duck_me',
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
                      SizedBox(
                        height: 80,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.person, color: Colors.blueGrey),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextFormField(
                                  controller: usernameController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'שם משתמש',
                                    hintStyle: TextStyle(color: Colors.blueGrey),
                                    alignLabelWithHint: true,
                                  ),
                                  validator: (val) => val == null || val.trim().isEmpty ? 'נא למלא שם משתמש' : null,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 80,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 7.5),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.lock, color: Colors.blueGrey),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'סיסמה',
                                    hintStyle: TextStyle(color: Colors.blueGrey),
                                    alignLabelWithHint: true,
                                  ),
                                  validator: (val) => val == null || val.trim().isEmpty ? 'נא למלא סיסמה' : null,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        label: _isLoading ? 'טוען...' : 'התחברות',
                        onPressed: _isLoading ? null : _login,
                        color: Color(0xFFF26B3A),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegistrationScreen(),
                          ),
                        ),
                        child: const Text(
                          'לא רשומ/ה? מעבר להרשמה',
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
      ),
    );
  }
}
