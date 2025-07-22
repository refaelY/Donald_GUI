// 📁 lib/widgets/clients_view.dart
import 'package:flutter/material.dart';
import 'client_card.dart';
import '../services/api_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ClientsView extends StatelessWidget {
  final String userName;
  const ClientsView({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<http.Response>(
      future: ApiService.listUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('שגיאה בטעינת לקוחות'));
        }
        final response = snapshot.data;
        if (response == null || response.statusCode != 200) {
          return Center(child: Text('לא נמצאו לקוחות'));
        }
        final List users = (jsonDecode(response.body) as List);
        if (users.isEmpty) {
          return Center(child: Text('אין לקוחות להצגה'));
        }
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final client = users[index];
            return ClientCard(
              name: client['name'] ?? '',
              email: client['email'] ?? '',
              phone: client['phone'] ?? '',
              time: '',
              status: 'active',
              onDelete: () {},
              onEdit: () {},
            );
          },
        );
      },
    );
  }
}
