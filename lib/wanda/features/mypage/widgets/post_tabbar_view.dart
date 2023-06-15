import 'package:flutter/material.dart';
import 'package:may230517/wanda/constants/sizes.dart';

enum TabbarViewType { post, video }

class PostTabbarView extends StatelessWidget {
  final TabbarViewType type;
  const PostTabbarView({
    super.key,
    required this.type,
  });

  // 🚀 게시글 비율 세팅 함수
  double _setAspectRatio(TabbarViewType type) {
    switch (type) {
      case TabbarViewType.post:
        return 1;
      case TabbarViewType.video:
        return 9 / 16;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
        itemCount: 20,
        keyboardDismissBehavior:
            ScrollViewKeyboardDismissBehavior.onDrag, // 드래그시 키보드 unfocus
        padding: EdgeInsets.only(
          bottom: Sizes.height / 60,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // grid 개수
          crossAxisSpacing: Sizes.size1, // 가로 간격
          mainAxisSpacing: Sizes.size1, // 세로간격
          childAspectRatio: _setAspectRatio(type), // 자식위젯 비율 설정
        ),
        itemBuilder: (context, index) {
          // ✅ 유저 리스트뷰 위젯
          return FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholderFit: BoxFit.contain,
            placeholder: "assets/images/placeholder.png",
            // ✅ 각 게시물 이미지 링크
            image:
                "https://images.unsplash.com/photo-1673844969019-c99b0c933e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1180&q=80",
          );
        },
      ),
    );
  }
}
