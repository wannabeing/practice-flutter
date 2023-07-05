import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/views/interest_screen.dart';
import 'package:may230517/wanda/features/auth/views/widgets/input_widget.dart';
import 'package:may230517/wanda/features/auth/views/widgets/submit_btn.dart';
import 'package:may230517/wanda/features/auth/vms/email_auth_vm.dart';

class BirthFormScreen extends ConsumerStatefulWidget {
  const BirthFormScreen({super.key});

  // 🌐 RouteName
  static String routeName = "birth";

  @override
  ConsumerState<BirthFormScreen> createState() => _BirthFormScreenState();
}

class _BirthFormScreenState extends ConsumerState<BirthFormScreen> {
  final TextEditingController _textController = TextEditingController();
  String _textValue = '';

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 스크린 이동 함수
  void _nextScreen() {
    if (_textValue.isEmpty || _getBirthValid() != null) return;

    // Signup Provider state에 저장
    final state = ref.read(signupProvider.notifier).state;
    ref.read(signupProvider.notifier).state = {
      ...state,
      "birth": _textValue,
    };
    // 스크린 이동
    context.goNamed(InterestScreen.routeName);
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
                onSubmitted: _nextScreen,
                type: "birth",
                hintText: "생일 선택",
                labelText: "생년월일 8자리",
                errorText: _getBirthValid(),
                maxLength: 8,
                setFocusNode: true,
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
