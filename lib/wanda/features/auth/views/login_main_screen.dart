import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/views/form_screens/login_form_screen.dart';
import 'package:may230517/wanda/features/auth/views/widgets/auth_bottom_widget.dart';
import 'package:may230517/wanda/features/auth/views/widgets/auth_btn.dart';

class LoginMainScreen extends ConsumerWidget {
  const LoginMainScreen({super.key});

  // 🌐 RouteName
  static String routeName = "/login";

  // 🚀 이메일 로그인 페이지 이동 함수
  void _onLoginForm(BuildContext context) {
    context.pushNamed(LoginFormScreen.routeName);
  }

  // 🚀 깃허브 로그인 페이지 이동 함수
  void _onGithub() {}

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  // 🚀 회원가입 페이지 이동 함수
  void _moveLoginPage(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _onUnfocusKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드창에 의한 화면 resize false
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.width / 15,
              vertical: Sizes.height / 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // ✅ 타이틀 텍스트
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "완다",
                      style: TextStyle(
                        fontSize: Sizes.width / 10,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(
                      " 시작하기",
                      style: TextStyle(
                        fontSize: Sizes.width / 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // ✅ 서브 타이틀 텍스트
                const Opacity(
                  opacity: 0.7,
                  child: Text("가입한 아이디로 로그인할 수 있습니다."),
                ),
                Gaps.vheight20,
                // ✅ 이메일로 시작하기
                AuthButton(
                  text: "이메일로 시작하기",
                  icon: const FaIcon(FontAwesomeIcons.envelope),
                  onTap: () => _onLoginForm(context),
                ),
                Gaps.vheight40,
                // ✅ 깃허브로 시작하기
                AuthButton(
                  text: "깃허브로 시작하기",
                  icon: const FaIcon(FontAwesomeIcons.github),
                  onTap: () => _onLoginForm(context),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AuthBottomWidget(
          onTap: _moveLoginPage,
          type: AuthBottomType.login,
        ),
      ),
    );
  }
}
