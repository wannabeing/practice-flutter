import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/constants/utils.dart';
import 'package:may230517/wanda/features/chats/chat_detail_screen.dart';
import 'package:may230517/wanda/features/chats/chat_select_screen.dart';
import 'package:may230517/wanda/features/chats/widgets/chat_list_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatMainScreen extends StatefulWidget {
  const ChatMainScreen({super.key});

  // 🌐 RouteName
  static String routeName = "/chats";

  @override
  State<ChatMainScreen> createState() => _ChatMainScreenState();
}

class _ChatMainScreenState extends State<ChatMainScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
  );

  // 예시 채팅리스트
  late final List<Widget> _items = List.generate(
    20,
    (index) => ChatListWidget(
      nickname: "닉네임 $index",
      lastChat: "마지막 대화",
      lastChatTime: timeago.format(DateTime.now()),
      index: index,
      onTap: _moveDetailChatScreen,
      onLongPress: _onDel,
    ),
  );

  bool _isOffsetOver = false; // appBar title 활성화 여부
  bool _isPlusTap = false; // 메시지 추가 아이콘 클릭여부

  // 일반/비밀채팅 AppTitle 위치 애니메이션
  late final _offsetAnimation = Tween(
    begin: const Offset(0, -1), // 시작비율 (y축으로 -100% 완전숨기기)
    end: const Offset(0, 0), // 끝비율 (원래대로)
  ).animate(_animationController);

  // 일반/비밀채팅 AppTitle 배경컬러 애니메이션
  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black54,
  ).animate(_animationController);

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

  // 🚀 메시지 삭제 함수
  void _onDel(int index) {
    _items.removeAt(index);
    setState(() {});
  }

  // 🚀 채팅 상대 선택 페이지 이동 함수
  void _moveSelectChatScreen() {
    _onPlusChat(); // 기존 열려있던 추가채팅화면 제거

    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true, // 밑에서 위로 렌더링
        builder: (context) {
          return const ChatSelectScreen();
        },
      ),
    );
  }

  // 🚀 채팅 디테일 페이지 이동 함수
  void _moveDetailChatScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const ChatDetailScreen(
            chatOppId: "메인에서 디테일로",
          );
        },
      ),
    );
  }

  // 🚀 메시지 추가함수 클릭
  Future<void> _onPlusChat() async {
    // animation 동작했을 때
    if (_animationController.isCompleted) {
      await _animationController.reverse();
      _isPlusTap = false;
    }
    // 처음 animation 동작할 때
    else {
      _animationController.forward();
      _isPlusTap = true;
    }

    setState(() {});
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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: _isOffsetOver ? 1 : 0,
        leading:
            // ✅ 채팅추가함수 클릭 여부
            _isPlusTap
                ? IconButton(
                    onPressed: () => _onPlusChat(),
                    icon: const FaIcon(
                      FontAwesomeIcons.xmark,
                    ),
                  )
                : null,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              // ✅ 채팅추가함수 클릭 여부
              _isPlusTap ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            // ✅ 채팅추가함수 클릭 여부
            if (!_isPlusTap) ...[
              Text(
                "채팅",
                style: TextStyle(
                  fontSize: Sizes.width / 20,
                ),
              ),
            ] else ...[
              Text(
                "새로운 채팅",
                style: TextStyle(
                  fontSize: Sizes.width / 18,
                ),
              ),
            ],
          ],
        ),
        actions: [
          // ✅ 채팅추가함수 클릭 여부
          if (!_isPlusTap) ...[
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.magnifyingGlass,
              ),
            ),
            IconButton(
              onPressed: () => _onPlusChat(),
              icon: const FaIcon(
                FontAwesomeIcons.plus,
              ),
            ),
            IconButton(
              onPressed: () => _onPlusChat(),
              icon: const FaIcon(
                FontAwesomeIcons.ellipsis,
              ),
            ),
          ] else
            ...[]
        ],
      ),
      body: Stack(
        children: [
          // ✅ 1. 채팅리스트
          Scrollbar(
            controller: _scrollController,
            child: ListView.separated(
              itemCount: _items.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                // ✅ MessageListWidget in Dismissible
                return Dismissible(
                  onDismissed: (direction) => _onDel(index),
                  key: Key("${_items[index].hashCode}"),
                  direction: DismissDirection.endToStart,
                  // 옆으로 밀면 나오는 휴지통아이콘
                  background: Container(
                    padding: EdgeInsets.only(
                      right: Sizes.width / 10,
                    ),
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.trash,
                          color: Colors.white,
                        ),
                        Gaps.v5,
                        Text(
                          "나가기",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  // ✅ MessageListWidget
                  child: _items[index],
                );
              },
              separatorBuilder: (context, index) => Container(
                height: 1,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 0.2,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // ✅ 2. 일반/비밀채팅 AppTitle 활성화 시 렌더링
          if (_isPlusTap)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true,
              onDismiss: () => _onPlusChat(),
            ),
          // ✅ 3. 일반채팅/비밀채팅 apptitle
          SlideTransition(
            position: _offsetAnimation,
            child: Container(
              height: Sizes.height / 10,
              decoration: BoxDecoration(
                  color: Utils.isDarkMode(context)
                      ? Colors.black
                      : Colors.grey.shade50,
                  border: const Border(
                      bottom: BorderSide(
                    color: Colors.black,
                    width: 0.1,
                  ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _moveSelectChatScreen(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.chat_bubble_outline_outlined),
                        Text("일반채팅"),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.lock_open_outlined),
                      Text("비밀채팅"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
