import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class InputWidget extends StatefulWidget {
  final VoidCallback? onSubmitted;
  final TextEditingController controller;
  final String type;
  final String hintText;
  final String? errorText;

  const InputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.onSubmitted,
    String? type,
  }) : type = type ?? "default";

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool _isObscure = false;

  // 🚀 키보드 형식 설정 함수
  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case "email":
        return TextInputType.emailAddress;
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
        return null;
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
    // 비밀번호 위젯이면, 텍스트 암호화 설정
    if (widget.type == "pw") {
      setState(() {
        _isObscure = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onEditingComplete: _onSubmitted,
      keyboardType: _getKeyboardType(),
      autocorrect: false,
      obscureText: _isObscure,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        suffix: _setSurfix(),
        errorText: widget.errorText,
        errorStyle: const TextStyle(
          fontSize: Sizes.size14,
        ),
        hintText: widget.hintText,
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
