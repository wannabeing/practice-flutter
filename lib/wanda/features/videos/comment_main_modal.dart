import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:may230517/wanda/constants/gaps.dart';
import 'package:may230517/wanda/constants/sizes.dart';

class CommentMainModal extends StatefulWidget {
  const CommentMainModal({super.key});

  @override
  State<CommentMainModal> createState() => _CommentMainModalState();
}

class _CommentMainModalState extends State<CommentMainModal> {
  final List<int> _visibleList = []; // 댓글 상세보기 인덱스 리스트

  // 🚀 모달창 닫기 함수
  void _onClose() {
    Navigator.of(context).pop();
  }

  // 🚀 바디부분 탭 감지 함수
  void _onBodyTap() {
    // 키보드 언포커싱
    FocusScope.of(context).unfocus();
  }

  // 🚀 댓글 더보기 함수
  void _toggleReadmore(int index) {
    // 1. 상세보기가 처음인 index일 경우 리스트에 저장
    if (!_visibleList.contains(index)) {
      _visibleList.add(index);
    }
    // 2. 이미 상세보기 상태였던 index의 경우 리스트에서 삭제
    else {
      _visibleList.remove(index);
    }
    setState(() {});
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
          elevation: 1,
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
          onTap: () => _onBodyTap(),
          child: Stack(
            children: [
              ListView.separated(
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
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.width / 20,
                  vertical: Sizes.height / 40,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              onTap: () => _toggleReadmore(index),
                              child: Text(
                                "댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다댓글내용입니다",
                                maxLines:
                                    _visibleList.contains(index) ? null : 2,
                                overflow: _visibleList.contains(index)
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                              ),
                            ),
                            if (!_visibleList.contains(index))
                              GestureDetector(
                                onTap: () => _toggleReadmore(index),
                                child: Text(
                                  "더보기",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Gaps.hwidth20,
                      // ✅ 3. 댓글 좋아요
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
                },
              ),
              // ✅ 댓글창
              Positioned(
                width: Sizes.width,
                bottom: 0,
                child: BottomAppBar(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.width / 20,
                    vertical: Sizes.height / 60,
                  ),
                  elevation: 40,
                  color: Colors.white,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: Sizes.width / 25,
                        foregroundImage: const NetworkImage(
                            "https://avatars.githubusercontent.com/u/79440384"),
                      ),
                      Gaps.hwidth40,
                      // ✅ 텍스트 위젯
                      Expanded(
                        child: SizedBox(
                          height: Sizes.height / 23, // 텍스트창 높이설정
                          child: TextField(
                            textInputAction:
                                TextInputAction.newline, // 키보드 done을 줄 바꾸기로 변경
                            expands: true, // 줄 바꾸기 설정
                            minLines: null, // 최소 줄 null로 해야 함
                            maxLines: null, // 최대 줄 null로 해야 함
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none, // 테두리 활성화 false
                              ),
                              hintText: "댓글 추가...",
                              filled: true, // input 채우기
                              fillColor: Colors.grey.shade300,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
