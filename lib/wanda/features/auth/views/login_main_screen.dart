import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/auth/views/widgets/auth_bottom_widget.dart';
import 'package:may230517/wanda/features/auth/views/widgets/submit_btn.dart';
import 'package:may230517/wanda/features/auth/vms/auth_vm.dart';
import 'package:may230517/wanda/features/navigations/nav_main_screen.dart';

enum OnSaveType { email, password }

class LoginMainScreen extends ConsumerStatefulWidget {
  const LoginMainScreen({super.key});

  // 🌐 RouteName
  static String routeName = "/login";

  @override
  ConsumerState<LoginMainScreen> createState() => _LoginMainScreenState();
}

class _LoginMainScreenState extends ConsumerState<LoginMainScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  String _email = '';
  String _pw = '';
  bool _isObscure = true; // 암호화해서 보여주기

  // 🚀 키보드창 언포커스 함수
  void _onUnfocusKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // 🚀 로그인 함수
  Future<void> _onLoginTap() async {
    // ✅ currentState가 존재하면 TextFormField의 validator 실행
    if (_globalKey.currentState != null) {
      // ✅ 유효성검증이 통과되면 true 반환
      if (_globalKey.currentState!.validate()) {
        // ✅ TextFormField의 onSaved 실행
        _globalKey.currentState!.save();

        // ✅ firebase auth 로그인
        await ref.read(authProvider.notifier).login(
              email: _email,
              password: _pw,
              context: context,
            );
        // ✅ 존재하는 계정이면 페이지 이동
        if (!ref.read(authProvider).hasError) {
          if (!mounted) return;
          context.go(NavMainScreen.routeName);
        }
      }
    }
  }

  // 🚀 이메일 유효성 검사 함수
  String? _getEmailValid(String email) {
    if (email.isEmpty) return "이메일을 입력해주세요.";
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return "이메일 형식에 맞게 입력해주세요.";
    }
    return null;
  }

  // 🚀 유효성검사 성공 후 실행되는 onSave 함수
  void _onSaveEmailPassword(
      {required OnSaveType type, required String newValue}) {
    switch (type) {
      case OnSaveType.email:
        _email = newValue;
        setState(() {});
        break;
      case OnSaveType.password:
        _pw = newValue;
        setState(() {});
        break;
    }
  }

  // 🚀 비밀번호 유효성 검사 함수
  String? _getPwValid(String pw) {
    if (pw.isEmpty) return "비밀번호를 입력해주세요.";
    if (pw.length < 8 || pw.length >= 20) return "비밀번호 길이는 8-20글자 입니다.";
    if (!pw.contains(RegExp(r"[a-z]"))) return "문자가 들어가야 합니다.";
    if (!pw.contains(RegExp(r"[0-9]"))) return "숫자가 들어가야 합니다.";
    if (!pw.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "특수문자가 들어가야 합니다.";
    }

    return null;
  }

  // 🚀 비밀번호타입이면 surfix 설정 함수
  Widget _setSurfix([String? type]) {
    switch (type) {
      case "pw":
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _onEye,
              child: FaIcon(
                _isObscure ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                size: Sizes.size20,
                color: Colors.black54,
              ),
            ),
            Gaps.h10,
            GestureDetector(
              onTap: () => _onXmark(_pwController),
              child: const FaIcon(
                FontAwesomeIcons.solidCircleXmark,
                size: Sizes.size20,
                color: Colors.black54,
              ),
            ),
          ],
        );
    }
    // default surfix
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _onXmark(_emailController),
          child: const FaIcon(
            FontAwesomeIcons.solidCircleXmark,
            size: Sizes.size20,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  // 🚀 surfix eye 아이콘 함수
  void _onEye() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  // 🚀 surfix xMark 아이콘 함수
  void _onXmark(TextEditingController controller) {
    controller.clear();
  }

  // 🚀 회원가입 페이지 이동 함수
  void _moveLoginPage(BuildContext context) {
    context.pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onUnfocusKeyboard(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.width / 15,
              vertical: Sizes.height / 10,
            ),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  Gaps.v20,
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
                        "시작하기",
                        style: TextStyle(
                          fontSize: Sizes.size28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Gaps.v40,
                  // ⭐️ 이메일 TextField
                  TextFormField(
                    controller: _emailController,
                    maxLength: 20,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    cursorColor: Theme.of(context).primaryColor,
                    // ✅ 유효성 검사
                    validator: (value) {
                      if (value == null) return "이메일을 입력해주세요.";
                      return _getEmailValid(value);
                    },
                    // ✅ 유효성 검사 성공시, 폼 제출
                    onSaved: (newValue) {
                      if (newValue != null) {
                        _onSaveEmailPassword(
                          type: OnSaveType.email,
                          newValue: newValue,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      suffix: _setSurfix(),
                      hintText: "아이디 (이메일)",
                      labelText: "이메일 입력하기",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      errorStyle: const TextStyle(
                        fontSize: Sizes.size14,
                      ),
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Sizes.size20,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  // ⭐️ 비밀번호 TextField
                  TextFormField(
                    controller: _pwController,
                    maxLength: 20,
                    autocorrect: false,
                    obscureText: _isObscure,
                    cursorColor: Theme.of(context).primaryColor,
                    // ✅ 유효성 검사
                    validator: (value) {
                      if (value == null) return "비밀번호를 입력해주세요.";
                      return _getPwValid(value);
                    },
                    // ✅ 유효성 검사 성공시, 폼 제출
                    onSaved: (newValue) {
                      if (newValue != null) {
                        _onSaveEmailPassword(
                          type: OnSaveType.password,
                          newValue: newValue,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      suffix: _setSurfix("pw"),
                      hintText: "비밀번호",
                      labelText: "비밀번호 입력하기",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      errorStyle: const TextStyle(
                        fontSize: Sizes.size14,
                      ),
                      labelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: Sizes.size20,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
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
        ),
        bottomNavigationBar: AuthBottomWidget(
          onTap: _moveLoginPage,
          type: AuthBottomType.login,
        ),
      ),
    );
  }
}
