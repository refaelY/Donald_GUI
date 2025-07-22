// 📁 lib/screens/payment_screen.dart
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('תשלום עבור ההצטרפות')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'על מנת להצטרף לקבוצה, יש להשלים את התשלום עבור השירות.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    Text('סה"כ לתשלום:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('₪99.00', style: TextStyle(fontSize: 24, color: Colors.teal)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // בעתיד: קישור לסליקה או אינטגרציה עם שירות תשלום
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('תשלום בוצע'),
                      content: const Text('התשלום התקבל בהצלחה. בהצלחה בשירות!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                          child: const Text('סיום'),
                        )
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('בצע תשלום'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
