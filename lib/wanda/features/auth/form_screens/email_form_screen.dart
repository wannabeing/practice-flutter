import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/form_screens/pw_form_screen.dart';

import 'package:may230517/wanda/features/auth/widgets/input_widget.dart';
import 'package:may230517/wanda/features/auth/widgets/submit_btn.dart';

class EmailFormScreen extends StatefulWidget {
  const EmailFormScreen({super.key});

  // 🌐 RouteName
  static String routeName = "email";

  @override
  State<EmailFormScreen> createState() => _EmailFormScreenState();
}

class _EmailFormScreenState extends State<EmailFormScreen> {
  final TextEditingController _textController = TextEditingController();
  String _textValue = '';

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 이메일 유효성 검사 함수
  String? _getEmailValid() {
    if (_textValue.isEmpty) return null;

    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_textValue)) {
      return "이메일 형식에 맞게 입력해주세요.";
    }
    return null;
  }

  // 🚀 스크린 이동 함수
  void _nextScreen() {
    if (_textValue.isEmpty || _getEmailValid() != null) return;

    context.push(PwFormScreen.routeName);
  }

  @override
  void initState() {
    super.initState();

    // 🚀 Text값 변수에 저장
    _textController.addListener(() {
      setState(() {
        _textValue = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onUnfocusKeyboard,
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.width / 15,
            vertical: Sizes.height / 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "이메일 입력",
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v20,
              InputWidget(
                controller: _textController,
                onSubmitted: _nextScreen,
                hintText: "이메일 입력",
                errorText: _getEmailValid(),
                type: "email",
              ),
              Gaps.v40,
              SubmitButton(
                text: "다음",
                onTap: _nextScreen,
                isActive: _textValue.isNotEmpty && _getEmailValid() == null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
