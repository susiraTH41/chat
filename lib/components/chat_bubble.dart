import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final Color colorBox;
  final String message;
  const ChatBubble({
    super.key ,
    required this.message, required this.colorBox
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorBox,
        
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}