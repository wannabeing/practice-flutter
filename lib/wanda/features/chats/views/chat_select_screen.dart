import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/models/user_model.dart';
import 'package:may230517/wanda/features/chats/views/chat_detail_screen.dart';
import 'package:may230517/wanda/features/chats/vms/chat_list_vm.dart';
import 'package:may230517/wanda/features/settings/vms/setting_config_vm.dart';

// 채팅상대 선택하는 화면
class ChatSelectScreen extends ConsumerStatefulWidget {
  const ChatSelectScreen({super.key});

  // 🌐 RouteName
  static String routeName = "select";

  @override
  ConsumerState<ChatSelectScreen> createState() => _ChatSelectScreenState();
}

class _ChatSelectScreenState extends ConsumerState<ChatSelectScreen> {
  int _isCheckedIndex = -1; // 대화상대 인덱스 번호
  List<UserModel> _users = []; // 대화상대 리스트

  // 🚀 인덱스 체크 함수
  void _onCheck(int index) {
    _isCheckedIndex = index;
    setState(() {});
  }

  // 🚀 채팅 디테일 페이지로 이동 함수
  void _moveChatDetailScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return ChatDetailScreen(
            chatOpp: _users[_isCheckedIndex],
          );
        },
      ),
    );
  }

  // 🚀 대화상대 리스트 가져오기 함수
  Future<void> _initUserListUp() async {
    _users = await ref.read(chatListProvider.notifier).getUserList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initUserListUp(); // 대화상대 리스트 가져오기
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("대화상대 선택"),
        actions: [
          IconButton(
            onPressed: () =>
                _isCheckedIndex != -1 ? _moveChatDetailScreen() : null,
            icon: Text(
              "확인",
              style: TextStyle(
                color: _isCheckedIndex != -1
                    ? ref.watch(settingConfigProvider).darkTheme
                        ? Colors.white // 다크모드(체크시)
                        : Colors.black // 라이트모드(체크시)
                    : Colors.grey.shade600, // 노체크
                fontSize: Sizes.width / 24,
              ),
            ),
          ),
        ],
      ),
      body: _users.isNotEmpty
          ? ListView.separated(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.height / 40,
              ),
              separatorBuilder: (context, index) {
                return Gaps.v10;
              },
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _onCheck(index),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: Sizes.width / 15,
                      foregroundImage: NetworkImage(_users[index].avatarURL),
                      backgroundImage:
                          const AssetImage("assets/images/avatar.png"),
                    ),
                    title: Text(_users[index].displayName),
                    trailing: Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      shape: const CircleBorder(),
                      onChanged: (value) {
                        _onCheck(index);
                      },
                      value: _isCheckedIndex == index,
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
