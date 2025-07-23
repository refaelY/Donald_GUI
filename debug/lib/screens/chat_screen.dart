import 'package:flutter/material.dart';
import '../models/chat.dart';

class ChatScreen extends StatefulWidget {
  final String currentUser;
  final String otherUser;
  const ChatScreen({super.key, required this.currentUser, required this.otherUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Chat> _messages = [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(Chat(
        senderId: widget.currentUser.hashCode,
        receiverId: widget.otherUser.hashCode,
        message: text,
        timestamp: DateTime.now(),
      ));
      _controller.clear();
    });
    // TODO: שליחת הודעה לשרת
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                widget.otherUser,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFFF26B3A), Color(0xFF3CA4DC)],
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFFF26B3A), Color(0xFF3CA4DC)],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[_messages.length - 1 - index];
                        final isMe = msg.senderId == widget.currentUser.hashCode;
                        return Row(
                          mainAxisAlignment:
                              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (!isMe)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18, right: 4, left: 4),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: const Color(0xFFE3F3F9),
                                  child: Text(
                                    'ש', // ראשי תיבות או אייקון
                                    style: const TextStyle(color: Color(0xFF3CA4DC), fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            CustomChatBubble(
                              message: msg.message,
                              isMe: isMe,
                              sender: isMe ? 'אני' : 'שם',
                              time: _formatTime(msg.timestamp),
                            ),
                            if (isMe)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18, right: 4, left: 4),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: const Color(0xFFE3F3F9),
                                  child: Text(
                                    'א', // ראשי תיבות או אייקון
                                    style: const TextStyle(color: Color(0xFFF26B3A), fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white.withOpacity(0.97),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline, size: 32, color: Color(0xFF3CA4DC)),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'הקלד הודעה...',
                              border: InputBorder.none,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.mic, size: 28, color: Color(0xFF3CA4DC)),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.send, color: Color(0xFFF26B3A)),
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

class CustomChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String sender;
  final String time;
  const CustomChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.sender,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 8,
            bottom: 8,
            right: isMe ? 0 : 12,
            left: isMe ? 12 : 0,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: isMe ? const Color(0xFFF26B3A) : Colors.white,
            border: Border.all(color: const Color(0xFFBEE3F8), width: 2),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(0),
              bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(18),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sender,
                    style: TextStyle(
                      color: isMe ? Colors.white : const Color(0xFF3CA4DC),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: isMe ? Colors.white70 : Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        // Tail
        Positioned(
          bottom: 0,
          right: isMe ? null : 0,
          left: isMe ? 0 : null,
          child: CustomPaint(
            painter: BubbleTailPainter(isMe: isMe),
            size: const Size(18, 18),
          ),
        ),
      ],
    );
  }
}

class BubbleTailPainter extends CustomPainter {
  final bool isMe;
  BubbleTailPainter({required this.isMe});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isMe ? const Color(0xFFF26B3A) : Colors.white
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = const Color(0xFFBEE3F8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path();
    if (isMe) {
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height / 2);
      path.lineTo(size.width, size.height);
      path.close();
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, size.height / 2);
      path.lineTo(0, size.height);
      path.close();
    }
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
