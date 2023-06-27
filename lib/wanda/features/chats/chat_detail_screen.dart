import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/settings/vms/setting_config_vm.dart';
import 'package:may230517/wanda/features/videos/views/widgets/comments/comment_input_widget.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  const ChatDetailScreen({
    super.key,
    required this.chatOppId,
  });

  // 🌐 RouteName
  static String routeName = ":id";

  final String chatOppId;

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  // 🚀 메시지 제출 함수
  void _onSubmit() {
    _onCloseKeyboard(); // 키보드창 닫기 함수
  }

  // 🚀 키보드창 닫기 함수
  void _onCloseKeyboard() {
    // 키보드 언포커싱 & 키보드 활성화 여부 변경
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("선택한 닉네임"),
        actions: [
          IconButton(
            onPressed: () {}, // 채팅창 나가기
            icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
          ),
        ],
        elevation: 1,
      ),
      body: GestureDetector(
        onTap: () => _onCloseKeyboard(),
        child: Column(
          children: [
            // ✅ 1. 대화창
            Expanded(
              child: Scrollbar(
                child: ListView.separated(
                  // ✅ 대화 구분 공백
                  separatorBuilder: (context, index) {
                    return Gaps.v10;
                  },
                  padding: EdgeInsets.only(
                    right: Sizes.width / 20,
                    left: Sizes.width / 20,
                    top: Sizes.height / 40,
                    bottom: Sizes.height / 40,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    // ✅ 대화 위젯
                    final isMyMsg = index % 2 == 0;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: isMyMsg
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(maxWidth: Sizes.width),
                          padding: EdgeInsets.all(Sizes.width / 22),
                          decoration: BoxDecoration(
                            color: isMyMsg
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade600,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(24),
                              topRight: const Radius.circular(24),
                              bottomLeft: Radius.circular(isMyMsg ? 24 : 4),
                              bottomRight: Radius.circular(!isMyMsg ? 24 : 4),
                            ),
                          ),
                          child: SizedBox(
                            width: Sizes.width / 1.5,
                            child: Text(
                              "가나다라가나다라가나다라가나다라가나다가나다라가나다라가나다라가나다라가나다라가나다라가나다라가나다라가나다라라가나다라가나다라가나다라가나다라",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.width / 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            // ✅ 2. 하단고정 채팅입력창
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    height: Sizes.height / 10, // 전체적인 높이
                    padding: EdgeInsets.only(
                      left: Sizes.width / 20,
                      right: Sizes.width / 20,
                      top: Sizes.height / 50,
                      bottom: Sizes.height / 40,
                    ),
                    decoration: BoxDecoration(
                      color: ref.watch(settingConfigProvider).darkTheme
                          ? Colors.black
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(2, 0), // 그림자의 위치 (수평, 수직)
                        ),
                      ],
                    ),
                    child:
                        // ✅ 대화 인풋 위젯
                        CommentInputWidget(
                      onSubmit: _onSubmit,
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
}
