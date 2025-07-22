// 📁 lib/screens/entry_screen.dart
import 'package:flutter/material.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('הרשמה לשירות')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _buildField(label: 'שם מלא', controller: _nameController),
              const SizedBox(height: 16),
              _buildField(label: 'מספר טלפון', controller: _phoneController, keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              _buildField(label: 'אימייל', controller: _emailController, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // בעתיד: בדיקה וניווט למסך תשלום
                  Navigator.pushNamed(context, '/payment');
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(14)),
                child: const Text('המשך לתשלום'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
} 
