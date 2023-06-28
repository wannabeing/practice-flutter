import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

enum AuthBottomType { login, signup }

class AuthBottomWidget extends StatelessWidget {
  const AuthBottomWidget({
    super.key,
    required this.onTap,
    required this.type,
  });

  final Function onTap;
  final AuthBottomType type;

  // 🚀 설명텍스트 설정 함수
  String _setDesc(AuthBottomType type) {
    switch (type) {
      case AuthBottomType.signup:
        return "이미 계정이 있으신가요?";
      case AuthBottomType.login:
        return "회원이 아니신가요?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Sizes.height / 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _setDesc(type),
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            Gaps.h10,
            GestureDetector(
              onTap: () => onTap(context),
              child: Text(
                type == AuthBottomType.login ? "회원가입" : "로그인",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
