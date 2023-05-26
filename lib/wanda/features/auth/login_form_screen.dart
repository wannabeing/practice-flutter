import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/widgets/auth_btn.dart';

class LoginFormScreen extends StatelessWidget {
  const LoginFormScreen({super.key});

  // 🚀 회원가입 페이지 이동 함수
  void _onLoginTap(BuildContext context) {
    Navigator.of(context).pop();
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
                height: Gaps.height / 10,
              ),
              const Text(
                "완다 로그인",
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
                text: "이메일로 시작하기",
                onTap: () {},
              ),
              Gaps.v16,
              AuthButton(
                icon: const FaIcon(FontAwesomeIcons.apple),
                text: "애플계정으로 시작하기",
                onTap: () {},
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
              const Text("회원이 아니신가요?"),
              Gaps.h10,
              GestureDetector(
                onTap: () => _onLoginTap(context),
                child: Text(
                  "회원가입",
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
