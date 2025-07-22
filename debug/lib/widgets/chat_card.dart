// 📁 lib/widgets/chat_card.dart
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final String name;
  final String time;
  final String status; // 'active' or 'inactive'

  const ChatCard({
    super.key,
    required this.name,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.lightBlueAccent.shade100, width: 2),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: status == 'active' ? Colors.green : Colors.red,
                radius: 10,
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(name, textAlign: TextAlign.right),
                subtitle: Text(time, textAlign: TextAlign.right),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(radius: 28, backgroundColor: Color(0xFFEAF5F8)),
            ),
          ],
        ),
      ),
    );
  }
}
