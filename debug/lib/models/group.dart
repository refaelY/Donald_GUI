import '../services/user_provider.dart';
import 'chat.dart';

class Group {
  final String name;
  final int managerId;
  final List<UserModel> members;
  final List<Chat> messages;

  Group({
    required this.name,
    required this.managerId,
    required this.members,
    required this.messages,
  });

  void sendMessage(String message) {
    // כאן יש להוסיף קריאה לשרת לשליחת הודעה לקבוצה
    // TODO: מימוש שליחת הודעה לשרת
  }
}
