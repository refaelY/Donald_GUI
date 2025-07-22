// 📁 lib/widgets/clients_view.dart
import 'package:flutter/material.dart';
import 'client_card.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    final clients = [
      {
        "name": "אורי כהן",
        "email": "uri@example.com",
        "phone": "050-1234567",
        "time": "5 דקות",
        "status": "active"
      },
      {
        "name": "שירה לוי",
        "email": "shira@example.com",
        "phone": "052-7654321",
        "time": "12 דקות",
        "status": "inactive"
      },
    ];

    return ListView.builder(
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return ClientCard(
          name: client['name']!,
          email: client['email']!,
          phone: client['phone']!,
          time: client['time']!,
          status: client['status']!,
          onDelete: () {},
          onEdit: () {},
        );
      },
    );
  }
}
