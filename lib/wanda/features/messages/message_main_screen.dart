import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/messages/widgets/message_list_widget.dart';

class MessageMainScreen extends StatefulWidget {
  const MessageMainScreen({super.key});

  @override
  State<MessageMainScreen> createState() => _MessageMainScreenState();
}

class _MessageMainScreenState extends State<MessageMainScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isOffsetOver = false; // appBar title 활성화 여부

  // 🚀 스크롤 감지 함수
  void _onScroll() {
    // ✅ offset이 50 넘어가면 상태 변경
    if (_scrollController.offset > 50) {
      // ✅ 이미 true라면 return (중복 setState 방지)
      if (_isOffsetOver) return;
      setState(() {
        _isOffsetOver = true;
      });
    } else {
      setState(() {
        _isOffsetOver = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // ✅ Scroll Listen
    _scrollController.addListener(() {
      _onScroll(); // 스크롤 할 때마다, 함수 실행
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: _isOffsetOver ? 1 : 0,
        title: Row(
          children: [
            Text(
              "채팅",
              style: TextStyle(
                fontSize: Sizes.width / 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.plus,
            ),
          ),
        ],
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          itemBuilder: (context, index) {
            return const MessageListWidget(
              nickname: "닉네임",
              lastChat: "마지막 대화내용",
              lastChatTime: "어제",
            );
          },
          separatorBuilder: (context, index) => Container(
            height: Sizes.height / 100,
          ),
          itemCount: 20,
        ),
      ),
    );
  }
}
