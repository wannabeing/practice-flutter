import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class CommentInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function onSubmit; // 🚀 텍스트필드 제출 함수
  final Function? onTap; // 🚀 텍스트필드 클릭감지 함수 (사용한다면 _onKeyboard도 사용하자)
  final String? hintText;

  const CommentInputWidget({
    super.key,
    required this.onSubmit,
    required this.controller,
    this.onTap,
    hintText,
  }) : hintText = hintText ?? "";

  @override
  State<CommentInputWidget> createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  bool _onKeboard = false; // 키보드 입력창 활성화 여부

  // 🚀 텍스트필드 클릭감지 함수
  void _onTap() {
    // 키보드 활성화 여부 상태 변경
    _onKeboard = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onTap: () => widget.onTap ?? _onTap(),
      textInputAction: TextInputAction.newline, // 키보드 done을 줄 바꾸기로 변경
      expands: true, // 줄 바꾸기 설정
      minLines: null, // 최소 줄 null로 해야 함
      maxLines: null, // 최대 줄 null로 해야 함
      cursorColor: Theme.of(context).primaryColor,
      style: const TextStyle(color: Colors.black),

      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: Colors.black54,
        ),
        filled: true, // input 채우기
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Sizes.size16, // textfield 내부 padding
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none, // 테두리 활성화 false
        ),
        // ✅ 메시지 전송 아이콘
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            right: Sizes.width / 40,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 키보드창 활성화 되어있을 때만 보여주기
              // ✅ 메시지 전송 함수
              if (_onKeboard && FocusScope.of(context).hasFocus)
                GestureDetector(
                  onTap: () => widget.onSubmit(),
                  child: FaIcon(
                    FontAwesomeIcons.circleArrowUp,
                    size: Sizes.width / 13,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
