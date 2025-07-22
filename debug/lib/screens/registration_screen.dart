import 'package:debug/screens/manager_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../services/api_service.dart';
import '../services/user_provider.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final aboutController = TextEditingController();

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  Widget buildTextField({
    required IconData icon,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      height: maxLines > 1 ? 110 : 80,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 14),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueGrey),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: controller,
                maxLines: maxLines,
                keyboardType: keyboardType,
                validator: validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.blueGrey),
                  alignLabelWithHint: true,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final phone = phoneController.text.trim();
      final about = aboutController.text.trim();

      final response = await ApiService.registerUser(
        name: name,
        email: email,
        age: "24", // גיל קבוע
      );

      if (!mounted) return;

      if (response) {
        // שמירת פרטי המשתמש הגלובליים
        UserProvider().setUser(UserModel(
          name: name,
          email: email,
          age: '24',
          about: about,
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => ManagerScreen(userName: name)),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text('שגיאה'),
            content: Text('ההרשמה נכשלה. נסה שוב.'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
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
              colors: [Color(0xFFF26B3A), Color(0xFF3CA4DC)],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Image.asset('assets/images/backgrounds/back.png', height: 180),
                      const SizedBox(height: 16),
                      const Text(
                        'duck_me',
                        style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'הצטרף אלינו - מר מאן שבילך!',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 24),

                      buildTextField(
                        icon: Icons.person,
                        hint: 'שם מלא',
                        controller: nameController,
                        validator: (val) => val == null || val.trim().isEmpty ? 'נא למלא שם מלא' : null,
                      ),
                      buildTextField(
                        icon: Icons.email,
                        hint: 'מייל',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) return 'נא למלא מייל';
                          if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+').hasMatch(val.trim())) return 'מייל לא תקין';
                          return null;
                        },
                      ),
                      buildTextField(
                        icon: Icons.lock,
                        hint: 'מספר פלאפון',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) return 'נא למלא מספר פלאפון';
                          if (val.trim().length < 8) return 'מספר פלאפון קצר מדי';
                          return null;
                        },
                      ),
                      buildTextField(
                        icon: Icons.message,
                        hint: 'קצת עליי',
                        controller: aboutController,
                        maxLines: 3,
                        validator: (val) => val == null || val.trim().isEmpty ? 'נא למלא קצת עליך' : null,
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF26B3A),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: _isLoading ? null : _register,
                          child: _isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : const Text('להרשמה', style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        ),
                        child: const Text(
                          'כבר רשום? התחבר כאן',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
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
