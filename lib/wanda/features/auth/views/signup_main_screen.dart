import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/views/form_screens/name_form_screen.dart';
import 'package:may230517/wanda/features/auth/views/login_main_screen.dart';
import 'package:may230517/wanda/features/auth/views/widgets/auth_alert_widget.dart';
import 'package:may230517/wanda/features/auth/views/widgets/auth_bottom_widget.dart';

import 'package:may230517/wanda/features/auth/views/widgets/auth_btn.dart';
import 'package:may230517/wanda/features/auth/vms/social_auth_vm.dart';
import 'package:may230517/wanda/features/navigations/nav_main_screen.dart';

class SignupMainScreen extends ConsumerWidget {
  const SignupMainScreen({super.key});
  // 🌐 RouteName
  static String routeName = "/signup";

  // 🚀 로그인 페이지 이동 함수
  void _moveLoginPage(BuildContext context) {
    context.push(LoginMainScreen.routeName);
  }

  // 🚀 이메일 회원가입 페이지 이동 함수
  void _onEmailSignupTap(BuildContext context) {
    context.pushNamed(NameFormScreen.routeName);
  }

  // 🚀 깃허브 로그인 페이지 이동 함수
  Future<void> _onLoginGitHub(BuildContext context, WidgetRef ref) async {
    // firebase 요청
    await ref.read(socialAuthProvider.notifier).githubSignup();

    // ❌ 계정 에러 발생 시
    if (ref.read(socialAuthProvider).hasError) {
      final errorCode = ref.read(socialAuthProvider).error.toString();

      // 🚀 중복 계정 에러 알림창 함수 실행
      if (context.mounted && errorCode == "existEmail") {
        showDialog(
          context: context,
          builder: (context) {
            return const AuthAlertWidget();
          },
        );
      }
    }
    // ✅ 성공시 페이지 이동
    else {
      if (context.mounted) {
        context.go(NavMainScreen.routeName);
      }
    }
  }

  // 🚀 구글 로그인 페이지 이동 함수
  Future<void> _onLoginGoogle(BuildContext context, WidgetRef ref) async {
    // firebase 요청
    await ref.read(socialAuthProvider.notifier).googleSignup();

    // ❌ 계정 에러 발생 시
    if (ref.read(socialAuthProvider).hasError) {
      // 중복이메일: account-exists-with-different-credential
      ref.read(socialAuthProvider).error.toString();

      // 🚀 중복 계정 에러 알림창 함수 실행
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return const AuthAlertWidget();
          },
        );
      }
    }
    // ✅ 성공시 페이지 이동
    else {
      if (context.mounted) {
        context.go(NavMainScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.width / 15,
        ),
        child: Stack(
          children: [
            IgnorePointer(
              ignoring: ref.watch(socialAuthProvider).isLoading,
              child: Opacity(
                opacity: ref.watch(socialAuthProvider).isLoading ? 0.5 : 1,
                child: Column(
                  children: [
                    SizedBox(
                      height: Sizes.height / 5,
                    ),
                    // ✅ 1. 타이틀
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
                          " 가입하기",
                          style: TextStyle(
                            fontSize: Sizes.width / 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // ✅ 2. 서브 타이틀
                    const Opacity(
                      opacity: 0.7,
                      child: Text("회원가입하고 완다를 시작해보세요!"),
                    ),
                    Gaps.vheight20,
                    // ✅ 3-1. 회원가입 위젯
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.user),
                      text: "이메일로 회원가입",
                      onTap: () => _onEmailSignupTap(context),
                    ),
                    Gaps.vheight40,
                    // ✅ 3-2. 깃허브 회원가입 위젯
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.github),
                      text: "깃허브로 회원가입",
                      onTap: () => _onLoginGitHub(context, ref),
                    ),
                    Gaps.vheight40,
                    // ✅ 3-3. 구글 회원가입 위젯
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.google),
                      text: "구글계정으로 회원가입",
                      onTap: () => _onLoginGoogle(context, ref),
                    ),
                  ],
                ),
              ),
            ),
            if (ref.watch(socialAuthProvider).isLoading)
              const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator.adaptive(),
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
