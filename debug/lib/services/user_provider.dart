import 'package:flutter/foundation.dart';

class UserModel {
  String name;
  String email;
  String age;
  String about;

  UserModel({
    required this.name,
    required this.email,
    required this.age,
    required this.about,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        age: json['age']?.toString() ?? '',
        about: json['about'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'age': age,
        'about': about,
      };
}

class UserProvider extends ChangeNotifier {
  static final UserProvider _instance = UserProvider._internal();
  factory UserProvider() => _instance;
  UserProvider._internal();

  UserModel? _user;
  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void updateField({String? name, String? email, String? age, String? about}) {
    if (_user == null) return;
    if (name != null) _user!.name = name;
    if (email != null) _user!.email = email;
    if (age != null) _user!.age = age;
    if (about != null) _user!.about = about;
    notifyListeners();
  }
}
