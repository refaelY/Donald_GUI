class Chat {
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime timestamp;

  Chat({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        senderId: json['sender_id'],
        receiverId: json['receiver_id'],
        message: json['message'],
        timestamp: DateTime.parse(json['timestamp']),
      );

  Map<String, dynamic> toJson() => {
        'sender_id': senderId,
        'receiver_id': receiverId,
        'message': message,
        'timestamp': timestamp.toIso8601String(),
      };
}
