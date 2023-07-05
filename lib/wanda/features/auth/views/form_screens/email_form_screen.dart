import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/views/form_screens/pw_form_screen.dart';

import 'package:may230517/wanda/features/auth/views/widgets/input_widget.dart';
import 'package:may230517/wanda/features/auth/views/widgets/submit_btn.dart';
import 'package:may230517/wanda/features/auth/vms/email_auth_vm.dart';

class EmailFormScreen extends ConsumerStatefulWidget {
  const EmailFormScreen({super.key});

  // 🌐 RouteName
  static String routeName = "email";

  @override
  ConsumerState<EmailFormScreen> createState() => _EmailFormScreenState();
}

class _EmailFormScreenState extends ConsumerState<EmailFormScreen> {
  final TextEditingController _textController = TextEditingController();
  String _textValue = '';
  bool _existEmail = false; // 이메일 중복 여부 (false: 기본값)

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 이메일 유효성 검사 함수
  String? _getEmailValid({String? text}) {
    if (_textValue.isEmpty) return null;

    // 매개변수를 전달받으면 해당 텍스트를 에러메시지로 출력
    if (text != null) {
      return text;
    }

    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_textValue)) {
      return "이메일 형식에 맞게 입력해주세요.";
    }
    return null;
  }

  // 🚀 스크린 이동 함수
  void _nextScreen() async {
    if (_textValue.isEmpty || _getEmailValid() != null) return;
    _onUnfocusKeyboard();

    // 중복 이메일인지 firebase auth 확인
    await ref.read(emailAuthProvider.notifier).isValidEmail(_textValue);
    // state 값 (TRUE/FALSE) 가져오기
    // ignore: invalid_use_of_protected_member
    final isValid = await ref.read(emailAuthProvider.notifier).state.value;

    // ✅ 이메일 중복되지 않으면 진행
    if (isValid) {
      // Signup Provider state에 저장
      final state = ref.read(signupProvider.notifier).state;
      ref.read(signupProvider.notifier).state = {
        ...state,
        "email": _textValue,
      };

      // 스크린 이동
      if (context.mounted) {
        context.pushNamed(PwFormScreen.routeName);
      }
    }
    // ❌ 이메일 중복이면 Error 메시지 출력
    else {
      _existEmail = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    // 🚀 Text값 변수에 저장
    _textController.addListener(() {
      setState(() {
        _textValue = _textController.text;
        _existEmail = false;
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
          child: Stack(
            children: [
              IgnorePointer(
                ignoring: ref.watch(emailAuthProvider).isLoading,
                child: Opacity(
                  opacity: ref.watch(emailAuthProvider).isLoading ? 0.5 : 1,
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
                        errorText:
                            _existEmail ? "이미 존재하는 이메일입니다." : _getEmailValid(),
                        type: "email",
                        setFocusNode: true,
                      ),
                      Gaps.v40,
                      SubmitButton(
                        text: "다음",
                        onTap: _nextScreen,
                        isActive: _textValue.isNotEmpty &&
                            _getEmailValid() == null &&
                            !_existEmail,
                      ),
                    ],
                  ),
                ),
              ),

              // ✅ 로딩바
              if (ref.watch(emailAuthProvider).isLoading)
                const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator.adaptive(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
