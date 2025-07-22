// 📁 lib/widgets/group_card.dart
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final String groupName;
  final VoidCallback onJoin;

  const GroupCard({
    super.key,
    required this.groupName,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            // בעתיד אפשר לשים פה אייקון/תמונה של הקבוצה
            const CircleAvatar(
              radius: 28,
              backgroundColor: Color(0xFFE0F7FA),
              child: Icon(Icons.groups, size: 28, color: Colors.teal),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                groupName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            ElevatedButton(
              onPressed: onJoin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('הצטרף'),
            )
          ],
        ),
      ),
    );
  }
}
