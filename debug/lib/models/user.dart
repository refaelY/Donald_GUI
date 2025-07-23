class User {
  final int id;
  final String name;
  final String email;
  final String details;
  final String icon;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.details,
    required this.icon,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        details: json['details'] ?? '',
        icon: json['icon'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'details': details,
        'icon': icon,
      };
}
