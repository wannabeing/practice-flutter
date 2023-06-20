import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/form_screens/birth_form_screen.dart';
import 'package:may230517/wanda/features/auth/widgets/input_widget.dart';
import 'package:may230517/wanda/features/auth/widgets/submit_btn.dart';

class PwFormScreen extends StatefulWidget {
  const PwFormScreen({super.key});

  // 🌐 RouteName
  static String routeName = "pw";

  @override
  State<PwFormScreen> createState() => _PwFormScreenState();
}

class _PwFormScreenState extends State<PwFormScreen> {
  final TextEditingController _textController = TextEditingController();
  String _textValue = '';
  bool _isPwValid = false;

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 비밀번호 유효성 검사 함수
  String? _getPwValid() {
    // 검사 시작 시, false
    setState(() {
      _isPwValid = false;
    });
    if (_textValue.isEmpty) return null;

    if (!_textValue.contains(RegExp(r"[a-z]"))) return "문자가 들어가야 합니다.";
    if (!_textValue.contains(RegExp(r"[0-9]"))) return "숫자가 들어가야 합니다.";
    if (!_textValue.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "특수문자가 들어가야 합니다.";
    }
    // 검사 완료 시, true
    setState(() {
      _isPwValid = true;
    });
    return null;
  }

  // 🚀 비밀번호 길이 유효성 검사 함수
  bool _getPwLength() {
    return _textValue.isNotEmpty &&
        _textValue.length >= 8 &&
        _textValue.length <= 20;
  }

  // 🚀 스크린 이동 함수
  void _nextScreen() {
    if (_textValue.isEmpty || _getPwValid() != null || !_getPwLength()) return;

    context.push(BirthFormScreen.routeName);
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
                "비밀번호 입력",
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v20,
              InputWidget(
                controller: _textController,
                onSubmitted: _nextScreen,
                hintText: "비밀번호 입력",
                errorText: _getPwValid(),
                type: "pw",
              ),
              Gaps.v16,
              const Text("비밀번호는 아래 조건을 만족해야합니다."),
              Gaps.v8,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size18,
                    color: _getPwLength()
                        ? Colors.green.shade500
                        : Colors.grey.shade500,
                  ),
                  Gaps.h10,
                  const Text("8-20글자"),
                ],
              ),
              Gaps.v8,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size18,
                    color: _isPwValid
                        ? Colors.green.shade500
                        : Colors.grey.shade500,
                  ),
                  Gaps.h10,
                  const Text("숫자/문자/특수문자 조합"),
                ],
              ),
              Gaps.v20,
              SubmitButton(
                text: "다음",
                onTap: _nextScreen,
                isActive: _textValue.isNotEmpty &&
                    _getPwValid() == null &&
                    _getPwLength(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
