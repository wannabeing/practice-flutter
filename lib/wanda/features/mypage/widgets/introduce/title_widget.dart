import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/settings/setting_main_screen.dart';

class MypageIntroduceTitleWidget extends StatelessWidget {
  final String userId;
  const MypageIntroduceTitleWidget({
    super.key,
    required this.userId,
  });

  // 🚀 설정스크린 이동 함수
  void _moveSettingScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const SettingMainScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true, // 고정
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          userId, // userID
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: Sizes.width / 17,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _moveSettingScreen(context),
          icon: const FaIcon(FontAwesomeIcons.gear),
        ),
      ],
    );
  }
}
