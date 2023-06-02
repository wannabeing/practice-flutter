import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

import 'package:may230517/wanda/features/auth/widgets/input_widget.dart';
import 'package:may230517/wanda/features/auth/widgets/submit_btn.dart';
import 'package:may230517/wanda/features/onboard/onboard_main_screen.dart';

class BirthFormScreen extends StatefulWidget {
  const BirthFormScreen({super.key});

  @override
  State<BirthFormScreen> createState() => _BirthFormScreenState();
}

class _BirthFormScreenState extends State<BirthFormScreen> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // 텍스트필드 포커스를 위한 변수
  String _textValue = '';

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 스크린 이동 함수
  void _nextScreen() {
    if (_textValue.isEmpty || _getBirthValid() != null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OnboardMainScreen(),
      ),
    );
  }

  // 🚀 생년월일 유효성 검사 함수
  String? _getBirthValid() {
    if (_textValue.isEmpty) return null;

    if (_textValue.contains(RegExp(r"[a-z]"))) return "문자는 들어갈 수 없습니다.";
    if (!_textValue.contains(RegExp(r"[0-9]"))) return "숫자가 들어가야 합니다.";

    if (_textValue.length != 8) return "8자리여야 합니다.";
    if (!_textValue.startsWith(RegExp(r"19[5-9][0-9]|20[0-9]{2}"))) {
      return "생년을 제대로 입력해주세요.";
    }

    String month = _textValue.substring(4, 6);
    if (!RegExp(r"(0[1-9]|1[0-2])").hasMatch(month)) {
      return "존재하지 않는 월 입니다.";
    }

    String day = _textValue.substring(6, 8);
    if (!RegExp(r"(0[1-9]|[1-2][0-9]|3[01])").hasMatch(day)) {
      return "존재하지 않는 일 입니다.";
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    // 🚀 함수시작 시, 텍스트필드창 포커스
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });

    // 🚀 Text값 변수에 저장
    _textController.addListener(() {
      setState(() {
        _textValue = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
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
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size28,
            vertical: Sizes.size24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "생일을 알려주세요!",
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
                focusNode: _focusNode,
                onSubmitted: _nextScreen,
                type: "birth",
                hintText: "생일 선택",
                errorText: _getBirthValid(),
                maxLength: 8,
              ),
              Gaps.v40,
              SubmitButton(
                text: "완다 시작하기",
                onTap: _nextScreen,
                isActive: _textValue.isNotEmpty && _getBirthValid() == null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
