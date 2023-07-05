import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/settings/views/setting_main_screen.dart';

class MypageIntroduceTitleWidget extends StatelessWidget {
  final String email;

  const MypageIntroduceTitleWidget({
    super.key,
    required this.email,
  });

  // 🚀 설정스크린 이동 함수
  void _moveSettingScreen(BuildContext context) {
    context.push(SettingMainScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true, // 고정
      title: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          email, // email
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: Sizes.width / 20,
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
