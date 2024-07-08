import 'package:chatapp/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/messages.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.message, super.key});
  final Messages message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(32)),
              color: kPrimaryColor),
          margin: const EdgeInsets.all(20),
          padding:
              const EdgeInsets.only(top: 28, bottom: 28, right: 16, left: 16),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ChatBubbleV2 extends StatelessWidget {
  const ChatBubbleV2({required this.message, super.key});
  final Messages message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32)),
              color: Colors.orange),
          margin: const EdgeInsets.all(20),
          padding:
              const EdgeInsets.only(top: 28, bottom: 28, right: 16, left: 16),
          child: Text(
            message.message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
