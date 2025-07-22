// 📁 lib/widgets/chats_view.dart
import 'package:flutter/material.dart';
import 'chat_card.dart';

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {"name": "דוד לוי", "time": "13:42", "status": "active"},
      {"name": "רות ברק", "time": "12:10", "status": "inactive"},
    ];

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatCard(
          name: chat['name']!,
          time: chat['time']!,
          status: chat['status']!,
        );
      },
    );
  }
}
