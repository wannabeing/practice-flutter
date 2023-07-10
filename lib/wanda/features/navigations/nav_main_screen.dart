import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/boards/board_main_screen.dart';
import 'package:may230517/wanda/features/chats/chat_main_screen.dart';
import 'package:may230517/wanda/features/mypage/mypage_main_screen.dart';
import 'package:may230517/wanda/features/navigations/widgets/camera_btn_widget.dart';
import 'package:may230517/wanda/features/navigations/widgets/nav_tab_widget.dart';
import 'package:may230517/wanda/features/videos/views/video_main_screen.dart';

class NavMainScreen extends StatefulWidget {
  const NavMainScreen({super.key});

  // 🌐 RouteName
  static String routeName = "/";

  @override
  State<NavMainScreen> createState() => _NavMainScreenState();
}

class _NavMainScreenState extends State<NavMainScreen> {
  int _selectedIndex = 0; // 선택한 탭의 인덱스 번호

  final screens = [
    const Center(
      child: Text("home"),
    ),
    const Center(
      child: Text("search"),
    ),
    const Center(
      child: Text("home"),
    ),
    const Center(
      child: Text("message"),
    ),
    const Center(
      child: Text("myapge"),
    ),
  ];

  // 🚀 탭 이동 함수
  void _onSelectTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드창에 의한 화면 resize false
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0, // false 상태가 되어야 렌더링
            child: const VideoMainScreen(
              videoId: "videoID",
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 1, // false 상태가 되어야 렌더링
            child: const BoardMainScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2, // false 상태가 되어야 렌더링
            child: screens[_selectedIndex],
          ),
          Offstage(
            offstage: _selectedIndex != 3, // false 상태가 되어야 렌더링
            child: const ChatMainScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4, // false 상태가 되어야 렌더링
            child: const MyPageMainScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            NavTabWidget(
              isSelected: _selectedIndex == 0,
              tabIcon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              tabName: "홈",
              onTap: () => _onSelectTap(0),
            ),
            NavTabWidget(
              isSelected: _selectedIndex == 1,
              tabIcon: FontAwesomeIcons.wandSparkles,
              selectedIcon: FontAwesomeIcons.wandMagicSparkles,
              tabName: "완다",
              onTap: () => _onSelectTap(1),
            ),
            const CameraBtnWidget(),
            NavTabWidget(
              isSelected: _selectedIndex == 3,
              tabIcon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              tabName: "채팅",
              onTap: () => _onSelectTap(3),
            ),
            NavTabWidget(
              isSelected: _selectedIndex == 4,
              tabIcon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              tabName: "마이페이지",
              onTap: () => _onSelectTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
