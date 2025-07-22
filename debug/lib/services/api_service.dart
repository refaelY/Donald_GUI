import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://207.154.202.226:5007/api/v1';

  // Check server status
  static Future<bool> pingServer() async {
    final res = await http.get(Uri.parse('$_baseUrl/status'));
    return res.statusCode == 200;
  }

  // Echo message back
  static Future<http.Response> echoMessage(String message) async {
    return await http.post(
      Uri.parse('$_baseUrl/echo'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': message}),
    );
  }

  // Create user
  static Future<bool> registerUser({
    required String name,
    required String email,
    required String age,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'age': int.tryParse(age) ?? 24,
      }),
    );
    return response.statusCode == 201;
  }

  // Get all users
  static Future<http.Response> listUsers() async {
    return await http.get(Uri.parse('$_baseUrl/users/'));
  }

  // Get user by ID
  static Future<http.Response> getUser(int id) async {
    return await http.get(Uri.parse('$_baseUrl/users/$id'));
  }

  // Delete user by ID
  static Future<http.Response> deleteUser(int id) async {
    return await http.delete(Uri.parse('$_baseUrl/users/$id'));
  }

  // Send message
  static Future<http.Response> sendMessage({
    required String text,
    String language = 'he',
    bool urgent = false,
  }) async {
    return await http.post(
      Uri.parse('$_baseUrl/demo/message'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'text': text,
        'language': language,
        'urgent': urgent,
      }),
    );
  }

  // Calculator operation
  static Future<http.Response> calculate({
    required double a,
    required double b,
    required String operation,
  }) async {
    return await http.post(
      Uri.parse('$_baseUrl/demo/calculator'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'a': a,
        'b': b,
        'operation': operation,
      }),
    );
  }

  // Get random data
  static Future<http.Response> getRandomData({
    String type = 'mixed',
    int count = 3,
  }) async {
    final uri = Uri.parse('$_baseUrl/demo/random?type=$type&count=$count');
    return await http.get(uri);
  }

  // Search users
  static Future<http.Response> searchUsers({
    String? name,
    int? minAge,
    int? maxAge,
  }) async {
    final payload = <String, dynamic>{};
    if (name != null) payload['name'] = name;
    if (minAge != null) payload['min_age'] = minAge;
    if (maxAge != null) payload['max_age'] = maxAge;

    return await http.post(
      Uri.parse('$_baseUrl/demo/search'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
  }
}