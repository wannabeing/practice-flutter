import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';
import 'package:may230517/wanda/features/chats/chat_detail_screen.dart';

// 채팅상대 선택하는 화면
class ChatSelectScreen extends StatefulWidget {
  const ChatSelectScreen({super.key});

  // 🌐 RouteName
  static String routeName = "select";

  @override
  State<ChatSelectScreen> createState() => _ChatSelectScreenState();
}

class _ChatSelectScreenState extends State<ChatSelectScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isChecked = false; //test

  // test
  void _onCheck() {
    _isChecked = !_isChecked;

    setState(() {});
  }

  // 🚀 채팅 디테일 페이지로 이동 함수
  void _moveChatDetailScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const ChatDetailScreen(
            chatOppId: "셀렉에서 디테일로",
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(() {});
  }

  @override
  void dispose() {
    _textEditingController.removeListener(() {});
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("대화상대 선택"),
        actions: [
          IconButton(
            onPressed: () => _moveChatDetailScreen(),
            icon: Text(
              "확인",
              style: TextStyle(
                color: _isChecked
                    ? Utils.isDarkMode(context)
                        ? Colors.white // 다크모드(체크시)
                        : Colors.black // 라이트모드(체크시)
                    : Colors.grey.shade600, // 노체크
                fontSize: Sizes.width / 24,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.height / 40,
        ),
        separatorBuilder: (context, index) {
          return Gaps.v10;
        },
        itemCount: 20,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onCheck(),
            child: ListTile(
              leading: CircleAvatar(
                radius: Sizes.width / 15,
                foregroundImage: const NetworkImage(
                    "https://avatars.githubusercontent.com/u/79440384"),
              ),
              title: const Text("닉네임"),
              trailing: Checkbox(
                activeColor: Theme.of(context).primaryColor,
                shape: const CircleBorder(),
                onChanged: (value) {
                  _onCheck();
                },
                value: _isChecked,
              ),
            ),
          );
        },
      ),
    );
  }
}
