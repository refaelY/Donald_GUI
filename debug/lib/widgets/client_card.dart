// 📁 lib/widgets/client_card.dart
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String time;
  final String status;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ClientCard({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.time,
    required this.status,
    required this.onDelete,
    required this.onEdit,
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
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: onDelete,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: CircleAvatar(
                backgroundColor: status == 'active' ? Colors.green : Colors.red,
                radius: 10,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(email),
                    Text(phone),
                    Text('זמן תגובה: $time'),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}
