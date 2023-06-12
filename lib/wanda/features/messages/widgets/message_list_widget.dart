import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class MessageListWidget extends StatelessWidget {
  final String nickname;
  final String lastChat;
  final String lastChatTime;
  const MessageListWidget({
    super.key,
    required this.nickname,
    required this.lastChat,
    required this.lastChatTime,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        radius: Sizes.width / 15,
        foregroundImage: const NetworkImage(
            "https://avatars.githubusercontent.com/u/79440384"),
      ),
      title: Text(nickname),
      subtitle: Text(lastChat),
      trailing: Text(lastChatTime),
    );
  }
}
