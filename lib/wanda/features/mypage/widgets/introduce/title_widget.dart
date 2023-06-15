import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class MypageIntroduceTitleWidget extends StatelessWidget {
  final String userId;
  const MypageIntroduceTitleWidget({
    super.key,
    required this.userId,
  });

  // 🚀 마이페이지 설정 함수
  void _onSetting() {}

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
          onPressed: () => _onSetting(),
          icon: const FaIcon(FontAwesomeIcons.gear),
        ),
      ],
    );
  }
}
