// 📁 lib/widgets/profile_view.dart
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(radius: 60, backgroundColor: Color(0xFFEAF5F8)),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlueAccent.shade100, width: 2),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("עורך דין שמואל מוצפי", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text("אני עוסק במקצוע מזה 15 שנים\nעם לקוחות מרוצים וכו וכו וכו", textAlign: TextAlign.right),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _infoButton("מייל"),
          _infoButton("פלאפון"),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _infoButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.lightBlueAccent.shade100, width: 2),
          color: Colors.white,
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      ),
    );
  }
}
