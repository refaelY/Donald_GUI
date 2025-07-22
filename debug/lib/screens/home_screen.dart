// 📁 lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/group_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality( // תמיכה מלאה לעברית
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: const Text('', style: TextStyle(color: Colors.black)), // שם האפליקציה - נשאר ריק כרגע
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                // בעתיד: פתיחת תפריט צד של המשתמש
              },
            )
          ],
        ),
        backgroundColor: const Color(0xFFFDF6E3),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                'בחר את קבוצת השירות המתאימה לך:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GroupCard(
                    groupName: 'קבוצת שירות ${index + 1}',
                    onJoin: () {
                      // ניווט לדף הרשמה עם תשלום
                      Navigator.pushNamed(context, '/register');
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[800],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text('פתח קבוצה חדשה'),
                onPressed: () {
                  // ניווט לעמוד יצירת קבוצה חדשה (הופך למנהל)
                  Navigator.pushNamed(context, '/create_group');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
