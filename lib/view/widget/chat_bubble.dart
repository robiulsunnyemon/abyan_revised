import 'package:abyansf_asfmanagment_app/utils/style/appColor.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4),
          constraints: const BoxConstraints(maxWidth: 250),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primaryColor: Colors.grey.shade500,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: isMe
                  ? const Radius.circular(16)
                  : const Radius.circular(0),
              bottomRight: isMe
                  ? const Radius.circular(0)
                  : const Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          )
          ,
        ),
      ],
    );
  }
}
