import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/views/widgets/input_widget.dart';
import 'package:may230517/wanda/features/auth/views/widgets/submit_btn.dart';
import 'package:may230517/wanda/features/auth/vms/auth_vm.dart';
import 'package:may230517/wanda/features/navigations/nav_main_screen.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  // 🌐 RouteName
  static String routeName = "form";

  @override
  ConsumerState<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  String _email = '';
  String _pw = '';
  String _fromFbErrorEmailMsg = '';
  String _fromFbErrorPwMsg = '';

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 로그인 함수
  Future<void> _onLoginTap() async {
    _onUnfocusKeyboard();

    // ✅ firebase auth 로그인
    await ref.read(authProvider.notifier).login(
          email: _email,
          password: _pw,
          context: context,
        );

    // ❌ 계정 에러 발생 시
    if (ref.read(authProvider).hasError) {
      final errorCode = ref.read(authProvider).error.toString();
      _setErrorMsg(errorCode);
    }
    // ✅ 존재하는 계정이면 페이지 이동
    else {
      if (context.mounted) {
        context.go(NavMainScreen.routeName);
      }
    }
  }

  void _setErrorMsg(String errorCode) {
    switch (errorCode) {
      case "user-not-found":
        _fromFbErrorEmailMsg = "존재하지 않는 계정입니다.";
        break;
      case "wrong-password":
        _fromFbErrorPwMsg = "비밀번호를 다시 입력해주세요.";
        break;
      case "invalid-email":
        _fromFbErrorEmailMsg = "권한이 없는 계정입니다.";
        break;
      case "user-disabled":
        _fromFbErrorEmailMsg = "비활성화된 계정입니다.";
        break;
    }
    setState(() {});
  }

  // 🚀 이메일 유효성 검사 함수
  String? _getEmailValid(String email) {
    if (email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return "이메일 형식에 맞게 입력해주세요.";
    }
    return null;
  }

  // 🚀 비밀번호 유효성 검사 함수
  String? _getPwValid(String pw) {
    if (pw.isEmpty) return null;
    if (pw.length < 8 || pw.length >= 20) return "비밀번호 길이는 8-20글자 입니다.";
    if (!pw.contains(RegExp(r"[a-z]"))) return "문자가 들어가야 합니다.";
    if (!pw.contains(RegExp(r"[0-9]"))) return "숫자가 들어가야 합니다.";
    if (!pw.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "특수문자가 들어가야 합니다.";
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      _email = _emailController.value.text;
      _fromFbErrorEmailMsg = '';
      setState(() {});
    });
    _pwController.addListener(() {
      _pw = _pwController.value.text;
      _fromFbErrorPwMsg = '';
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(() {});
    _pwController.removeListener(() {});
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onUnfocusKeyboard(),
      child: Scaffold(
        appBar: AppBar(),
        resizeToAvoidBottomInset: false, // 키보드창에 의한 화면 resize false
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.width / 15,
            vertical: Sizes.height / 20,
          ),
          child: Column(
            children: [
              // ✅ 타이틀 텍스트
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "완다 ",
                    style: TextStyle(
                      fontSize: Sizes.size32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const Text(
                    "이메일로 시작하기",
                    style: TextStyle(
                      fontSize: Sizes.size28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Gaps.vheight20,
              // ✅ 이메일 TextField
              InputWidget(
                controller: _emailController,
                maxLength: 20,
                type: "email",
                hintText: "아이디 (이메일)",
                labelText: "이메일 입력하기",
                errorText: _fromFbErrorEmailMsg.isNotEmpty
                    ? _fromFbErrorEmailMsg
                    : _getEmailValid(_email),
                textInputAction: TextInputAction.next,
                onNext: () {
                  // 다음 텍스트필드로 넘어가기
                  FocusScope.of(context).nextFocus();
                },
              ),
              // ✅ 비밀번호 TextField
              InputWidget(
                controller: _pwController,
                maxLength: 20,
                type: "pw",
                hintText: "비밀번호",
                labelText: "비밀번호 입력하기",
                errorText: _fromFbErrorPwMsg.isNotEmpty
                    ? _fromFbErrorPwMsg
                    : _getPwValid(_pw),
              ),
              Gaps.vheight40,
              // ✅ 이메일 로그인 버튼
              !ref.watch(authProvider).isLoading
                  ? SubmitButton(
                      text: "이메일로 로그인",
                      onTap: () => _onLoginTap(),
                      isActive: _email.isNotEmpty &&
                          _pw.isNotEmpty &&
                          _getEmailValid(_email) == null &&
                          _getPwValid(_pw) == null,
                    )
                  : const CircularProgressIndicator.adaptive(),
              Gaps.vheight30,
            ],
          ),
        ),
      ),
    );
  }
}
