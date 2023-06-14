import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class ChatListWidget extends StatelessWidget {
  final String nickname;
  final String lastChat;
  final String lastChatTime;
  final int index; // key역할을 하는 index
  final Function onTap; // 🚀 누르면 실행되는 함수
  final Function(int) onLongPress; // 🚀 꾹 누르면 실행되는 함수

  const ChatListWidget({
    super.key,
    required this.nickname,
    required this.lastChat,
    required this.lastChatTime,
    required this.index,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(), // 누르면 실행되는 함수
      onLongPress: () => onLongPress(index), // 꾹 누르면 실행되는 함수
      leading: CircleAvatar(
        radius: Sizes.width / 15,
        foregroundImage: const NetworkImage(
            "https://avatars.githubusercontent.com/u/79440384"),
      ),
      title: Text(nickname),
      subtitle: Text(lastChat),
      trailing: Text(
        lastChatTime,
        style: TextStyle(color: Colors.grey.shade700),
      ),
    );
  }
}
