import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/widgets/form_input_widget.dart';
import 'package:may230517/wanda/features/auth/widgets/submit_btn.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  String _email = '';
  String _pw = '';

  // 🚀 로그인 함수
  void _onLoginTap() {
    // currentState가 존재하면 TextFormField의 validator 실행
    if (_globalKey.currentState != null) {
      // 유효성검증이 통과되면 true 반환
      if (_globalKey.currentState!.validate()) {
        // TextFormField의 onSaved 실행
        _globalKey.currentState!.save();
      }
    }
  }

  // 🚀 이메일 유효성 검사 함수

  // 🚀 비밀번호 유효성 검사 함수
  String? _getPwValid() {
    // 검사 시작 시, false

    if (_pw.isEmpty) return null;

    if (!_pw.contains(RegExp(r"[a-z]"))) return "문자가 들어가야 합니다.";
    if (!_pw.contains(RegExp(r"[0-9]"))) return "숫자가 들어가야 합니다.";
    if (!_pw.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "특수문자가 들어가야 합니다.";
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    // 🚀 Email값 변수에 저장
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });

    // 🚀 Pw값 변수에 저장
    _pwController.addListener(() {
      setState(() {
        _pw = _pwController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size32,
          vertical: Sizes.size24,
        ),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              Gaps.v20,
              const FormInputWidget(
                type: "email",
                hintText: "이메일",
                errorText: "",
              ),
              Gaps.v20,
              const FormInputWidget(
                type: "pw",
                hintText: "비밀번호",
                errorText: "",
              ),
              Gaps.v44,
              SubmitButton(
                text: "로그인",
                onTap: () => _onLoginTap(),
                isActive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
