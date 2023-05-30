import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class FormInputWidget extends StatefulWidget {
  final String type;
  final String hintText;
  final String? errorText;

  const FormInputWidget({
    super.key,
    required this.type,
    required this.hintText,
    this.errorText,
  });

  @override
  State<FormInputWidget> createState() => _FormInputWidgetState();
}

class _FormInputWidgetState extends State<FormInputWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isObscure = false; // 암호화해서 보여주기

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
    _controller.clear();
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      maxLength: 10,
      onEditingComplete: () {},
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
