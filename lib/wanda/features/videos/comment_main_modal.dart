import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';
import 'package:may230517/wanda/features/videos/widgets/comments/comment_input_widget.dart';
import 'package:may230517/wanda/features/videos/widgets/comments/comment_text_widget.dart';

class CommentMainModal extends StatefulWidget {
  const CommentMainModal({super.key});

  @override
  State<CommentMainModal> createState() => _CommentMainModalState();
}

class _CommentMainModalState extends State<CommentMainModal> {
  // 🚀 모달창 닫기 함수
  void _onClose() {
    Navigator.of(context).pop();
  }

  // 🚀 키보드창 닫기 함수
  void _onCloseKeyboard() {
    // 키보드 언포커싱 & 키보드 활성화 여부 변경
    FocusScope.of(context).unfocus();
  }

  // 🚀 댓글 전송 함수
  void _submitComment() {
    // 키보드창 닫기
    _onCloseKeyboard();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes.height * 0.7, // 모달창 높이 설정
      clipBehavior: Clip.hardEdge, // 모서리 둥글게 하기 위한 설정
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // 뒤로가기 버튼 false

          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "댓글",
                style: TextStyle(
                  fontSize: Sizes.size22,
                ),
              ),
              Gaps.hwidth40,
              Text(
                "123",
                style: TextStyle(
                  fontSize: Sizes.size18,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => _onClose(),
              icon: const Icon(Icons.close_outlined),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: () => _onCloseKeyboard(),
          child: Column(
            children: [
              // ✅ 1. 댓글창
              Expanded(
                child: Scrollbar(
                  child: ListView.separated(
                    // ✅ 댓글 구분선
                    separatorBuilder: (context, index) {
                      return Column(
                        children: [
                          Gaps.vheight40,
                          Container(
                            width: Sizes.width,
                            height: 1,
                            color: Colors.grey.shade400,
                          ),
                          Gaps.vheight40,
                        ],
                      );
                    },
                    padding: EdgeInsets.only(
                      right: Sizes.width / 20,
                      left: Sizes.width / 20,
                      top: Sizes.height / 40,
                      bottom: Sizes.height / 40,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      // ✅ 댓글 위젯
                      return const CommentTextWidget();
                    },
                  ),
                ),
              ),
              // ✅ 2. 하단고정 댓글입력창
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Container(
                      height: Sizes.height / 10, // 전체적인 높이
                      padding: EdgeInsets.only(
                        left: Sizes.width / 20,
                        right: Sizes.width / 20,
                        top: Sizes.height / 50,
                        bottom: Sizes.height / 40,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(2, 0), // 그림자의 위치 (수평, 수직)
                          ),
                        ],
                      ),
                      child:
                          // ✅ 댓글 인풋 위젯
                          CommentInputWidget(
                        hintText: "댓글 추가...",
                        onSubmit: _submitComment,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
