import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class InputWidget extends StatefulWidget {
  final Function? onSubmitted;
  final Function? onNext;
  final TextEditingController controller;
  final String type;
  final String hintText;
  final bool setFocusNode; // input창 포커스 여부
  final TextInputAction textInputAction; // input창 액션 설정
  final String? labelText;
  final String? errorText;
  final int? maxLength;

  const InputWidget({
    super.key,
    // 꼭 필요한 변수
    required this.controller,
    // null이지만 생성할 때 초기화되는 변수
    String? hintText,
    String? type,
    bool? setFocusNode,
    TextInputAction? textInputAction,
    // null이어도 되는 변수
    this.labelText,
    this.errorText,
    this.maxLength,
    this.onSubmitted,
    this.onNext,
  })  : type = type ?? "default",
        hintText = hintText ?? "",
        setFocusNode = setFocusNode ?? false,
        textInputAction = textInputAction ?? TextInputAction.done;

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

  // 🚀 null이 아닌 상속받은 함수 실행
  void _onNext() {
    if (widget.onNext != null) {
      widget.onNext!();
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
      if (widget.setFocusNode) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
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
      onEditingComplete: () => _onSubmitted(), // TextInputAction.done
      onSubmitted: (value) => _onNext(), // TextInputAction.next
      textInputAction: widget.textInputAction,
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

        labelText: widget.labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always, // labelText 고정
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
