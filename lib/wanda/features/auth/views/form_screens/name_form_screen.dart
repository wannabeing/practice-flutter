import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/views/form_screens/email_form_screen.dart';

import 'package:may230517/wanda/features/auth/views/widgets/input_widget.dart';
import 'package:may230517/wanda/features/auth/views/widgets/submit_btn.dart';

class NameFormScreen extends StatefulWidget {
  const NameFormScreen({super.key});

  // 🌐 RouteName
  static String routeName = "username";

  @override
  State<NameFormScreen> createState() => _NameFormScreenState();
}

class _NameFormScreenState extends State<NameFormScreen> {
  final TextEditingController _textController = TextEditingController();
  String _textValue = '';

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 스크린 이동 함수
  void _nextScreen() {
    if (_textValue.isEmpty || _getNameValid() != null) return;

    context.push(EmailFormScreen.routeName);
  }

  // 🚀 닉네임 유효성 검사 함수
  String? _getNameValid() {
    if (_textValue.isEmpty) return null;

    if (_textValue.length > 8) {
      return "닉네임은 8자 이하입니다.";
    }
    return null;
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
                "닉네임 입력",
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v10,
              Text(
                "나중에 변경할 수 있습니다.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.grey.shade600,
                ),
              ),
              Gaps.v20,
              InputWidget(
                controller: _textController,
                onSubmitted: _nextScreen,
                hintText: "닉네임",
                errorText: _getNameValid(),
              ),
              Gaps.v40,
              SubmitButton(
                text: "다음",
                onTap: _nextScreen,
                isActive: _textValue.isNotEmpty && _getNameValid() == null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
