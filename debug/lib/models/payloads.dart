// דגמי Payloads לפי התרשים

class LoginPayload {
  final String email;
  final String password;
  LoginPayload({required this.email, required this.password});
}

class RegisterPayload {
  final String name;
  final String email;
  final String password;
  final int age;
  final int role;
  final String phone;
  final String about;
  RegisterPayload({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.role,
    required this.phone,
    required this.about,
  });
}

class ChatMessagePayload {
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime timestamp;
  ChatMessagePayload({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });
}

class CreateGroupPayload {
  final String name;
  final int managerId;
  final List<int> members;
  CreateGroupPayload({
    required this.name,
    required this.managerId,
    required this.members,
  });
}

class StatusPayload {
  final String status;
  StatusPayload({required this.status});
}

class EditUserPayload {
  final int userId;
  final String name;
  final String email;
  final int age;
  final String phone;
  final String about;
  EditUserPayload({
    required this.userId,
    required this.name,
    required this.email,
    required this.age,
    required this.phone,
    required this.about,
  });
}

class IconUpdatePayload {
  final int userId;
  final String iconUrl;
  IconUpdatePayload({required this.userId, required this.iconUrl});
}

class GroupPayload {
  final String name;
  final int createdBy;
  final List<int> members;
  GroupPayload({required this.name, required this.createdBy, required this.members});
}

class EchoPayload {
  final String message;
  EchoPayload({required this.message});
}

class MessagePayload {
  final String text;
  final String language;
  final bool urgent;
  MessagePayload({required this.text, required this.language, required this.urgent});
}

class UserSearchPayload {
  final String name;
  final int minAge;
  final int maxAge;
  UserSearchPayload({required this.name, required this.minAge, required this.maxAge});
}
