import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class InputWidget extends StatefulWidget {
  final VoidCallback? onSubmitted;
  final TextEditingController controller;
  final String type;
  final String hintText;
  final bool setFocusNode; // input창 포커스 여부
  final String? errorText;
  final int? maxLength;
  final bool? existEmail; // 이메일 중복 여부 (true: 중복)

  const InputWidget({
    super.key,
    required this.controller,
    String? hintText,
    String? type,
    bool? setFocusNode,
    bool? existEmail,
    this.errorText,
    this.onSubmitted,
    this.maxLength,
  })  : type = type ?? "default",
        hintText = hintText ?? "",
        setFocusNode = setFocusNode ?? true,
        existEmail = existEmail ?? false;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _isObscure = false; // 암호화해서 보여주기
  final FocusNode _focusNode = FocusNode(); // 텍스트필드 포커스를 위한 변수

  // 🚀 키보드 형식 설정 함수
  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case "email":
        return TextInputType.emailAddress;
      case "birth":
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  // 🚀 null이 아닌 상속받은 함수 실행
  void _onSubmitted() {
    if (widget.onSubmitted != null) {
      widget.onSubmitted!();
    } else {
      return;
    }
  }

  // 🚀 비밀번호타입이면 surfix 설정 함수
  Widget? _setSurfix() {
    switch (widget.type) {
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
              onTap: _onXmark,
              child: const FaIcon(
                FontAwesomeIcons.solidCircleXmark,
                size: Sizes.size20,
                color: Colors.black54,
              ),
            ),
          ],
        );
      default:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _onXmark,
              child: const FaIcon(
                FontAwesomeIcons.solidCircleXmark,
                size: Sizes.size20,
                color: Colors.black54,
              ),
            ),
          ],
        );
    }
  }

  // 🚀 surfix eye 아이콘 함수
  void _onEye() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  // 🚀 surfix xMark 아이콘 함수
  void _onXmark() {
    widget.controller.clear();
  }

  @override
  void initState() {
    super.initState();

    // 🚀 함수시작 시, 텍스트필드창 포커스
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });

    // 비밀번호 위젯이면, 텍스트 암호화 설정
    if (widget.type == "pw") {
      setState(() {
        _isObscure = true;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      focusNode: _focusNode, // 텍스트필드 자동 포커스
      onEditingComplete: _onSubmitted,
      keyboardType: _getKeyboardType(),
      autocorrect: false,
      obscureText: _isObscure,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        suffix: _setSurfix(),
        errorText: widget.existEmail! ? "이미 존재하는 이메일입니다." : widget.errorText,
        errorStyle: const TextStyle(
          fontSize: Sizes.size14,
        ),
        hintText: widget.hintText,
        labelText: widget.type == "birth" ? "생년월일 8자리" : null,
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
    );
  }
}
