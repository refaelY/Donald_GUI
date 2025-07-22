// 📁 lib/widgets/clients_view.dart
import 'package:flutter/material.dart';
import 'client_card.dart';
import '../services/api_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ClientsView extends StatefulWidget {
  final String userName;
  const ClientsView({super.key, required this.userName});

  @override
  State<ClientsView> createState() => _ClientsViewState();
}

class _ClientsViewState extends State<ClientsView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Map<String, dynamic>> _users = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await ApiService.listUsers();
      if (response.statusCode == 200) {
        final List users = (jsonDecode(response.body) as List);
        setState(() {
          _users = users.cast<Map<String, dynamic>>()
              .where((u) => (u['name'] ?? '').toString().trim() != widget.userName.trim())
              .toList();
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'לא נמצאו לקוחות';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'שגיאה בטעינת לקוחות';
        _loading = false;
      });
    }
  }

  void _removeUser(int index) {
    final removed = _users.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        axisAlignment: 0.0,
        child: ClientCard(
          name: removed['name'] ?? '',
          email: removed['email'] ?? '',
          phone: removed['phone'] ?? '',
          time: '',
          status: 'active',
          onDelete: () {},
          onEdit: () {},
        ),
      ),
      duration: const Duration(milliseconds: 400),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!));
    }
    if (_users.isEmpty) {
      return const Center(child: Text('אין לקוחות להצגה'));
    }
    return AnimatedList(
      key: _listKey,
      initialItemCount: _users.length,
      itemBuilder: (context, index, animation) {
        final client = _users[index];
        return SizeTransition(
          sizeFactor: animation,
          axisAlignment: 0.0,
          child: ClientCard(
            name: client['name'] ?? '',
            email: client['email'] ?? '',
            phone: client['phone'] ?? '',
            time: '',
            status: 'active',
            onDelete: () async {
              final id = client['id'];
              if (id != null) {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('אישור מחיקה'),
                    content: Text('האם למחוק את המשתמש "${client['name'] ?? ''}"?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('ביטול'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('מחק'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await ApiService.deleteUser(id);
                  _removeUser(index);
                }
              }
            },
            onEdit: () {},
          ),
        );
      },
    );
  }
}
