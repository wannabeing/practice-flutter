import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/features/auth/form_screens/name_form_screen.dart';

import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/login_main_screen.dart';
import 'package:may230517/wanda/features/auth/widgets/auth_bottom_widget.dart';

import 'package:may230517/wanda/features/auth/widgets/auth_btn.dart';

class SignupMainScreen extends StatelessWidget {
  const SignupMainScreen({super.key});
  // 🌐 RouteName
  static String routeName = "/signup";

  // 🚀 로그인 페이지 이동 함수
  void _moveLoginPage(BuildContext context) {
    context.push(LoginMainScreen.routeName);
  }

  // 🚀 이메일 회원가입 페이지 이동 함수
  void _onEmailSignupTap(BuildContext context) {
    context.push(NameFormScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.width / 15,
        ),
        child: Column(
          children: [
            SizedBox(
              height: Sizes.height / 5,
            ),
            // ✅ 1. 타이틀
            Text(
              "완다 가입하기",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Sizes.width / 12,
              ),
            ),
            // ✅ 2. 서브 타이틀
            const Opacity(
              opacity: 0.7,
              child: Text(
                "회원가입하고 완다를 시작해보세요!",
                textAlign: TextAlign.center,
              ),
            ),
            Gaps.vheight20,
            // ✅ 3-1. 회원가입 위젯
            AuthButton(
              icon: const FaIcon(FontAwesomeIcons.user),
              text: "이메일로 회원가입",
              onTap: () => _onEmailSignupTap(context),
            ),
            Gaps.vheight40,
            // ✅ 3-2. 회원가입 위젯
            AuthButton(
              icon: const FaIcon(FontAwesomeIcons.apple),
              text: "애플계정으로 회원가입",
              onTap: () => _onEmailSignupTap(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AuthBottomWidget(
        type: AuthBottomType.signup,
        onTap: _moveLoginPage,
      ),
    );
  }
}
