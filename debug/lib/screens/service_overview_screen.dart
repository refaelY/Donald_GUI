// 📁 lib/screens/service_overview_screen.dart
import 'package:flutter/material.dart';

class ServiceOverviewScreen extends StatelessWidget {
  const ServiceOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('סקירה כללית')),        
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ברוך הבא לשירות!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'כאן תוכל לראות מידע כללי על הקבוצה אליה הצטרפת, סטטיסטיקות, וקישור ישיר לבעל המקצוע.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              _infoBox(title: 'כמות משתמשים', value: '134'),
              const SizedBox(height: 16),
              _infoBox(title: 'ממוצע שביעות רצון', value: '4.7/5'),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/provider_profile');
                },
                icon: const Icon(Icons.person),
                label: const Text('צפייה בפרופיל נותן השירות'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(14)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoBox({required String title, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
