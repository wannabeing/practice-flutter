import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/navigations/widgets/nav_tab_widget.dart';

class NavMainScreen extends StatefulWidget {
  const NavMainScreen({super.key});

  @override
  State<NavMainScreen> createState() => _NavMainScreenState();
}

class _NavMainScreenState extends State<NavMainScreen> {
  int _selectedIndex = 0;

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

  void _onSelectTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              tabIcon: FontAwesomeIcons.clipboard,
              selectedIcon: FontAwesomeIcons.solidClipboard,
              tabName: "검색",
              onTap: () => _onSelectTap(1),
            ),
            NavTabWidget(
              isSelected: _selectedIndex == 2,
              tabIcon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              tabName: "홈",
              onTap: () => _onSelectTap(2),
            ),
            NavTabWidget(
              isSelected: _selectedIndex == 3,
              tabIcon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              tabName: "메시지",
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
