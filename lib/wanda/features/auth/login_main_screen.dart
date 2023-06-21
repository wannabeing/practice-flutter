import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/form_screens/login_form_screen.dart';
import 'package:may230517/wanda/features/auth/widgets/auth_bottom_widget.dart';
import 'package:may230517/wanda/features/auth/widgets/auth_btn.dart';

class LoginMainScreen extends StatelessWidget {
  const LoginMainScreen({super.key});

  // 🌐 RouteName
  static String routeName = "/login";

  // 🚀 회원가입 페이지 이동 함수
  void _moveLoginPage(BuildContext context) {
    context.pop();
  }

  // 🚀 이메일 로그인 페이지 이동 함수
  void _onEmailLoginTap(BuildContext context) {
    context.push(LoginFormScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.width / 15,
          vertical: Sizes.height / 20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: Sizes.height / 5,
            ),
            // ✅ 1. 타이틀
            Text(
              "완다 시작하기",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Sizes.width / 12,
              ),
            ),
            Gaps.vheight20,
            // ✅ 2-1. 로그인 위젯
            AuthButton(
              icon: const FaIcon(FontAwesomeIcons.user),
              text: "이메일로 시작하기",
              onTap: () => _onEmailLoginTap(context),
            ),
            Gaps.vheight40,
            // ✅ 2-2. 로그인 위젯
            AuthButton(
              icon: const FaIcon(FontAwesomeIcons.apple),
              text: "애플계정으로 시작하기",
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: AuthBottomWidget(
        onTap: _moveLoginPage,
        type: AuthBottomType.login,
      ),
    );
  }
}
