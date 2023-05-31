import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/features/auth/form_screens/name_form_screen.dart';

import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/login_main_screen.dart';

import 'package:may230517/wanda/features/auth/widgets/auth_btn.dart';

class SignupMainScreen extends StatelessWidget {
  const SignupMainScreen({super.key});

  // 🚀 로그인 페이지 이동 함수
  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginMainScreen(),
      ),
    );
  }

  // 🚀 이메일 회원가입 페이지 이동 함수
  void _onEmailSignupTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NameFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size32,
            vertical: Sizes.size24,
          ),
          child: Column(
            children: [
              SizedBox(
                height: Sizes.height / 10,
              ),
              const Text(
                "완다에 들어오시죠",
                textAlign: TextAlign.center,
              ),
              Gaps.v20,
              const Text(
                "완다에 대한 설멸ㅇ완다에 대한 설멸ㅇ완다에 대한 설멸ㅇ완다에 대한 설멸ㅇ완다에 대한 설멸ㅇ완다에 대한 설멸ㅇ.",
                style: TextStyle(
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v20,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.user),
                text: "이메일로 회원가입",
                onTap: () => _onEmailSignupTap(context),
              ),
              Gaps.v16,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.apple),
                text: "애플계정으로 회원가입",
                onTap: () => _onEmailSignupTap(context),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade100,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("이미 계정이 있으신가요?"),
              Gaps.h10,
              GestureDetector(
                onTap: () => _onLoginTap(context),
                child: Text(
                  "로그인",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
