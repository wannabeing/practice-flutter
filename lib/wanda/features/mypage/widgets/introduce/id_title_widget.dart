import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/mypage/mypage_edit_screen.dart';
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

  // 🚀 프로필 수정 스크린 이동 함수
  void _moveEditProfile(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return const MyPageEditScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true, // 고정
      title: GestureDetector(
        onTap: () => _moveEditProfile(context),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                email, // email
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: Sizes.width / 20,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded),
          ],
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
