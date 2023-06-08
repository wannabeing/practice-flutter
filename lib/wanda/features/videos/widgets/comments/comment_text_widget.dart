import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class CommentTextWidget extends StatefulWidget {
  const CommentTextWidget({
    super.key,
  });

  @override
  State<CommentTextWidget> createState() => _CommentTextWidgetState();
}

class _CommentTextWidgetState extends State<CommentTextWidget> {
  bool _isVisible = false; // 자세히보기 여부

  // 🚀 자세히보기 클릭 함수
  void _onReadmore() {
    _isVisible = !_isVisible;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ 1. 댓글 작성자 프사
        CircleAvatar(
          radius: Sizes.width / 25,
          foregroundImage: const NetworkImage(
              "https://avatars.githubusercontent.com/u/79440384"),
        ),
        Gaps.hwidth40,
        // ✅ 2. 댓글 텍스트 내용
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "닉네임",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Gaps.h3,
                  Text(
                    "3일전",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
              Gaps.v5,
              GestureDetector(
                onTap: () => _onReadmore(),
                child: Text(
                  "댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다",
                  maxLines: _isVisible ? null : 2,
                  overflow:
                      _isVisible ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
              ),
              // ✅ 자세히보기
              if (!_isVisible)
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onReadmore(),
                        child: Text(
                          "자세히보기",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                    Gaps.hwidth30,
                  ],
                ),
            ],
          ),
        ),
        Gaps.hwidth20,
        // ✅ 댓글 좋아요
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            FaIcon(
              FontAwesomeIcons.heart,
              size: Sizes.width / 20,
            ),
            Gaps.v5,
            const Text("123"),
          ],
        ),
      ],
    );
  }
}
